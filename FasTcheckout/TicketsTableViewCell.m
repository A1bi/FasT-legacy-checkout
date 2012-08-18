//
//  TicketsTableViewCell.m
//  FasTcheckout
//
//  Created by Albrecht Oster on 17.08.12.
//  Copyright (c) 2012 Albisigns. All rights reserved.
//

#import "TicketsTableViewCell.h"
#import "Ticket.h"
#import "Order.h"

@implementation TicketsTableViewCell

@synthesize ticket;

- (id)initWithReuseIdentifier:(NSString *)reuse
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuse];
    if (self) {
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
	
    return self;
}

- (void)dealloc
{
	[ticket release];
	
	[super dealloc];
}

- (void)setTicket:(Ticket *)t
{
	[ticket release];
	ticket = [t retain];
	
	Order *order = [ticket order];
	
	NSDictionary *address = [order address];
	[[self textLabel] setText:[NSString stringWithFormat:@"%@ | %@ %@", [ticket sId], [address objectForKey:@"firstname"], [address objectForKey:@"lastname"]]];
	
	NSString *text = @"Ok";
	if ([[ticket voided] timeIntervalSince1970] > 0) {
		text = @"Bereits eingelöst!";
		
	} else if ([order type] == OrderTypeFree) {
		text = @"Freikarte";
	
	} else if ([ticket cancelled]) {
		text = @"Storniert";
		
	} else if (![order paid]) {
		if ([order payMethod] == OrderPayMethodCashLater) {
			text = @"Muss an Abendkasse bezahlen!";
		} else {
			text = @"Nicht bezahlt!";
		}
	
	}
	
	[[self detailTextLabel] setText:text];
}

@end
