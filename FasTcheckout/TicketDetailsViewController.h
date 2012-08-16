//
//  TicketDetailsViewController.h
//  FasTcheckout
//
//  Created by Albrecht Oster on 04.06.12.
//  Copyright (c) 2012 Albisigns. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarReaderViewController.h"

@class Ticket;

@interface TicketDetailsViewController : UIViewController <UITableViewDataSource>
{
	Ticket *ticket;
}

@property (retain, nonatomic) IBOutlet UITableView *tableView;

- (id)initWithTicket:(Ticket *)t;

@end
