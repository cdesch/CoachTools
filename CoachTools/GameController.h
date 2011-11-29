//
//  GameController.h
//  CoachTools
//
//  Created by cj on 5/18/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//


#import "cocos2d.h"
#import "BackgroundLayer.h"
#import "HUDLayer.h"
#import "PlayerLayer.h"
#import "Team.h"

@interface GameController : CCNode {
    BackgroundLayer *backgroundLayer;
	HUDLayer *hudLayer;
    PlayerLayer *playerLayer;
    Team *team;
    

}

@property(nonatomic, retain) BackgroundLayer *backgroundLayer;
@property(nonatomic, retain) HUDLayer *hudLayer;
@property(nonatomic, retain) PlayerLayer *playerLayer;
@property(nonatomic, retain) Team *team;

+ (id) sharedController;

+(CGPoint) locationFromTouch:(UITouch*)touch;
+(CGPoint) locationFromTouches:(NSSet *)touches;

- (void)shutdownGameScene;


@end
