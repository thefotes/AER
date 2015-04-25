//  ContactsTableViewCell.m
//  AER
//
//  Created by Peter Foti on 4/25/15.
//  Copyright (c) 2015 Peter Foti. All rights reserved.

#import "ContactsTableViewCell.h"
#import "Contact.h"

@interface ContactsTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;

@end

@implementation ContactsTableViewCell

- (void)configureWithContact:(Contact *)contact
{
    self.fullNameLabel.text = contact.fullName;
}

@end
