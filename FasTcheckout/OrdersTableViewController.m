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
		[[self navigationItem] setTitle:@"Buchungen"];
		
		UIImage *image = [[[UIImage alloc] init] autorelease];
		UITabBarItem *item = [[[UITabBarItem alloc] initWithTitle:@"Buchungen" image:image tag:0] autorelease];
		[self setTabBarItem:item];
		
		sortedOrders = [[[[OrderStore defaultStore] orders] keysSortedByValueUsingSelector:@selector(compareByName:)] retain];
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
	static NSString *reuse = @"TicketCell";
	OrdersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
	if (!cell) {
		cell = [[[OrdersTableViewCell alloc] initWithReuseIdentifier:reuse] autorelease];
	}
	
	Order *order = [[OrderStore defaultStore] orderWithSId:[sortedOrders objectAtIndex:[indexPath row]]];
	[cell setOrder:order];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *tickets = [[(OrdersTableViewCell *)[tableView cellForRowAtIndexPath:indexPath] order] tickets];
	
	TicketsTableViewController *tvc = [[[TicketsTableViewController alloc] initWithTickets:tickets] autorelease];
	[[self navigationController] pushViewController:tvc animated:YES];
}

@end
