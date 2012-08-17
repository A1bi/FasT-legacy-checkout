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

@interface TicketsTableViewController ()

- (void)voidTickets:(id)sender;

@end

@implementation TicketsTableViewController

- (id)initWithTickets:(NSArray *)t
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
		tickets = [t retain];
		
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
	NSString *reuse = @"TicketCell";
    TicketsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
	if (!cell) {
		cell = [[TicketsTableViewCell alloc] initWithReuseIdentifier:reuse];
	}
	
	[cell setTicket:[tickets objectAtIndex:[indexPath row]]];
    
    return cell;
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
