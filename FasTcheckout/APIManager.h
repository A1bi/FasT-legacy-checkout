//
//  APIManager.h
//  FasTcheckout
//
//  Created by Albrecht Oster on 24.08.12.
//  Copyright (c) 2012 Albisigns. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Ticket;
@class MKNetworkEngine;

@interface APIManager : NSObject
{
	NSMutableArray *voidTickets;
	NSTimer *processTimer;
	MKNetworkEngine *netEngine;
}

+ (APIManager *)defaultManager;

- (void)voidTicket:(Ticket *)ticket;
- (void)getAllWithCompletion:(void (^)(NSDictionary *))completion;

@end
