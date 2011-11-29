//
//  GameLogViewController.h
//  CoachTools
//
//  Created by Chris Desch on 8/22/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"

@protocol GameLogViewControllerDelegate;

@interface GameLogViewController : UITableViewController {
    id <GameLogViewControllerDelegate> delegate;
    Game *game;
    
    NSMutableArray *subsArray;
    NSMutableArray *scoresArray;
    NSMutableArray *startsArray;
    
    BOOL isGameRunning;
}

@property (retain) id delegate;

@property (nonatomic, retain) Game *game;

@property (nonatomic, retain) NSMutableArray *subsArray;
@property (nonatomic, retain) NSMutableArray *scoresArray;
@property (nonatomic, retain) NSMutableArray *startsArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil gameSelected:(Game *)aGame;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil gameSelected:(Game *)aGame gameRunning:(BOOL)running;

- (void)closeButton:(id)sender;

@end
@protocol GameLogViewControllerDelegate <NSObject>

- (void)hideViewController:(GameLogViewController *)viewController;

@end