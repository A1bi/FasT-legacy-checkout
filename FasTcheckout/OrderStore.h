//
//  OrderStore.h
//  FasTcheckout
//
//  Created by Albrecht Oster on 16.08.12.
//  Copyright (c) 2012 Albisigns. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Order, Ticket;

@interface OrderStore : NSObject
{
	NSDictionary *orders, *tickets;
	NSArray *ticketTypes;
}

+ (OrderStore *)defaultStore;

- (Order *)orderWithSId:(NSNumber *)sId;
- (Ticket *)ticketWithSId:(NSNumber *)sId;

@property (nonatomic, readonly) NSDictionary *orders;
@property (nonatomic, readonly) NSArray *ticketTypes;

@end
