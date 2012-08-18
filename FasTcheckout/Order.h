//
//  Order.h
//  FasTcheckout
//
//  Created by Albrecht Oster on 16.08.12.
//  Copyright (c) 2012 Albisigns. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, OrderType) {
	OrderTypeOnline,
	OrderTypeManual,
	OrderTypeFree
};

typedef NS_ENUM(NSUInteger, OrderPayMethod) {
	OrderPayMethodNone,
	OrderPayMethodCharge,
	OrderPayMethodTransfer,
	OrderPayMethodCashUpFront,
	OrderPayMethodCashLater
};

@interface Order : NSObject
{
	NSNumber *dId, *sId, *total;
	OrderType type;
	OrderPayMethod payMethod;
	NSDictionary *address, *cancelled;
	NSArray *tickets;
	BOOL paid;
	NSString *notes;
}

@property (nonatomic, readonly) NSNumber *dId, *sId, *total;
@property (nonatomic, readonly) OrderType type;
@property (nonatomic, readonly) OrderPayMethod payMethod;
@property (nonatomic, readonly) NSDictionary *address, *cancelled;
@property (nonatomic, readonly) NSArray *tickets;
@property (nonatomic, readonly) BOOL paid;
@property (nonatomic, readonly) NSString *notes;

- (id)initWithInfo:(NSDictionary *)info;

@end
