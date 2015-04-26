//
//  ContactManager.h
//  AER
//
//  Created by Brian Palma on 4/26/15.
//  Copyright (c) 2015 Peter Foti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contact.h"

@interface ContactManager : NSObject

@property (nonatomic, strong) NSMutableArray *contacts;

+ (instancetype)sharedManager;

@end
