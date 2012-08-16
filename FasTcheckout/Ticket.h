//
//  Ticket.h
//  FasTcheckout
//
//  Created by Albrecht Oster on 05.06.12.
//  Copyright (c) 2012 Albisigns. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Order;

@interface Ticket : NSObject
{
	int dId, sId;
	BOOL voided, cancelled;
	NSDate *date;
	NSString *cancelReason;
	Order *order;
}

@property (nonatomic, readonly) int dId, sId;
@property (nonatomic, readonly) BOOL voided, cancelled;
@property (nonatomic, readonly) NSDate *date;

- (id)initWithInfo:(NSDictionary *)info;

- (BOOL)isValid;

@end
