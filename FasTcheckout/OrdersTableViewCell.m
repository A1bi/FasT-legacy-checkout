//
//  TicketsTableViewCell.m
//  FasTcheckout
//
//  Created by Albrecht Oster on 17.08.12.
//  Copyright (c) 2012 Albisigns. All rights reserved.
//

#import "OrdersTableViewCell.h"
#import "Ticket.h"
#import "Order.h"

@implementation OrdersTableViewCell

@synthesize order;

- (id)initWithReuseIdentifier:(NSString *)reuse
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuse];
    if (self) {
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
		
    }
	
    return self;
}

- (void)setOrder:(Order *)o
{
	[order release];
	order = [o retain];
	
	NSDictionary *address = [order address];
	[[self textLabel] setText:[NSString stringWithFormat:@"%@ %@ (%@)", [address objectForKey:@"firstname"], [address objectForKey:@"lastname"], [address objectForKey:@"affiliation"]]];
	[[self detailTextLabel] setText:[NSString stringWithFormat:@"%u Tickets", [[order tickets] count]]];
}

@end
