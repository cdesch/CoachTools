//
//  AddPlayerViewController.h
//  CoachTools
//
//  Created by cj on 5/4/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Team.h"

@protocol AddPlayerDelegate;
@class Person;

@interface AddPlayerViewController : UIViewController {
    
    id<AddPlayerDelegate> delegate;
    
    Person *person;
    
    IBOutlet UITextField *playerNumberTextField;
    IBOutlet UITextField *firstNameTextField;
    IBOutlet UITextField *lastNameTextField;
    IBOutlet UITextField *emailTextField;
    
    UIPopoverController *detailViewPopover;
    
    Team    *team;
}
@property (nonatomic, retain) Person *person;
@property (nonatomic, retain) IBOutlet UITextField *playerNumberTextField;
@property (nonatomic, retain) IBOutlet UITextField *firstNameTextField;
@property (nonatomic, retain) IBOutlet UITextField *lastNameTextField;
@property (nonatomic, retain) IBOutlet UITextField *emailTextField;
@property (nonatomic, retain) UIPopoverController *detailViewPopover;
@property (nonatomic, retain) Team      *team;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil teamSelected:(Team *)aTeam;

@property(nonatomic,assign)id <AddPlayerDelegate> delegate;

- (void)saveButton:(id)sender;
- (void)cancelButton:(id)sender;
- (BOOL)validatePerson;
- (BOOL)validateEmail: (NSString *) candidate;
@end

@protocol AddPlayerDelegate <NSObject>

- (void)addPlayerViewController:(AddPlayerViewController *)addPlayerViewController didAddPerson:(Person *)person;

@end
