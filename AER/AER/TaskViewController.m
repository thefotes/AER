//
//  TaskViewController.m
//  AER
//
//  Created by Brian Palma on 4/25/15.
//  Copyright (c) 2015 Peter Foti. All rights reserved.
//

#import "TaskViewController.h"

@interface TaskViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation TaskViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonTapped:)];
}

- (void)doneButtonTapped:(UIBarButtonItem *)sender
{
    [self.delegate taskViewController:self doneButtonTapped:sender];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    cell.textLabel.text = @"Cell";
    return cell;
}

@end
