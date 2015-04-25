//  ViewController.m
//  AER
//
//  Created by Peter Foti on 4/25/15.
//  Copyright (c) 2015 Peter Foti. All rights reserved.

#import "ViewController.h"
#import "TwilioCommunicator.h"
@import AddressBookUI;

@interface ViewController () <ABPeoplePickerNavigationControllerDelegate>

@end

@implementation ViewController

- (IBAction)buttonPressed:(id)sender
{
    ABPeoplePickerNavigationController *navController = [[ABPeoplePickerNavigationController alloc] init];
    navController.peoplePickerDelegate = self;
    [self presentViewController:navController animated:YES completion:nil];
}

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person
{
    NSMutableArray *mobilePhones = [NSMutableArray arrayWithCapacity:0];
    
    ABMultiValueRef phones = ABRecordCopyValue(person, kABPersonPhoneProperty);
    NSArray *allPhoneNumbers = (NSArray *)CFBridgingRelease(ABMultiValueCopyArrayOfAllValues(phones));
    
    for (NSUInteger i=0; i < [allPhoneNumbers count]; i++) {
        if ([(NSString *)CFBridgingRelease(ABMultiValueCopyLabelAtIndex(phones, (long)i)) isEqualToString:(NSString *)kABPersonPhoneMobileLabel]) {
            [mobilePhones addObject:CFBridgingRelease(ABMultiValueCopyValueAtIndex(phones, (long)i))];
        }
        if ([(NSString *)CFBridgingRelease(ABMultiValueCopyLabelAtIndex(phones, (long)i)) isEqualToString:(NSString *)kABPersonPhoneIPhoneLabel]) {
            [mobilePhones addObject:CFBridgingRelease(ABMultiValueCopyValueAtIndex(phones, (long)i))];
        }
    }
    
    CFRelease(phones);
    
    NSLog(@"%@", [mobilePhones firstObject]);
    
}

@end
