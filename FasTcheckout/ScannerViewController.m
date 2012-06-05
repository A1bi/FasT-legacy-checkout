//
//  ScannerViewController.m
//  FasTcheckout
//
//  Created by Albrecht Oster on 04.06.12.
//  Copyright (c) 2012 Albisigns. All rights reserved.
//

#import "ScannerViewController.h"

@interface ScannerViewController ()

- (NSDictionary *)parseTicketData:(ZBarSymbolSet *)data;
- (void)showTicketDetailsWithInfo:(NSDictionary *)ticketInfo;

@end

@implementation ScannerViewController
@synthesize scanBtn;
@synthesize spinner;
@synthesize dataLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
	[self setScanBtn:nil];
	[self setSpinner:nil];	
	[self setDataLabel:nil];
	
    [super viewDidUnload];
}

- (void)dealloc {
	[scanBtn release];
	[spinner release];
	[dataLabel release];
	
    [super dealloc];
}

#pragma mark methods

- (IBAction)showScanner:(id)sender
{
	ZBarReaderViewController *reader = [ZBarReaderViewController new];
	[reader setReaderDelegate:self];
	
	// only enable code39
	[[reader scanner] setSymbology:0 config:ZBAR_CFG_ENABLE to:0];
	[[reader scanner] setSymbology:ZBAR_CODE39 config:ZBAR_CFG_ENABLE to:1];
	
	// interface
	[reader setShowsZBarControls:NO];
	
	[self presentModalViewController:reader animated:YES];
}

- (NSDictionary *)parseTicketData:(ZBarSymbolSet *)data
{
	NSString *code = nil;
	// only get first result
	for (ZBarSymbol *result in data) {
		code = [result data];
		break;
	}
	
	// split ON and TN and create ticket info
	NSMutableDictionary *ticketInfo = [NSMutableDictionary dictionaryWithCapacity:2];
	NSMutableString *number = [NSMutableString string];
	NSString *currentNumber = nil;
	
	int characters = [code length];
	for (int i = 0; i < characters; i++) {
		unichar figure = [code characterAtIndex:i];
		
		if (figure == 'O' || figure == 'T') {
			if (currentNumber) {
				[ticketInfo setObject:number forKey:currentNumber];
			}
			
			if (figure == 'O') {
				currentNumber = @"order";
			} else if (figure == 'T') {
				currentNumber = @"ticket";
			}
			
			number = [NSMutableString string];
		
		} else {
			[number appendFormat:@"%c", figure];
		}
	}
	
	if (currentNumber) {
		[ticketInfo setObject:number forKey:currentNumber];
	}
	
	NSLog(@"%@", [ticketInfo objectForKey:@"order"]);
	[dataLabel setText:code];
	
	return ticketInfo;
}

- (void)showTicketDetailsWithInfo:(NSDictionary *)ticketInfo
{
	[dataLabel setText:[NSString stringWithFormat:@"Ticket: %@ for order: %@", [ticketInfo objectForKey:@"ticket"], [ticketInfo objectForKey:@"order"]]];
}

#pragma mark reader delegate

- (void)imagePickerController:(UIImagePickerController *)reader didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[reader dismissModalViewControllerAnimated:YES];
	
	ZBarSymbolSet *results =
	[info objectForKey: ZBarReaderControllerResults];
	
	[spinner startAnimating];
	[self showTicketDetailsWithInfo:[self parseTicketData:results]];
	[spinner stopAnimating];
}

@end
