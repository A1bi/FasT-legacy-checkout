//
//  TicketsTableViewController.m
//  FasTcheckout
//
//  Created by Albrecht Oster on 17.08.12.
//  Copyright (c) 2012 Albisigns. All rights reserved.
//

#import "TicketsTableViewController.h"
#import "TicketsTableViewCell.h"
#import "Ticket.h"
#import "OrderStore.h"
#import "Order.h"

@interface TicketsTableViewController ()

- (void)voidTickets:(id)sender;

@end

@implementation TicketsTableViewController

- (id)initWithTickets:(NSArray *)t
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
		tickets = [t retain];
		
		numbers = [[NSMutableArray alloc] init];
		for (NSString *ticketType in [[OrderStore defaultStore] ticketTypes]) {
			[numbers addObject:[NSNumber numberWithInt:0]];
		}
		
		for (Ticket *ticket in tickets) {
			NSNumber *currentNumber = [numbers objectAtIndex:[ticket type]];
			[numbers replaceObjectAtIndex:[ticket type] withObject:[NSNumber numberWithInt:[currentNumber intValue] + 1]];
			
			if (![[ticket order] paid]) {
				int single = 0, type = [ticket type];
				if (type == 1) {
					single = 6;
				} else if (type == 2) {
					single = 12;
				} else if (type == 3) {
					single = 10;
				}
			
				toPay += single;
			}
		}
		
		UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(voidTickets:)];
		[[self navigationItem] setTitle:@"Tickets"];
		[[self navigationItem] setRightBarButtonItem:bbi];
    }
	
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)dealloc
{
	[tickets release];
	
	[super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tickets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *reuse = @"TicketCell";
    TicketsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
	if (!cell) {
		cell = [[[TicketsTableViewCell alloc] initWithReuseIdentifier:reuse] autorelease];
	}
	
	[cell setTicket:[tickets objectAtIndex:[indexPath row]]];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
	return [NSString stringWithFormat:@"%d € zu zahlen!", toPay];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	NSMutableString *title = [[NSMutableString alloc] init];
	
	int i = 0;
	for (NSString *ticketType in [[OrderStore defaultStore] ticketTypes]) {
		NSNumber *number = [numbers objectAtIndex:i];
		if ([number intValue] > 0) {
			[title appendFormat:@"%@ %@ | ", number, ticketType];
		}
		i++;
	}

	return title;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
}

- (void)voidTickets:(id)sender
{
	for (Ticket *ticket in tickets) {
		[ticket voidIt];
	}
	
	[[self tableView] reloadData];
}

@end
