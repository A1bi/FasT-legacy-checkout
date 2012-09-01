//
//  Ticket.m
//  FasTcheckout
//
//  Created by Albrecht Oster on 05.06.12.
//  Copyright (c) 2012 Albisigns. All rights reserved.
//

#import "Ticket.h"
#import "Order.h"
#import "APIManager.h"

@implementation Ticket

@synthesize dId, sId, voided, date, cancelled, order, type;

- (id)initWithInfo:(NSDictionary *)info order:(Order *)o
{
	self = [super init];
	if (self) {
		NSNumberFormatter *formatter = [[[NSNumberFormatter alloc] init] autorelease];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		
		dId = [[formatter numberFromString:[info objectForKey:@"id"]] retain];
		sId = [[formatter numberFromString:[info objectForKey:@"sId"]] retain];
		type = [[info objectForKey:@"type"] intValue];
		voided = [[NSDate dateWithTimeIntervalSince1970:[[info objectForKey:@"voided"] intValue]] retain];
		
		order = o;
	}
	
	return self;
}

- (void)dealloc
{
	[dId release];
	[sId release];
	[voided release];
	[date release];
	[cancelReason release];
	
	[super dealloc];
}

- (void)voidIt
{
	[voided release];
	voided = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
	
	[[APIManager defaultManager] voidTicket:self];
}

- (BOOL)isValid
{
	return ([order paid] && !cancelled && [voided timeIntervalSince1970] < 1);
}

@end
