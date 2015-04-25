//  URLFactory.m
//  AER
//
//  Created by Peter Foti on 4/25/15.
//  Copyright (c) 2015 Peter Foti. All rights reserved.

#import "URLFactory.h"

@implementation URLFactory

+ (NSURL *)TwilioURL
{
    static NSURL * twilioURL = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        twilioURL = [NSURL URLWithString:@"https://api.twilio.com/"];
    });
    
    return twilioURL;
}

@end
