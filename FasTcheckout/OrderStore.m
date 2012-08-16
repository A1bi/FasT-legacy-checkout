//
//  OrderStore.m
//  FasTcheckout
//
//  Created by Albrecht Oster on 16.08.12.
//  Copyright (c) 2012 Albisigns. All rights reserved.
//

#import "OrderStore.h"
#import "Order.h"

static OrderStore *defaultStore = nil;

@implementation OrderStore

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
		NSError *error = nil;
		NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://fast.albisigns/api?action=getOrders&date=1"]];
		NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
		if (error) NSLog(@"%@", error);
		
		NSDictionary *result = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:&error];
		if (error) NSLog(@"%@", error);
		
		NSMutableDictionary *tmpOrders = [NSMutableDictionary dictionary];
		for (NSDictionary *orderInfo in [result objectForKey:@"orders"]) {
			Order* order = [[[Order alloc] initWithInfo:orderInfo] autorelease];
			[tmpOrders setObject:order forKey:[order sId]];
		}
		
		orders = [[tmpOrders copy] retain];
	}
	
	return self;
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

@end
