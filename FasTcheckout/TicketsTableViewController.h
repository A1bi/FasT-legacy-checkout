//
//  TicketsTableViewController.h
//  FasTcheckout
//
//  Created by Albrecht Oster on 17.08.12.
//  Copyright (c) 2012 Albisigns. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TicketsTableViewController : UITableViewController
{
	NSArray *tickets;
	NSMutableArray *numbers;
	int toPay;
}

- (id)initWithTickets:(NSArray *)t;

@end
