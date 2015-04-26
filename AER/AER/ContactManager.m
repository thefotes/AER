//
//  ContactManager.m
//  AER
//
//  Created by Brian Palma on 4/26/15.
//  Copyright (c) 2015 Peter Foti. All rights reserved.
//

#import "ContactManager.h"
#import "Contact.h"

@interface ContactManager ()

@end

@implementation ContactManager

+ (instancetype)sharedManager
{
    static ContactManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
       
        Contact *matt = [[Contact alloc] initWithDictionary:@{@"firstName": @"Matt", @"lastName": @"Draper", @"phoneNumber": @"+18564047174"}];
        Contact *chrisClark = [[Contact alloc] initWithDictionary:@{@"firstName": @"Chris", @"lastName": @"Clark", @"phoneNumber": @"+12056124589"}];
        Contact *chrisProtos = [[Contact alloc] initWithDictionary:@{@"firstName": @"Chris", @"lastName": @"Protos", @"phoneNumber": @"+16784723140"}];
        
        manager.contacts = [NSMutableArray new];
        [manager.contacts addObjectsFromArray:@[matt, chrisClark, chrisProtos]];
    });
    
    return manager;
}


@end
