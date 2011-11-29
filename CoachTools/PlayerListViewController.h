//
//  PlayerListViewController.h
//  CoachTools
//
//  Created by cj on 5/8/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Team.h"
#import "AddPlayerViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface PlayerListViewController : UITableViewController <UINavigationControllerDelegate,UIPopoverControllerDelegate, AddPlayerDelegate, UIActionSheetDelegate, ABPeoplePickerNavigationControllerDelegate, ABNewPersonViewControllerDelegate>{
    
    NSMutableDictionary *playerModel;
    NSMutableArray  *playerArray;
    Person          *item;
    Team            *team;
}

@property (nonatomic, retain) Person          *item;
@property (nonatomic, retain) NSMutableDictionary *playerModel;
@property (nonatomic, retain) NSMutableArray    *playerArray;
@property (nonatomic, retain) Team              *team;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil teamSelected:(Team *)aTeam;
- (void)sortButton:(id)sender;
- (void)sortList:(NSString *)key ascendingOrder:(BOOL)order;
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)insertItemButton:(id)sender;
- (void)itemImport;
- (void)itemNewIntergrated;
- (void)itemForm;
- (void)showPlayer:(Person *)person animated:(BOOL)animated;
- (BOOL)validateEmail:(NSString *)candidate;
    
@end
