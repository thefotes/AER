//  TwilioCommunicator.m
//  AER
//
//  Created by Peter Foti on 4/25/15.
//  Copyright (c) 2015 Peter Foti. All rights reserved.

#import "TwilioCommunicator.h"
#import <AFNetworking/AFNetworking.h>
#import "URLFactory.h"
#import "BaseRequestSerializer.h"
#import "StringConstants.h"
#import "Contact.h"

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

- (void)sendMessage:(NSString *)message toNumber:(NSString *)number withCompletion:(CompletionBlock)completion andFailure:(ErrorBlock)errorBlock
{
    self.manager.requestSerializer = [BaseRequestSerializer serializer];
    self.manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    NSDictionary *postDict = @{ @"From": kFromNumber, @"To": number , @"Body": message};
    
    [self.manager POST:[NSString stringWithFormat:@"2010-04-01/Accounts/%@/Messages", kAccountSid]
            parameters:postDict
               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                   if (completion) {
                       completion(responseObject);
                   }
               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   if (errorBlock) {
                       errorBlock(error);
                   }
               }];
    
}

- (void)sendMessage:(NSString *)message toContact:(Contact *)contact withCompletion:(CompletionBlock)completion andFailure:(ErrorBlock)errorBlock
{
    self.manager.requestSerializer = [BaseRequestSerializer serializer];
    self.manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    NSDictionary *postDict = @{ @"From": kFromNumber, @"To": contact.phoneNumber , @"Body": message};
    
    [self.manager POST:[NSString stringWithFormat:@"2010-04-01/Accounts/%@/Messages", kAccountSid]
            parameters:postDict
               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                   if (completion) {
                       completion(responseObject);
                   }
               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   if (errorBlock) {
                       errorBlock(error);
                   }
               }];
}

@end
