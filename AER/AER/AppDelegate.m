//  AppDelegate.m
//  AER
//
//  Created by Peter Foti on 4/25/15.
//  Copyright (c) 2015 Peter Foti. All rights reserved.

#import "AppDelegate.h"
#import <AFNetworkingLogger.h>

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [AFNetworkingLogger.sharedLogger startLogging];
    
    return YES;
}

@end
