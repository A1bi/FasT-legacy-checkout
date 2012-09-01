//
//  APIManager.m
//  FasTcheckout
//
//  Created by Albrecht Oster on 24.08.12.
//  Copyright (c) 2012 Albisigns. All rights reserved.
//

#import "APIManager.h"
#import "Ticket.h"
#import "MKNetworkKit.h"

static APIManager *defaultManager = nil;

@interface APIManager ()

- (void)processJobsDelayed;
- (void)processJobs;
- (void)makeRequestWithAction:(NSString *)action arguments:(NSDictionary *)args;
- (void)makeRequestWithAction:(NSString *)action arguments:(NSDictionary *)args onCompletion:(void (^)(NSDictionary *))completion;
- (void)stopTimer;

@end

@implementation APIManager

+ (APIManager *)defaultManager
{
	if (!defaultManager) {
		defaultManager = [[super allocWithZone:NULL] init];
	}
	
	return defaultManager;
}

+ (id)allocWithZone:(NSZone *)zone
{
	return [self defaultManager];
}

- (id)init
{
	if (defaultManager) {
		return defaultManager;
	}
	
	self = [super init];
	if (self) {
		processTimer = nil;
		voidTickets = [[NSMutableArray alloc] init];
		
		netEngine = [[MKNetworkEngine alloc] initWithHostName:@"fast.albisigns"];
	}
	
	return self;
}

- (void)dealloc
{
	[voidTickets release];
	[self stopTimer];
	[netEngine release];
	
	[super dealloc];
}

- (void)voidTicket:(Ticket *)ticket
{
	[voidTickets addObject:ticket];
	[self processJobsDelayed];
}

- (void)processJobsDelayed
{
	[processTimer invalidate];
	[processTimer release];
	
	processTimer = [[NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(processJobs) userInfo:nil repeats:NO] retain];
}

- (void)processJobs
{
	if ([voidTickets count]) {
		NSMutableArray *tickets = [NSMutableArray array];
		for (Ticket *ticket in voidTickets) {
			NSDictionary *ticketInfo = [NSDictionary dictionaryWithObjectsAndKeys:[ticket dId], @"id", [NSNumber numberWithDouble:[[ticket voided] timeIntervalSince1970]], @"voided", nil];
			[tickets addObject:ticketInfo];
		}
		
		NSDictionary *requestArgs = [NSDictionary dictionaryWithObjectsAndKeys:tickets, @"tickets", nil];
		[self makeRequestWithAction:@"voidTickets" arguments:requestArgs];
		
		[voidTickets removeAllObjects];
	}
}

- (void)stopTimer
{
	[processTimer invalidate];
	[processTimer release];
	processTimer = nil;
}

- (void)makeRequestWithAction:(NSString *)action arguments:(NSDictionary *)args
{
	[self makeRequestWithAction:action arguments:args onCompletion:NULL];
}

- (void)makeRequestWithAction:(NSString *)action arguments:(NSDictionary *)args onCompletion:(void (^)(NSDictionary *))completion
{
	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:action forKey:@"action"];
	[params addEntriesFromDictionary:args];
	
	MKNetworkOperation *op = [netEngine operationWithPath:@"/api.php" params:params httpMethod:@"POST" ssl:YES];
	[op setPostDataEncoding:MKNKPostDataEncodingTypeJSON];
	
	[op onCompletion:^(MKNetworkOperation *completedOperation) {
		if (completion) completion([completedOperation responseJSON]);
		 
	} onError:^(NSError* error) {
		NSLog(@"%@", error);
	}];
	
	[netEngine enqueueOperation:op];
}

- (void)getAllWithCompletion:(void (^)(NSDictionary *))completion
{
	[self makeRequestWithAction:@"getOrders" arguments:[NSDictionary dictionaryWithObjectsAndKeys:@"1", @"date", nil] onCompletion:^(NSDictionary *json) {
		completion([json objectForKey:@"orders"]);
	}];
}

@end
