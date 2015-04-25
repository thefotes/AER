//  TwilioCommunicator.h
//  AER
//
//  Created by Peter Foti on 4/25/15.
//  Copyright (c) 2015 Peter Foti. All rights reserved.

#import <Foundation/Foundation.h>

typedef void (^CompletionBlock)(id obj);
typedef void (^ErrorBlock)(NSError *error);

@interface TwilioCommunicator : NSObject

+ (instancetype)sharedTwilioCommunicator;

- (void)sendMessage:(NSString *)message toNumber:(NSString *)number withCompletion:(CompletionBlock)completion andFailure:(ErrorBlock)errorBlock;

@end
