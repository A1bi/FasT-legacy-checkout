//
//  ScannerViewController.m
//  FasTcheckout
//
//  Created by Albrecht Oster on 04.06.12.
//  Copyright (c) 2012 Albisigns. All rights reserved.
//

#import "ScannerViewController.h"
#import "TicketsTableViewController.h"
#import "Ticket.h"
#import "OrderStore.h"
#import "AudioToolbox/AudioServices.h"

@interface ScannerViewController ()

- (NSDictionary *)parseTicketData:(ZBarSymbolSet *)data;
- (BOOL)addTicketWithSId:(NSString *)sId;
- (void)resetTickets;

@end

@implementation ScannerViewController

@synthesize numberField;
@synthesize ticketCounter;
@synthesize scanBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		scanner = [[BarScannerViewController alloc] init];
		[scanner setReaderDelegate:self];
		tickets = [[NSMutableArray alloc] init];
		
		UIImage *image = [[[UIImage alloc] init] autorelease];
		UITabBarItem *item = [[[UITabBarItem alloc] initWithTitle:@"Einlesen" image:image tag:0] autorelease];
		[self setTabBarItem:item];
		
		[[self navigationItem] setTitle:@"Tickets einlesen"];
    }
	
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[self resetTickets];
}

- (void)viewDidUnload
{
	[self setScanBtn:nil];
	[self setNumberField:nil];
	[self setTicketCounter:nil];
	
    [super viewDidUnload];
}

- (void)dealloc {
	[scanBtn release];
	[scanner release];
	[numberField release];
	[ticketCounter release];
	[tickets release];
	
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
		return NO;
	}
	
	return NO;
}

#pragma mark methods

- (IBAction)showScanner:(id)sender
{
	[scanner updateCounter:0];
	[self presentModalViewController:scanner animated:YES];
}

- (IBAction)checkId:(id)sender
{
	[self addTicketWithSId:[numberField text]];
	[numberField setText:nil];
}

- (IBAction)showTickets:(id)sender {
	TicketsTableViewController *tvc = [[[TicketsTableViewController alloc] initWithTickets:tickets] autorelease];
	
	[numberField resignFirstResponder];
	[[self navigationController] pushViewController:tvc animated:YES];
}

- (IBAction)tappedReset:(id)sender {
	[self resetTickets];
	[numberField resignFirstResponder];
}

- (BOOL)addTicketWithSId:(NSString *)sId
{
	NSNumberFormatter *formatter = [[[NSNumberFormatter alloc] init] autorelease];
	[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
	NSNumber *number = [formatter numberFromString:sId];

	Ticket *ticket = [[OrderStore defaultStore] ticketWithSId:number];
	if (!ticket) return false;
	
	for (Ticket *ticket in tickets) {
		if ([[ticket sId] compare:number] == NSOrderedSame) return false;
	}
	
	[tickets addObject:ticket];
	
	AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
	[ticketCounter setText:[NSString stringWithFormat:@"%d Tickets eingelesen.", [tickets count]]];
	
	return true;
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
	
	return ticketInfo;
}

- (void)resetTickets
{
	[tickets removeAllObjects];
	
	[ticketCounter setText:@"Keine Tickets eingelesen"];
}

#pragma mark reader delegate

- (void)imagePickerController:(UIImagePickerController *)reader didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	ZBarSymbolSet *results = [info objectForKey: ZBarReaderControllerResults];	
	if ([self addTicketWithSId:[[self parseTicketData:results] objectForKey:@"ticket"]]) {
		[scanner updateCounter:[tickets count]];
	}
}

#pragma mark overlay actions

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[picker dismissModalViewControllerAnimated:YES];
}

@end
