//
//  GameManagementViewController.h
//  CoachTools
//
//  Created by cj on 4/10/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "SelectStartersLayer.h"
#import "Game.h"
#import "Team.h"




@interface GameManagementViewController : UIViewController  {

    
    IBOutlet UIView *mainView;
    IBOutlet UINavigationBar *navBar;

    CCScene *starterScene;
    CCScene *gameScene;
    CCScene *chalkTalkScene;
    
    IBOutlet UIBarButtonItem *endButtonItem;
    
    Game    *game;
    
    UIPopoverController *popOverController;
    
    enum
    {
        kgameRunning,   
        kgamePaused,    
        kgameStopped,    
        kgameEnded      
    }state;
    
    int numPlayers;

}


@property (nonatomic, retain) UIView *mainView;
@property (nonatomic, retain) UINavigationBar *navBar;

@property (nonatomic, retain) CCScene *starterScene;
@property (nonatomic, retain) CCScene *gameScene;
@property (nonatomic, retain) CCScene *chalkTalkScene;

@property (nonatomic, retain) IBOutlet UIBarButtonItem *endButtonItem;

@property (nonatomic, retain) Game    *game;

@property (nonatomic, retain) UIPopoverController *popOverController;
@property (nonatomic, readwrite) int numPlayers;



+ (GameManagementViewController *)sharedController;

- (IBAction)teamManagement:(id)sender;
- (IBAction)cancelButton:(id)sender;
- (IBAction)finishedButton:(id)sender;
- (void)endGame:(id)object;
- (void)endStarters:(id)object;
- (void)finishedStarterSelection:(id)object;
- (void)showGameTimerControls;
- (void)hideGameTimerControls;
- (void)runGameScene;
- (void)compileStats;

@end

