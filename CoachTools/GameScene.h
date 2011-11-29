//
//  GameScene.h
//  CoachTools
//
//  Created by cj on 5/18/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import "cocos2d.h"
#import "GameController.h"
#import "HUDLayer.h"
#import "PlayerLayer.h"
#import "BackgroundLayer.h"


@interface GameScene : CCScene {

    //GameController *gameController;
    
    BackgroundLayer *backgroundLayer;
    HUDLayer *hudLayer;
    PlayerLayer *playerLayer;
    
}

//@property (nonatomic, retain) GameController *gameController;

@property (nonatomic, retain) BackgroundLayer *backgroundLayer;
@property (nonatomic, retain) HUDLayer *hudLayer;
@property (nonatomic, retain) PlayerLayer *playerLayer;

+ (id) sharedScene;
+ (void)nilSharedScene;

@end
