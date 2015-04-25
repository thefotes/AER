//  ContactsTableViewCell.m
//  AER
//
//  Created by Peter Foti on 4/25/15.
//  Copyright (c) 2015 Peter Foti. All rights reserved.

#import "ContactsTableViewCell.h"
#import "Contact.h"

@interface ContactsTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIImageView *checkmarkIcon;

@end

@implementation ContactsTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.activityIndicator.hidden = YES;
}

- (void)configureWithContact:(Contact *)contact
{
    _currentContact = contact;
    self.fullNameLabel.text = contact.fullName;
}

- (void)startSpinning
{
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
}

- (void)stopSpinningForState:(SpinnerState)state
{
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = YES;
    if (state == SpinnerStateSuccessful) {
        self.checkmarkIcon.hidden = NO;
    } else {
        self.checkmarkIcon.hidden = YES;
    }
}

@end
