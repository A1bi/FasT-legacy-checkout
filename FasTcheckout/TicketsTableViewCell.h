//
//  TicketsTableViewCell.h
//  FasTcheckout
//
//  Created by Albrecht Oster on 17.08.12.
//  Copyright (c) 2012 Albisigns. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Ticket;

@interface TicketsTableViewCell : UITableViewCell
{
	Ticket *ticket;
}

@property (nonatomic, retain) Ticket *ticket;

- (id)initWithReuseIdentifier:(NSString *)reuse;

@end
