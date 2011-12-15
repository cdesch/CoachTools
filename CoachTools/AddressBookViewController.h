//
//  AddressBookViewController.h
//  CoachTools
//
//  Created by Chris Desch on 12/5/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "Person.h"

@protocol AddressBookDelegate;

@interface AddressBookViewController : UITableViewController <ABPeoplePickerNavigationControllerDelegate, ABNewPersonViewControllerDelegate,ABUnknownPersonViewControllerDelegate, UIAlertViewDelegate>{
    
    id<AddressBookDelegate> delegate;
   	NSArray *labels;
    Person *item;
    
    NSMutableDictionary *playerModel;
}

@property(nonatomic,assign)id <AddressBookDelegate> delegate;
@property (nonatomic, retain) NSArray *labels;
@property (nonatomic, retain) Person *item;
@property (nonatomic, retain) NSMutableDictionary *playerModel;

- (id)initWithStyle:(UITableViewStyle)style player:(Person*)player withInternal:(BOOL)internal;
- (void)showMigrationAlert;
- (void)showItemForm;
- (void)completeSampleForm;
- (void)cancelForm;
- (BOOL)validateEmail:(NSString *)candidate;
- (void)migrateItem;
- (void)newItem;
- (void)itemImport;
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@protocol AddressBookDelegate <NSObject>

    - (void)doneAddressBook:(AddressBookViewController *)doneAddressBook contactIdentifier:(ABRecordRef)person;
    - (void)cancelledAddressBook:(AddressBookViewController *)cancelledAddressBook;

@optional

- (void)doneForm:(AddressBookViewController *)doneForm;
- (void)cancelForm:(AddressBookViewController *)cancelForm;

@end
