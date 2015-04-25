//  ContactsViewController.m
//
//  Created by Peter Foti on 4/25/15.

#import "ContactsViewController.h"
#import "ContactsFooterView.h"
#import "Contact.h"
#import "ContactsTableViewCell.h"
#import "NotifyContactsFooterView.h"
#import "TwilioCommunicator.h"

@import AddressBookUI;

@interface ContactsViewController () <UITableViewDelegate, UITableViewDataSource, ContactsFooterDelegate, ABPeoplePickerNavigationControllerDelegate, NotificationDelegate>

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
        Contact *newContact = [[Contact alloc] init];
        newContact.firstName = @"Peter";
        newContact.lastName = @"Foti";
        newContact.phoneNumber = @"3152515028";
        newContact.message = @"Testing 123";
        
        Contact *secondContact = [[Contact alloc] init];
        secondContact.firstName = @"Brian";
        secondContact.lastName = @"Palma";
        secondContact.phoneNumber = @"3152478818";
        secondContact.message = @"Testing";
        
        [_contacts addObject:newContact];
        [_contacts addObject:secondContact];
    }
    
    return _contacts;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ContactsTableViewCell class])];
    
    Contact *currentContact = self.contacts[(NSUInteger)indexPath.row];
    
    [cell configureWithContact:currentContact];
    
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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.isSeizureFlow) {
        NotifyContactsFooterView *footerView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NotifyContactsFooterView class]) owner:nil options:nil] firstObject];
        footerView.notificationDelegate = self;
        
        return footerView;
    } else {
        ContactsFooterView *footerView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ContactsFooterView class]) owner:nil options:nil] firstObject];
        footerView.footerDelegate = self;
        
        return footerView;
    }
}

#pragma mark - Notification Delegate

- (void)notifyContactsFooterViewRequestNotificationOfContacts:(UITableViewHeaderFooterView *)view
{
    NSArray *cells = [self.tableView visibleCells];
    
    for (ContactsTableViewCell *cell in cells) {
        [cell startSpinning];
        
        [[TwilioCommunicator sharedTwilioCommunicator] sendMessage:@"What a message"
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

#pragma mark - Add Contact Delegate

- (void)footerViewRequestAddContact:(UITableViewHeaderFooterView *)view
{
    ABPeoplePickerNavigationController *navController = [[ABPeoplePickerNavigationController alloc] init];
    navController.peoplePickerDelegate = self;
    
    [self presentViewController:navController animated:YES completion:nil];
}

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person
{
    NSMutableDictionary* dictionary = [NSMutableDictionary dictionary];
    
    for ( int32_t propertyIndex = kABPersonFirstNameProperty; propertyIndex <= kABPersonSocialProfileProperty; propertyIndex ++ )
    {
        NSString* propertyName = CFBridgingRelease(ABPersonCopyLocalizedPropertyName(propertyIndex));
        id value = CFBridgingRelease(ABRecordCopyValue(person, propertyIndex));
        
        NSMutableArray *mobilePhones = [NSMutableArray arrayWithCapacity:0];
        
        if ([propertyName isEqualToString:@"Phone"]) {
            ABMultiValueRef phones = (__bridge ABMultiValueRef)(value);
            NSArray *allPhoneNumbers = (NSArray *)CFBridgingRelease(ABMultiValueCopyArrayOfAllValues(phones));
            
            for (NSUInteger i = 0; i < [allPhoneNumbers count]; i++) {
                if ([(NSString *)CFBridgingRelease(ABMultiValueCopyLabelAtIndex(phones, (long)i)) isEqualToString:(NSString *)kABPersonPhoneMobileLabel]) {
                    [mobilePhones addObject:CFBridgingRelease(ABMultiValueCopyValueAtIndex(phones, (long)i))];
                }
                if ([(NSString *)CFBridgingRelease(ABMultiValueCopyLabelAtIndex(phones, (long)i)) isEqualToString:(NSString *)kABPersonPhoneIPhoneLabel]) {
                    [mobilePhones addObject:CFBridgingRelease(ABMultiValueCopyValueAtIndex(phones, (long)i))];
                }
            }
            
            NSString *rawNumber = [mobilePhones firstObject];
            NSString *cleanNumber = [[rawNumber componentsSeparatedByCharactersInSet:
                                      [[NSCharacterSet decimalDigitCharacterSet] invertedSet]]
                                     componentsJoinedByString:@""];
            dictionary[propertyName] = cleanNumber;
  
        } else {
            if ( value )
                [dictionary setObject:value forKey:propertyName];
        }
    }
    
    Contact *newContact = [[Contact alloc] initWithDictionary:dictionary];
    
    [self.contacts addObject:newContact];
    
    [self.tableView reloadData];
}

@end
