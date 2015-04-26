//  ContactsViewController.m
//
//  Created by Peter Foti on 4/25/15.

#import "ContactsViewController.h"
#import "ContactsTableViewCell.h"
#import "Contact.h"
#import "TwilioCommunicator.h"

@import AddressBookUI;

@interface ContactsViewController () <UITableViewDelegate, UITableViewDataSource, ABPeoplePickerNavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *contacts;

@end

@implementation ContactsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ContactsTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ContactsTableViewCell class])];
}

- (NSMutableArray *)contacts
{
    if (!_contacts) {
        _contacts = [NSMutableArray new];
    }
    return _contacts;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ContactsTableViewCell class])];
    Contact *contact = self.contacts[(NSUInteger)indexPath.row];
    [cell configureWithContact:contact];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (NSInteger)self.contacts.count;
}

#pragma mark - Target - Action

- (IBAction)addContactTapped:(id)sender
{
    ABPeoplePickerNavigationController *navController = [[ABPeoplePickerNavigationController alloc] init];
    navController.peoplePickerDelegate = self;
    
    [self presentViewController:navController animated:YES completion:nil];  
}

- (IBAction)notifyTapped:(id)sender
{
    NSArray *cells = [self.tableView visibleCells];
    
    for (ContactsTableViewCell *cell in cells) {
        [cell startSpinning];
        
        [[TwilioCommunicator sharedTwilioCommunicator] sendMessage:[self messageForContact:cell.currentContact]
                                                         toContact:cell.currentContact
                                                    withCompletion:^(id obj) {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [cell stopSpinningForState:SpinnerStateSuccessful];
                                                        });
                                                    } andFailure:^(NSError *error) {
                                                        NSLog(@"Failed %@", error);
                                                    }];
    }
}

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person
{
    NSString *firstName = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    NSString *lastName = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
    NSString *phoneNumber = @"[None]";
    
    ABMultiValueRef phoneNumbers = ABRecordCopyValue(person, kABPersonPhoneProperty);
    
    for (int i = 0; i < ABMultiValueGetCount(phoneNumbers); i++) {
        NSString *label = (__bridge_transfer NSString *)ABMultiValueCopyLabelAtIndex(phoneNumbers, i);
        if ([label isEqualToString:(__bridge_transfer NSString *)kABPersonPhoneMobileLabel]) {
            phoneNumber = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(phoneNumbers, i);
            break;
        }
    }
    
    Contact *contact = [[Contact alloc] initWithDictionary:@{ @"firstName": firstName, @"lastName": lastName, @"phoneNumber": phoneNumber }];
    [self.contacts addObject:contact];
    [self.tableView reloadData];
    
    CFRelease(phoneNumbers);
}

- (NSString *)messageForContact:(Contact *)contact
{
    return [NSString stringWithFormat:@"%@, I recently had a seizure and I'll be needing your help in the coming days. Thanks in advance.", contact.firstName];
}

@end
