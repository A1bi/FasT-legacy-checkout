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
	NSMutableString *name = [NSMutableString string];
	
	NSArray *keys = [NSArray arrayWithObjects:@"firstname", @"lastname", @"affiliation", nil];
	int i = 0;
	for (NSString *key in keys) {
		NSString *value = [address objectForKey:key];
		if ([value length]) {
			NSString *format = @"%@ ";
			if (i == 2) {
				format = @"(%@)";
			}
			
			[name appendFormat:format, value];
		}
		
		i++;
	}
	
	[[self textLabel] setText:name];
	[[self detailTextLabel] setText:[NSString stringWithFormat:@"%u Tickets", [[order tickets] count]]];
}

- (void)dealloc
{
	[order release];
	
	[super dealloc];
}

@end
