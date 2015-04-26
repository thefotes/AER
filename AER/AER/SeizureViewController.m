//
//  SeizureViewController.m
//  AER
//
//  Created by Brian Palma on 4/26/15.
//  Copyright (c) 2015 Peter Foti. All rights reserved.
//

#import "SeizureViewController.h"
#import "ContactManager.h"
#import "TwilioCommunicator.h"

@interface SeizureViewController ()

@property (nonatomic, weak) IBOutlet UIButton *notifyButton;

@end

@implementation SeizureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.notifyButton.layer.borderColor = self.notifyButton.tintColor.CGColor;
    self.notifyButton.layer.borderWidth = 1.0;
    self.notifyButton.layer.cornerRadius = 5.0;
}

- (IBAction)notifyTapped:(id)sender
{
    for (Contact *contact in [ContactManager sharedManager].contacts) {
        [[TwilioCommunicator sharedTwilioCommunicator] sendMessage:[self messageForContact:contact]
                                                         toContact:contact
                                                    withCompletion:^(id obj) {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                        });
                                                    } andFailure:^(NSError *error) {
                                                    }];
    }
}


- (NSString *)messageForContact:(Contact *)contact
{
    return [NSString stringWithFormat:@"Alert: John D. has reported a seizure via Recovery_epilepsy please be on standby, your help may be requuested."];
}

@end

