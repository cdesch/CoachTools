//
//  AddTeamViewController.h
//  CoachTools
//
//  Created by cj on 5/8/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@protocol AddTeamDelegate;
@class Team;

@interface AddTeamViewController : UIViewController <UITextFieldDelegate>{
    id<AddTeamDelegate> delegate;
    
    Team *team;
    IBOutlet UITextField *nameTextField;
    IBOutlet UITextField *uniformColorTextField;
    IBOutlet UITextField *locationTextField;

}
@property (nonatomic, retain) Team *team;

@property (nonatomic, retain) IBOutlet UITextField *nameTextField;
@property (nonatomic, retain) IBOutlet UITextField *uniformColorTextField;
@property (nonatomic, retain) IBOutlet UITextField *locationTextField;

@property(nonatomic,assign)id <AddTeamDelegate> delegate;

- (void)saveButton:(id)sender;
- (void)cancelButton:(id)sender;
- (BOOL)validateTeam;

@end

@protocol AddTeamDelegate <NSObject>

- (void)addTeamViewController:(AddTeamViewController *)addTeamViewController didAddTeam:(Team *)team;

@end