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

@synthesize dId, sId, voided, date, cancelled, order;

- (id)initWithInfo:(NSDictionary *)info order:(Order *)o
{
	self = [super init];
	if (self) {
		NSNumberFormatter *formatter = [[[NSNumberFormatter alloc] init] autorelease];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		
		dId = [formatter numberFromString:[info objectForKey:@"id"]];
		sId = [formatter numberFromString:[info objectForKey:@"sId"]];
		
		//date = [[NSDate dateWithTimeIntervalSince1970:[[info objectForKey:@"date"] intValue]] retain];
		//voided = ([[info objectForKey:@"void"] compare:@"true" options:nil]) ? YES : NO;
		
		order = o;
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
