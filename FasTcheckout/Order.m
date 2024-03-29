//
//  Order.m
//  FasTcheckout
//
//  Created by Albrecht Oster on 16.08.12.
//  Copyright (c) 2012 Albisigns. All rights reserved.
//

#import "Order.h"
#import "Ticket.h"

@implementation Order

@synthesize dId, sId, total, type, address, cancelled, paid, notes, tickets, payMethod;

- (id)initWithInfo:(NSDictionary *)info
{
	self = [super init];
	if (self) {
		NSNumberFormatter *formatter = [[[NSNumberFormatter alloc] init] autorelease];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		
		dId = [[formatter numberFromString:[info objectForKey:@"id"]] retain];
		sId = [[formatter numberFromString:[info objectForKey:@"sId"]] retain];
		total = [[formatter numberFromString:[info objectForKey:@"total"]] retain];
		
		type = [[info objectForKey:@"type"] intValue];
		payMethod = [[info objectForKey:@"payMethod"] intValue];
		paid = [[info objectForKey:@"paid"] boolValue];
		
		address = [[info objectForKey:@"address"] retain];
		cancelled = [[info objectForKey:@"cancelled"] retain];
		notes = [[info objectForKey:@"notes"] retain];
		
		NSMutableArray *tmpTickets = [NSMutableArray array];
		for (NSDictionary *ticketInfo in [info objectForKey:@"tickets"]) {
			Ticket *ticket = [[Ticket alloc] initWithInfo:ticketInfo order:self];
			[tmpTickets addObject:ticket];
		}
		
		tickets = [[tmpTickets copy] retain];
	}
	
	return self;
}

- (void)dealloc
{
	[dId release];
	[sId release];
	[total release];
	[address release];
	[cancelled release];
	[tickets release];
	[notes release];
	
	[super dealloc];
}

- (NSComparisonResult)compareByName:(Order *)order
{
	NSDictionary *oAddress = [order address];
	NSComparisonResult result;
	
	NSArray *keys = [NSArray arrayWithObjects:@"lastname", @"firstname", nil];
	for (NSString *key in keys) {
		result = [[address objectForKey:key] compare:[oAddress objectForKey:key] options:NSCaseInsensitiveSearch];
		if (result != NSOrderedSame) {
			return result;
		}
	}
	
	return NSOrderedSame;
}

@end
