//  TwilioCommunicator.m
//  AER
//
//  Created by Peter Foti on 4/25/15.
//  Copyright (c) 2015 Peter Foti. All rights reserved.

#import "TwilioCommunicator.h"
#import <AFNetworking/AFNetworking.h>
#import "URLFactory.h"
#import "NSDate+FormattedDates.h"

static NSString * const kAccountSID = @"AC40963c88c1b2510cd506f55cc6c89816";
static NSString * const kAuthToken = @"8a757c581df51d708c84b06507e1f631";

@interface TwilioCommunicator ()

@property (strong, nonatomic) AFHTTPRequestOperationManager *manager;

@end

@implementation TwilioCommunicator

+ (instancetype)sharedTwilioCommunicator
{
    static TwilioCommunicator * sharedTwilioCommunicator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedTwilioCommunicator = [[self alloc] init];
    });
    
    return sharedTwilioCommunicator;
}

- (AFHTTPRequestOperationManager *)manager
{
    return _manager = _manager ?: [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[URLFactory TwilioURL]];
}

- (void)sendMessage:(NSString *)message toNumber:(NSString *)number withCompletion:(CompletionBlock)completon andFailure:(ErrorBlock)errorBlock
{
    self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSDictionary *postDict = @{ @"From": @"13158492154", @"To": @"13152515028" };
    
    [self.manager POST:[NSString stringWithFormat:@"%@/Accounts/%@/Messages", [NSDate RequestDateString], kAccountSID]
            parameters:postDict
               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                   NSLog(@"Response %@", responseObject);
               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   NSLog(@"%@", error);
               }];
    
}

@end
