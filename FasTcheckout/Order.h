//
//  Order.h
//  FasTcheckout
//
//  Created by Albrecht Oster on 16.08.12.
//  Copyright (c) 2012 Albisigns. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum { Online, Manual, Free } OrderType;
typedef enum { None, Charge, Transfer, CashUpFront, CashLater } OrderPayMethod;

@interface Order : NSObject
{
	NSNumber *dId, *sId, *total;
	OrderType type;
	OrderPayMethod payMethod;
	NSDictionary *address, *cancelled;
	BOOL paid;
	NSString *notes;
	NSArray *tickets;
}

@property (nonatomic, readonly) NSNumber *dId, *sId, *total;
@property (nonatomic, readonly) OrderType type;
@property (nonatomic, readonly) OrderPayMethod payMethod;
@property (nonatomic, readonly) NSDictionary *address, *cancelled;
@property (nonatomic, readonly) BOOL paid;
@property (nonatomic, readonly) NSString *notes;
@property (nonatomic, readonly) NSArray *tickets;

- (id)initWithInfo:(NSDictionary *)info;

@end
