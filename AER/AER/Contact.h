//  Contact.h
//  AER
//
//  Created by Peter Foti on 4/25/15.
//  Copyright (c) 2015 Peter Foti. All rights reserved.

#import <Foundation/Foundation.h>

@interface Contact : NSObject

@property (copy, nonatomic) NSString *firstName;
@property (copy, nonatomic) NSString *lastName;
@property (copy, nonatomic, readonly) NSString *fullName;
@property (copy, nonatomic) NSString *phoneNumber;
@property (copy, nonatomic) NSString *message;
@property (copy, nonatomic) NSArray *messageOptions;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
