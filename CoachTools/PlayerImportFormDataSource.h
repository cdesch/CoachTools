//
//  PlayerImportFormDataSource.h
//  CoachTools
//
//  Created by Chris Desch on 12/1/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import <IBAForms/IBAFormDataSource.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface PlayerImportFormDataSource : IBAFormDataSource <ABPeoplePickerNavigationControllerDelegate, ABNewPersonViewControllerDelegate>


- (void)displaySampleForm;
- (void)dismissSampleForm;
@end
