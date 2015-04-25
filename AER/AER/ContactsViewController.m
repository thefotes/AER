//  ContactsViewController.m
//
//  Created by Peter Foti on 4/25/15.

#import "ContactsViewController.h"

@interface ContactsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *mockData;
@end

@implementation ContactsViewController

- (NSArray *)mockData
{
    return _mockData = _mockData ?: @[@"Peter", @"Brian", @"Oren"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = self.mockData[(NSUInteger)indexPath.row];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (NSInteger)self.mockData.count;
}

@end
