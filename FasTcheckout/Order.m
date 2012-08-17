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
		
		NSMutableDictionary *tmpTickets = [NSMutableDictionary dictionary];
		for (NSDictionary *ticketInfo in [info objectForKey:@"tickets"]) {
			Ticket *ticket = [[Ticket alloc] initWithInfo:ticketInfo order:self];
			[tmpTickets setObject:ticket forKey:[ticket sId]];
		}
		
		tickets = [[tmpTickets copy] retain];
	}
	
	return self;
}

@end
