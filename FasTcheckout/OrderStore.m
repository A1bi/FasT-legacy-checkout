//
//  OrderStore.m
//  FasTcheckout
//
//  Created by Albrecht Oster on 16.08.12.
//  Copyright (c) 2012 Albisigns. All rights reserved.
//

#import "OrderStore.h"
#import "Order.h"
#import "Ticket.h"
#import "APIManager.h"

static OrderStore *defaultStore = nil;

@interface OrderStore ()



@end

@implementation OrderStore

@synthesize orders, ticketTypes;

+ (OrderStore *)defaultStore
{
	if (!defaultStore) {
		defaultStore = [[super allocWithZone:NULL] init];
	}
	
	return defaultStore;
}

+ (id)allocWithZone:(NSZone *)zone
{
	return [self defaultStore];
}


- (id)init
{
	if (defaultStore) {
		return defaultStore;
	}
	
	self = [super init];
	if (self) {
		[[APIManager defaultManager] getAllWithCompletion:^(NSDictionary *ordersInfo) {
			
			NSMutableDictionary *tmpOrders = [NSMutableDictionary dictionary];
			NSMutableDictionary *tmpTickets = [NSMutableDictionary dictionary];
			for (NSDictionary *orderInfo in ordersInfo) {
				Order* order = [[[Order alloc] initWithInfo:orderInfo] autorelease];
				[tmpOrders setObject:order forKey:[order sId]];
				
				for (Ticket *ticket in [order tickets]) {
					[tmpTickets setObject:ticket forKey:[ticket sId]];
				}
			}
			
			[orders release];
			orders = [[tmpOrders copy] retain];
			[tickets release];
			tickets = [[tmpTickets copy] retain];
			
		}];
		
		ticketTypes = [[NSArray alloc] initWithObjects:@"Freikarte", @"Ermäßigt", @"Erwachsene", @"Erwachsene (Gruppe)", nil];
	}
	
	return self;
}

- (void)dealloc
{
	[orders release];
	[tickets release];
	[ticketTypes release];
	
	[super dealloc];
}

- (id)retain
{
	return self;
}

- (oneway void)release
{
	return;
}

- (NSUInteger)retainCount
{
	return 2;
}

- (Order *)orderWithSId:(NSNumber *)sId
{
	return [orders objectForKey:sId];
}

- (Ticket *)ticketWithSId:(NSNumber *)sId
{
	return [tickets objectForKey:sId];
}

@end
