//
//  OrdersTableViewController.m
//  FasTcheckout
//
//  Created by Albrecht Oster on 17.08.12.
//  Copyright (c) 2012 Albisigns. All rights reserved.
//

#import "OrdersTableViewController.h"
#import "OrdersTableViewCell.h"
#import "OrderStore.h"
#import "TicketsTableViewController.h"
#import "Order.h"

@interface OrdersTableViewController ()

@end

@implementation OrdersTableViewController

- (id)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
		[[self navigationItem] setTitle:@"Bestellungen"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[OrderStore defaultStore] orders] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuse = @"TicketCell";
	OrdersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
	if (!cell) {
		cell = [[OrdersTableViewCell alloc] initWithReuseIdentifier:reuse];
	}
	
	NSArray *orders = [[[OrderStore defaultStore] orders] allValues];
	[cell setOrder:[orders objectAtIndex:[indexPath row]]];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *orders = [[[OrderStore defaultStore] orders] allValues];
	Order *order = [orders objectAtIndex:[indexPath row]];
	
	TicketsTableViewController *tvc = [[TicketsTableViewController alloc] initWithTickets:[[order tickets] allValues]];
	[[self navigationController] pushViewController:tvc animated:YES];
}

@end
