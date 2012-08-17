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
	NSNumber *dId, *sId;
	BOOL cancelled;
	NSDate *voided, *date;
	NSString *cancelReason;
	Order *order;
}

@property (nonatomic, readonly) NSNumber *dId, *sId;
@property (nonatomic, readonly) BOOL cancelled;
@property (nonatomic, readonly) NSDate *date, *voided;
@property (nonatomic, readonly) Order* order;

- (id)initWithInfo:(NSDictionary *)info order:(Order *)o;

- (void)voidIt;
- (BOOL)isValid;

@end
