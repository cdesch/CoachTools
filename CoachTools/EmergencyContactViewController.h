//
//  EmergencyContactViewController.h
//  CoachTools
//
//  Created by Chris Desch on 12/9/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"
#import <AddressBookUI/AddressBookUI.h>
#import "EmergencyContact.h"
#import "AddressBookViewController.h"

//@protocol EmergencyContactDelegate;

@interface EmergencyContactViewController : UITableViewController <ABPersonViewControllerDelegate, AddressBookDelegate,UITableViewDelegate> {
    
    Person*     item;
    NSMutableArray*    itemsArray;
    EmergencyContact *eContact;
    
}

@property (nonatomic, retain) Person*    item;
@property (nonatomic, retain) NSMutableArray*   itemsArray;
@property (nonatomic, retain) EmergencyContact *eContact;

- (id)initWithStyle:(UITableViewStyle)style player:(Person*)player;
- (void)doneButton:(id)sender;
@end

/*
@protocol EmergencyContactDelegate <NSObject>

- (void)doneEditingEmergencyContacts:(EmergencyContactViewController *)doneEditingEmergencyContacts;


@end

*/