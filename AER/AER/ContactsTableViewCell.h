//  ContactsTableViewCell.h
//  AER
//
//  Created by Peter Foti on 4/25/15.
//  Copyright (c) 2015 Peter Foti. All rights reserved.

#import <UIKit/UIKit.h>
@class Contact;

typedef NS_ENUM(NSInteger, SpinnerState) {
    SpinnerStateSuccessful,
    SpinnerStateFailure
};

@interface ContactsTableViewCell : UITableViewCell

- (void)configureWithContact:(Contact *)contact;
- (void)startSpinning;
- (void)stopSpinningForState:(SpinnerState)state;

@end
