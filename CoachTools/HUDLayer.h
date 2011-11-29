//
//  HUDLayer.h
//  CoachTools
//
//  Created by cj on 5/17/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

// cocos2d import
#import "cocos2d.h"
#import "ConfigMenuViewController.h"
#import "GameLogViewController.h"

@interface HUDLayer : CCLayer <ConfigMenuViewControllerDelegate, GameLogViewControllerDelegate> {
    
    CCSprite *bench;
    CGPoint benchShowPosition;
    CGPoint benchHidePosition;
    BOOL benchState;
    
    ConfigMenuViewController *configMenuViewController;
    
}

@property (nonatomic, retain) CCSprite *bench;
@property (nonatomic, retain) ConfigMenuViewController *configMenuViewController;


- (void)bench:(id)sender;
- (void)logAction:(id)sender;
- (void)config:(id)sender;


@end
