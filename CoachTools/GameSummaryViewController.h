//
//  GameSummaryViewController.h
//  CoachTools
//
//  Created by cj on 5/17/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DateTimeSelectionViewController.h"
#import "Team.h"

@class Game;

@interface GameSummaryViewController : UIViewController <DateTimeSelectionDelegate> {

    NSMutableDictionary *itemModel;
    Game *game;
   
    UITextField *gameNumberTextField;
    UITextField *opponentTextField;
    UITextField *locationTextField;
    UITextField *dateTextField;
    
    NSDate *tempDate;
    
    IBOutlet UIButton *startGameButton;
        
    //IBOutlet UISegmentedControl *halfLengthControl;
    //IBOutlet UISegmentedControl *numPlayersControl;
    
    int numPlayers;
    
    //UISwitch *intergrateCalendarSwitch;
    
    
}
@property (nonatomic, retain) NSMutableDictionary   *itemModel;
@property (nonatomic, retain) Game *game;

@property (nonatomic, retain) IBOutlet UITextField *gameNumberTextField;
@property (nonatomic, retain) IBOutlet UITextField *opponentTextField;
@property (nonatomic, retain) IBOutlet UITextField *locationTextField;
@property (nonatomic, retain) IBOutlet UITextField *dateTextField;
@property (nonatomic, retain) NSDate *tempDate;

@property (nonatomic, retain) IBOutlet UIButton *startGameButton;
//@property (nonatomic, retain) IBOutlet UISegmentedControl *halfLengthControl;
//@property (nonatomic, retain) IBOutlet UISegmentedControl *numPlayersControl;
//@property (nonatomic, retain) IBOutlet UISwitch *intergrateCalendarSwitch;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil gameSelected:(Game *)aGame;

//For game button
//- (IBAction)dateTextFieldClicked:(id)sender;
- (IBAction)startGame:(id)sender;
- (void)completeStartGameForm;
- (void)cancelStartGameForm;
//- (void)completeEditGameForm;
- (void)completeEditGameForm:(id)sender;
- (void)cancelEditGameForm;
//- (IBAction)halfTimeLengthChanged:(id)sender;
//- (IBAction)numPlayersChanged:(id)sender;
//- (IBAction)intergrateCalendarSwitchChanged:(id)sender;
- (BOOL)validateGame;
- (IBAction)gameLogButton;
- (int)numActivePlayers:(Team*)team;

@end
