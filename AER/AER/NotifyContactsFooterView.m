//
//  NotifyContactsFooterView.m
//  AER
//
//  Created by Peter Foti on 4/25/15.
//  Copyright (c) 2015 Peter Foti. All rights reserved.
//

#import "NotifyContactsFooterView.h"

@implementation NotifyContactsFooterView

- (IBAction)notifyContactsPressed:(id)sender
{
    if ([self.notificationDelegate respondsToSelector:@selector(notifyContactsFooterViewRequestNotificationOfContacts:)] ) {
        [self.notificationDelegate notifyContactsFooterViewRequestNotificationOfContacts:self];
    }
}

@end
