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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *orders = [[[OrderStore defaultStore] orders] allValues];
	Order *order = [orders objectAtIndex:[indexPath row]];
	
	TicketsTableViewController *tvc = [[TicketsTableViewController alloc] initWithTickets:[[order tickets] allValues]];
	[[self navigationController] pushViewController:tvc animated:YES];
}

@end
