//  ContactsViewController.m
//
//  Created by Peter Foti on 4/25/15.

#import "ContactsViewController.h"
#import "ContactsFooterView.h"
@import AddressBookUI;

@interface ContactsViewController () <UITableViewDelegate, UITableViewDataSource, ContactsFooterDelegate, ABPeoplePickerNavigationControllerDelegate>

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
    ABPeoplePickerNavigationController *navController = [[ABPeoplePickerNavigationController alloc] init];
    navController.peoplePickerDelegate = self;
    
    [self presentViewController:navController animated:YES completion:nil];
}

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person
{
    NSMutableArray *mobilePhones = [NSMutableArray arrayWithCapacity:0];
    
    ABMultiValueRef phones = ABRecordCopyValue(person, kABPersonPhoneProperty);
    NSArray *allPhoneNumbers = (NSArray *)CFBridgingRelease(ABMultiValueCopyArrayOfAllValues(phones));
    
    for (NSUInteger i = 0; i < [allPhoneNumbers count]; i++) {
        if ([(NSString *)CFBridgingRelease(ABMultiValueCopyLabelAtIndex(phones, (long)i)) isEqualToString:(NSString *)kABPersonPhoneMobileLabel]) {
            [mobilePhones addObject:CFBridgingRelease(ABMultiValueCopyValueAtIndex(phones, (long)i))];
        }
        if ([(NSString *)CFBridgingRelease(ABMultiValueCopyLabelAtIndex(phones, (long)i)) isEqualToString:(NSString *)kABPersonPhoneIPhoneLabel]) {
            [mobilePhones addObject:CFBridgingRelease(ABMultiValueCopyValueAtIndex(phones, (long)i))];
        }
    }
    
    CFRelease(phones);
    
    NSLog(@"%@", [mobilePhones firstObject]);
    
}

@end
