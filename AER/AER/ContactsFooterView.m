//  ContactsFooterView.m
//  AER
//
//  Created by Peter Foti on 4/25/15.
//  Copyright (c) 2015 Peter Foti. All rights reserved.

#import "ContactsFooterView.h"

@implementation ContactsFooterView

- (IBAction)addContatPressed:(id)sender
{
    if ([self.footerDelegate respondsToSelector:@selector(footerViewRequestAddContact:)]) {
        [self.footerDelegate footerViewRequestAddContact:self];
    }
}

@end
