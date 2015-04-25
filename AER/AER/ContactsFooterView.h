//  ContactsFooterView.h
//  AER
//
//  Created by Peter Foti on 4/25/15.
//  Copyright (c) 2015 Peter Foti. All rights reserved.

#import <UIKit/UIKit.h>

@protocol ContactsFooterDelegate <NSObject>

- (void)footerViewRequestAddContact:(UITableViewHeaderFooterView *)view;

@end

@interface ContactsFooterView : UITableViewHeaderFooterView

@property (weak, nonatomic) id<ContactsFooterDelegate> footerDelegate;

@end
