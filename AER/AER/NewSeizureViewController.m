//
//  NewSeizureViewController.m
//  AER
//
//  Created by Peter Foti on 4/25/15.
//  Copyright (c) 2015 Peter Foti. All rights reserved.
//

#import "NewSeizureViewController.h"
#import "ContactsViewController.h"

@interface NewSeizureViewController ()

@end

@implementation NewSeizureViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"goToContacts"]) {
        ContactsViewController *vc = segue.destinationViewController;
        vc.seizureFlow = YES;
    }
}

@end
