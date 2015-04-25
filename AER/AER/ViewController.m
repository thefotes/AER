//  ViewController.m
//  AER
//
//  Created by Peter Foti on 4/25/15.
//  Copyright (c) 2015 Peter Foti. All rights reserved.

#import "ViewController.h"
#import "TwilioCommunicator.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)buttonPressed:(id)sender
{
    [[TwilioCommunicator sharedTwilioCommunicator] sendMessage:@"Hello Brian, how are you doing."
                                                      toNumber:@"3152515028"
                                                withCompletion:^(id obj) {
                                                } andFailure:^(NSError *error) {
                                                }];
}

@end
