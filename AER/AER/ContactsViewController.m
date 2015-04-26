//  ContactsViewController.m
//
//  Created by Peter Foti on 4/25/15.

#import "ContactsViewController.h"
#import "ContactsTableViewCell.h"
#import "Contact.h"
#import "TwilioCommunicator.h"
#import "ContactManager.h"

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

- (IBAction)addButtonTapped:(id)sender
{
    ABPeoplePickerNavigationController *navController = [[ABPeoplePickerNavigationController alloc] init];
    navController.peoplePickerDelegate = self;
    [self presentViewController:navController animated:YES completion:nil];
}

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person
{
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    for ( int32_t propertyIndex = kABPersonFirstNameProperty; propertyIndex <= kABPersonSocialProfileProperty; propertyIndex ++ ) {
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
                    [mobilePhones addObject:CFBridgingRelease(ABMultiValueCopyValueAtIndex(phones, (long)i))];             }
            }
            NSString *rawNumber = [mobilePhones firstObject];
            NSString *cleanNumber = [[rawNumber componentsSeparatedByCharactersInSet:
            [[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
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
