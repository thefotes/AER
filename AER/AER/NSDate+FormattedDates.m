//  NSDate+FormattedDates.m
//  AER
//
//  Created by Peter Foti on 4/25/15.
//  Copyright (c) 2015 Peter Foti. All rights reserved.

#import "NSDate+FormattedDates.h"

@implementation NSDate (FormattedDates)

+ (NSString *)RequestDateString
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"YYYY-MM-dd";
    
    return [formatter stringFromDate:[NSDate date]];
}

@end
