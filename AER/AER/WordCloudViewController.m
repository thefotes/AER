//  WordCloudViewController.m
//  AER
//
//  Created by Peter Foti on 4/25/15.
//  Copyright (c) 2015 Peter Foti. All rights reserved.

#import "WordCloudViewController.h"
#import "WordCloudCollectionViewCell.h"

@interface WordCloudViewController ()

@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *buttons;

@end

@implementation WordCloudViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Pain Points";
    
    for (UIButton *button in self.buttons) {
        button.layer.borderColor = button.tintColor.CGColor;
        button.layer.borderWidth = 1.0;
        button.layer.cornerRadius = 5.0;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar.layer removeAllAnimations];
}

- (IBAction)buttonTapped:(UIButton *)sender
{
    [self.delegate wordCloudViewController:self butonTapped:sender];
}

@end
