//  WordCloudViewController.h
//  AER
//
//  Created by Peter Foti on 4/25/15.
//  Copyright (c) 2015 Peter Foti. All rights reserved.

#import <UIKit/UIKit.h>

@class WordCloudViewController;

@protocol WordCloudViewControllerDelegate <NSObject>

- (void)wordCloudViewController:(WordCloudViewController *)wordCloudVC tappedItemTitle:(NSString *)title;

@end

@interface WordCloudViewController : UIViewController

@property (nonatomic, weak) id<WordCloudViewControllerDelegate> delegate;

@end
