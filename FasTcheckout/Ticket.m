//
//  Ticket.m
//  FasTcheckout
//
//  Created by Albrecht Oster on 05.06.12.
//  Copyright (c) 2012 Albisigns. All rights reserved.
//

#import "Ticket.h"

#import "Order.h"

@implementation Ticket

@synthesize dId, sId, voided, date, cancelled;

- (id)initWithInfo:(NSDictionary *)info
{
	self = [super init];
	if (self) {
		dId = [[info objectForKey:@"id"] intValue];
		sId = [[info objectForKey:@"sId"] intValue];
		date = [[NSDate dateWithTimeIntervalSince1970:[[info objectForKey:@"date"] intValue]] retain];
		//voided = ([[info objectForKey:@"void"] compare:@"true" options:nil]) ? YES : NO;
	}
	
	return self;
}

- (void)dealloc
{
	[date release];
	
	[super dealloc];
}

- (BOOL)isValid
{
	return (!cancelled && !voided && [order paid]);
}

@end
