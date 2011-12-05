//
//  GameSummaryViewController.h
//  CoachTools
//
//  Created by cj on 5/17/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Team.h"

@class Game;

@interface GameSummaryViewController : UIViewController  {

    NSMutableDictionary *itemModel;
    Game *game;
    
    UITextField *gameNumberTextField;
    UITextField *opponentTextField;
    UITextField *locationTextField;
    UITextField *dateTextField;
    
    NSDate *tempDate;
    
    IBOutlet UIButton *startGameButton;
    
}
@property (nonatomic, retain) NSMutableDictionary   *itemModel;
@property (nonatomic, retain) Game *game;

@property (nonatomic, retain) IBOutlet UITextField *gameNumberTextField;
@property (nonatomic, retain) IBOutlet UITextField *opponentTextField;
@property (nonatomic, retain) IBOutlet UITextField *locationTextField;
@property (nonatomic, retain) IBOutlet UITextField *dateTextField;
@property (nonatomic, retain) NSDate *tempDate;

@property (nonatomic, retain) IBOutlet UIButton *startGameButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil gameSelected:(Game *)aGame;

//For game button
- (IBAction)startGame:(id)sender;
- (void)completeStartGameForm;
- (void)cancelStartGameForm;
- (void)completeEditGameForm:(id)sender;
- (void)cancelEditGameForm;
- (BOOL)validateGame;
- (IBAction)gameLogButton;
- (int)numActivePlayers:(Team*)team;

@end
