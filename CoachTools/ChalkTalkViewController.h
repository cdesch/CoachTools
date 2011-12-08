//
//  ChalkTalkViewController.h
//  CoachTools
//
//  Created by Chris Desch on 12/8/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

@interface ChalkTalkViewController : UIViewController {
    
    
    IBOutlet UIView *mainView;
    IBOutlet UINavigationBar *navBar;
    
    CCScene *chalkTalkScene;
    
    IBOutlet UIBarButtonItem *endButtonItem;
    
}


@property (nonatomic, retain) UIView *mainView;
@property (nonatomic, retain) UINavigationBar *navBar;

@property (nonatomic, retain) CCScene *chalkTalkScene;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *endButtonItem;


- (void)startCocos2d;
- (void)endCocos2d;
- (void)runNewGame;
- (void)attachView;
- (void)detachView;
- (IBAction)endGameButton:(id)sender;

@end