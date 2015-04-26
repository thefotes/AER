//  Contact.m
//  AER
//
//  Created by Peter Foti on 4/25/15.
//  Copyright (c) 2015 Peter Foti. All rights reserved.

#import "Contact.h"

@implementation Contact

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        _firstName = dict[@"firstName"];
        _lastName = dict[@"lastName"];
        _phoneNumber = dict[@"phoneNumber"];
    }
    
    return self;
}

- (NSString *)fullName
{
    if (self.firstName && self.lastName) {
        return [self.firstName stringByAppendingFormat:@" %@", self.lastName];
    } else {
        return @"";
    }
}

@end
