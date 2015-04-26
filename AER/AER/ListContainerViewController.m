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
@property (nonatomic, weak) IBOutlet UIView *containerView;

@end

@implementation ListContainerViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:self.wordCloudVC];
    navController.view.frame = self.view.bounds;
    [self addChildViewController:navController];
    [self.view addSubview:navController.view];
    [navController didMoveToParentViewController:self];
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

- (void)wordCloudViewController:(WordCloudViewController *)wordCloudVC butonTapped:(UIButton *)sender
{
    UINavigationController *currentChild = self.childViewControllers[0];
    UINavigationController *nextChild = [[UINavigationController alloc] initWithRootViewController:self.taskVC];
    self.taskVC.title = sender.titleLabel.text;
    
    nextChild.view.frame = self.view.bounds;
    [self addChildViewController:nextChild];
    [currentChild willMoveToParentViewController:nil];
    
    [self transitionFromViewController:currentChild toViewController:nextChild duration:0.5 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        
    } completion:^(BOOL finished) {
        [currentChild removeFromParentViewController];
        [nextChild didMoveToParentViewController:self];
    }];
}

- (void)taskViewController:(TaskViewController *)taskVC doneButtonTapped:(UIButton *)sender
{
    UINavigationController *currentChild = self.childViewControllers[0];
    UINavigationController *nextChild = [[UINavigationController alloc] initWithRootViewController:self.wordCloudVC];
    
    nextChild.view.frame = self.view.bounds;
    [self addChildViewController:nextChild];
    [currentChild willMoveToParentViewController:nil];
    
    [self transitionFromViewController:currentChild toViewController:nextChild duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        
    } completion:^(BOOL finished) {
        [currentChild removeFromParentViewController];
        [nextChild didMoveToParentViewController:self];
    }];
}

@end
