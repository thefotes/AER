//
//  ListContainerViewController.m
//  AER
//
//  Created by Brian Palma on 4/25/15.
//  Copyright (c) 2015 Peter Foti. All rights reserved.
//

#import "ListContainerViewController.h"
#import "WordCloudViewController.h"
#import "TaskViewController.h"

@interface ListContainerViewController () <WordCloudViewControllerDelegate, TaskViewControllerDelegate>

@property (nonatomic, strong) WordCloudViewController *wordCloudVC;
@property (nonatomic, strong) TaskViewController *taskVC;

@end

@implementation ListContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildVC:self.wordCloudVC withTitle:@"Pain Points"];
}

- (WordCloudViewController *)wordCloudVC
{
    if (!_wordCloudVC) {
        _wordCloudVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"WordCloudViewController"];
        _wordCloudVC.delegate = self;
    }
    return _wordCloudVC;
}

- (TaskViewController *)taskVC
{
    if (!_taskVC) {
        _taskVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TaskViewController"];
        _taskVC.delegate = self;
    }
    return _taskVC;
}

- (void)addChildVC:(UIViewController *)childVC withTitle:(NSString *)title
{
    if (self.childViewControllers.count) {
        UIViewController *viewController = (UIViewController *)self.childViewControllers[0];
        [viewController willMoveToParentViewController:nil];
    }
    
    [childVC setValue:self forKey:@"delegate"];
    childVC.view.frame = self.view.bounds;
    [self addChildViewController:childVC];
    [self.view addSubview:childVC.view];
    [childVC didMoveToParentViewController:self];
    
    self.title = title;
}

- (void)wordCloudViewController:(WordCloudViewController *)wordCloudVC tappedItemTitle:(NSString *)title
{
    [UIView transitionFromView:self.view toView:self.view duration:1.0 options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished) {
        [self addChildVC:self.taskVC withTitle:title];
    }];
}

- (void)taskViewController:(TaskViewController *)taskVC doneButtonTapped:(UIButton *)sender
{
    [self addChildVC:self.wordCloudVC withTitle:@"Pain Points"];
}




@end
