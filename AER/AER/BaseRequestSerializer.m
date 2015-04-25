//  BaseRequestSerializer.m
//  AER
//
//  Created by Peter Foti on 4/25/15.
//  Copyright (c) 2015 Peter Foti. All rights reserved.

#import "BaseRequestSerializer.h"
#import "StringConstants.h"

@implementation BaseRequestSerializer

+ (instancetype)serializer
{
    BaseRequestSerializer *serializer = [super serializer];
    NSString *authString = [[[NSString stringWithFormat:@"%@:%@", kAccountSid, kAuthToken] dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:kNilOptions];
    
    [serializer setValue:[NSString stringWithFormat:@"Basic %@", authString] forHTTPHeaderField:@"Authorization"];
    
    return serializer;
}

@end
