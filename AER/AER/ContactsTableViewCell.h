//  ContactsTableViewCell.h
//  AER
//
//  Created by Peter Foti on 4/25/15.
//  Copyright (c) 2015 Peter Foti. All rights reserved.

#import <UIKit/UIKit.h>
@class Contact;

@interface ContactsTableViewCell : UITableViewCell

- (void)configureWithContact:(Contact *)contact;

@end
