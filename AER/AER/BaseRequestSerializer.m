//  BaseRequestSerializer.m
//  AER
//
//  Created by Peter Foti on 4/25/15.
//  Copyright (c) 2015 Peter Foti. All rights reserved.

#import "BaseRequestSerializer.h"

static NSString * const kAccountSID = @"AC40963c88c1b2510cd506f55cc6c89816";
static NSString * const kAuthToken = @"8a757c581df51d708c84b06507e1f631";

@implementation BaseRequestSerializer

+ (instancetype)serializer
{
    BaseRequestSerializer *serializer = [super serializer];
    [serializer setValue:[NSString stringWithFormat:@"Basic %@:%@", kAccountSID, kAuthToken] forHTTPHeaderField:@"Authorization"];
    
    return serializer;
}

@end
