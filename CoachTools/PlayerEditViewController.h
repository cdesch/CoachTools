//
//  PlayerEditViewController.h
//  CoachTools
//
//  Created by Chris Desch on 12/5/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELCTextfieldCell.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "Person.h"
#import "AddressBookViewController.h"
@protocol PlayerEditDelegate;

@interface PlayerEditViewController : UITableViewController <ABPersonViewControllerDelegate, ELCTextFieldDelegate, AddressBookDelegate>{
    
	id<PlayerEditDelegate> delegate;
	NSArray *labels;
	NSArray *placeholders;
    Person *item;
    
}
@property(nonatomic,assign)id <PlayerEditDelegate> delegate;
@property (nonatomic, retain) NSArray *labels;
@property (nonatomic, retain) NSArray *placeholders;
@property (nonatomic, retain) Person *item;

- (id)initWithStyle:(UITableViewStyle)style player:(Person*)player;
- (void)saveButton:(id)sender;
- (void)cancelButton:(id)sender;
- (void)configureTextFieldCell:(ELCTextfieldCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (BOOL)validateItem;

@end

@protocol PlayerEditDelegate <NSObject>

- (void)doneEditingPlayer:(PlayerEditViewController *)doneEditingPlayer player:(Person *)person;
- (void)cancelledEditingPlayer:(PlayerEditViewController *)cancelledEditingPlayer;

@end

