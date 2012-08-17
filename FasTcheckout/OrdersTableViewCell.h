//
//  TicketsTableViewCell.h
//  FasTcheckout
//
//  Created by Albrecht Oster on 17.08.12.
//  Copyright (c) 2012 Albisigns. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Order;

@interface OrdersTableViewCell : UITableViewCell
{
	Order *order;
}

@property (nonatomic, retain) Order *order;

- (id)initWithReuseIdentifier:(NSString *)reuse;

@end
