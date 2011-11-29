//
//  AddGameViewController.h
//  CoachTools
//
//  Created by cj on 5/4/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Season.h"

#import "DateTimeSelectionViewController.h"

@protocol AddGameDelegate;

@class Game;

@interface AddGameViewController : UIViewController <DateTimeSelectionDelegate> {
    id<AddGameDelegate> delegate;
    
    Game *game;
    Season *season;
    
    IBOutlet UITextField *gameNumberTextField;
    IBOutlet UITextField *opponentTextField;
    IBOutlet UITextField *locationTextField;
    IBOutlet UITextField *dateTextField;

    NSDate *tempDate;
    UISwitch *intergrateCalendarSwitch;

}

@property (nonatomic, retain) Game *game;
@property (nonatomic, retain) Season *season;
@property (nonatomic, retain) IBOutlet UITextField *gameNumberTextField;
@property (nonatomic, retain) IBOutlet UITextField *opponentTextField;
@property (nonatomic, retain) IBOutlet UITextField *locationTextField;
@property (nonatomic, retain) IBOutlet UITextField *dateTextField;
@property (nonatomic, retain) NSDate *tempDate;
@property (nonatomic, retain) IBOutlet UISwitch *intergrateCalendarSwitch;

@property(nonatomic,assign)id <AddGameDelegate> delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil seasonSelected:(Season *)aSeason;
- (IBAction)dateTextFieldClicked:(id)sender;
- (void)saveButton:(id)sender;
- (void)cancelButton:(id)sender;
- (IBAction)intergrateCalendarSwitchChanged:(id)sender;

- (BOOL)validateGame;



@end



@protocol AddGameDelegate <NSObject>

- (void)addGameViewController:(AddGameViewController *)addGameViewController didAddGame:(Game*)game;

@end