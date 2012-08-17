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

@interface ScannerViewController ()

- (NSDictionary *)parseTicketData:(ZBarSymbolSet *)data;
- (void)addTicketWithSId:(NSString *)sId;
- (void)dismissScanner:(id)sender;
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
		tickets = [[NSMutableArray alloc] init];
		
		UITabBarItem *item = [[[UITabBarItem alloc] initWithTitle:@"Scanner" image:nil tag:0] autorelease];
		[[self navigationController] setTabBarItem:item];
		[[self navigationItem] setTitle:@"Ticket scannen"];
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
	[readerVC release];
	
	[numberField release];
	[ticketCounter release];
    [super dealloc];
}

#pragma mark methods

- (IBAction)showScanner:(id)sender
{
	readerVC = [[ZBarReaderViewController alloc] init];
	[readerVC setReaderDelegate:self];
	
	// only enable code39
	[[readerVC scanner] setSymbology:0 config:ZBAR_CFG_ENABLE to:0];
	[[readerVC scanner] setSymbology:ZBAR_CODE39 config:ZBAR_CFG_ENABLE to:1];
	
	// interface
	[readerVC setShowsZBarControls:NO];
	
	CGRect cameraFrame = [[readerVC view] frame];
	UIView *controls = [[[UIView alloc] initWithFrame:cameraFrame] autorelease];
	
	UIToolbar *bar = [[[UIToolbar alloc] initWithFrame:CGRectMake(0, cameraFrame.origin.y + cameraFrame.size.height - 44, cameraFrame.size.width, 44)] autorelease];
	UIBarButtonItem *button = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissScanner:)] autorelease];
	[bar setItems:[NSArray arrayWithObject:button]];
	[controls addSubview:bar];
	
	[readerVC setCameraOverlayView:controls];
	
	[self presentModalViewController:readerVC animated:YES];
}

- (IBAction)checkId:(id)sender
{
	[self addTicketWithSId:[numberField text]];
	[numberField setText:nil];
}

- (IBAction)showTickets:(id)sender {
	TicketsTableViewController *tvc = [[TicketsTableViewController alloc] initWithTickets:tickets];
	
	[numberField resignFirstResponder];
	[[self navigationController] pushViewController:tvc animated:YES];
}

- (IBAction)tappedReset:(id)sender {
	[self resetTickets];
	[numberField resignFirstResponder];
}

- (void)addTicketWithSId:(NSString *)sId
{
	NSNumberFormatter *formatter = [[[NSNumberFormatter alloc] init] autorelease];
	[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
	NSNumber *number = [formatter numberFromString:sId];

	Ticket *ticket = [[OrderStore defaultStore] ticketWithSId:number];
	if (!ticket) return;
	
	for (Ticket *ticket in tickets) {
		if ([[ticket sId] compare:number] == NSOrderedSame) return;
	}
	
	[tickets addObject:ticket];
	
	[ticketCounter setText:[NSString stringWithFormat:@"%d Tickets eingelesen.", [tickets count]]];
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
	[self addTicketWithSId:[[self parseTicketData:results] objectForKey:@"ticket"]];
}

#pragma mark overlay actions

- (void)dismissScanner:(id)sender
{
	[readerVC dismissModalViewControllerAnimated:YES];
}

@end
