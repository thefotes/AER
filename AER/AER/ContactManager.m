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
       
        Contact *matt = [[Contact alloc] initWithDictionary:@{@"First": @"Matt",
                                                              @"Last": @"Draper",
                                                              @"Phone": @"+18564047174",
                                                              @"Message": @"Hi, Matt D.,\n\nThank you for walking John's dog while he's recovering. Just a reminder he needs your help today through Friday.\n\nThe Recover_epilepsy team"}];
//        
//        Contact *chrisClark = [[Contact alloc] initWithDictionary:@{@"First": @"Chris",
//                                                                    @"Last": @"Clark",
//                                                                    @"Phone": @"+12056124589",
//                                                                    @"Message": @"Hi, Chris C.,\n\nThank you for giving John a ride to his doctor's appointment at 10:00 a.m. on Friday 5/1.\n\nThe Recover_epilepsy team"}];
//        
//        Contact *chrisProtos = [[Contact alloc] initWithDictionary:@{@"First": @"Chris",
//                                                                     @"Last": @"Protos",
//                                                                     @"Phone": @"+16784723140",
//                                                                     @"Message": @"Hi, Chris P.,\n\nThank you for helping John prepare dinner tonight while he is recovering.\n\nThe Recover_epilepsy team"}];
        
        manager.contacts = [NSMutableArray new];
        [manager.contacts addObjectsFromArray:@[matt]]; //, chrisClark, chrisProtos]];
    });
    
    return manager;
}


@end
