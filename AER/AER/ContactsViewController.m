//  ContactsViewController.m
//
//  Created by Peter Foti on 4/25/15.

#import "ContactsViewController.h"
#import "ContactsFooterView.h"

@interface ContactsViewController () <UITableViewDelegate, UITableViewDataSource, ContactsFooterDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *mockData;

@end

@implementation ContactsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    ContactsFooterView *footerView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ContactsFooterView class]) owner:nil options:nil] firstObject];
    footerView.footerDelegate = self;
    
    return footerView;
}

- (void)footerViewRequestAddContact:(UITableViewHeaderFooterView *)view
{
    NSLog(@"%@", view);
}

@end
