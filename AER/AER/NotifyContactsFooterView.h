//
//  NotifyContactsFooterView.h
//  AER
//
//  Created by Peter Foti on 4/25/15.
//  Copyright (c) 2015 Peter Foti. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NotificationDelegate <NSObject>

- (void)notifyContactsFooterViewRequestNotificationOfContacts:(UITableViewHeaderFooterView *)view;

@end

@interface NotifyContactsFooterView : UITableViewHeaderFooterView

@property (weak, nonatomic) id<NotificationDelegate> notificationDelegate;

@end
