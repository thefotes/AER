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
@property (nonatomic, copy) NSArray *items;

@end

@implementation TaskViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonTapped:)];
    
    self.items = @[@"Transportation", @"Pet care", @"Meal preparation", @"Appointment scheduling", @"Fitness", @"Finances"];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar.layer removeAllAnimations];
    self.tableView.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.tableView.hidden = NO;
    [self.tableView reloadData];
    [self.tableView reloadRowsAtIndexPaths:self.tableView.indexPathsForVisibleRows withRowAnimation:UITableViewRowAnimationBottom];
}

- (void)doneButtonTapped:(UIBarButtonItem *)sender
{
    [self.delegate taskViewController:self doneButtonTapped:sender];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (NSInteger)self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    cell.textLabel.text = self.items[(NSUInteger)indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.backgroundView) {
        cell.backgroundView = nil;
        return;
    }

    UIView *backgroundView = [UIView new];
    backgroundView.backgroundColor = [UIColor greenColor];
    cell.backgroundView = backgroundView;
}



@end
