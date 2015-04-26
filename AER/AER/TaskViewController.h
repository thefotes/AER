//
//  TaskViewController.h
//  AER
//
//  Created by Brian Palma on 4/25/15.
//  Copyright (c) 2015 Peter Foti. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TaskViewController;

@protocol TaskViewControllerDelegate <NSObject>

- (void)taskViewController:(TaskViewController *)taskVC doneButtonTapped:(id)sender;

@end

@interface TaskViewController : UIViewController

@property (nonatomic, weak) id<TaskViewControllerDelegate> delegate;

@end
