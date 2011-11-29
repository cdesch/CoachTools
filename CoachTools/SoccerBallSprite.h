//
//  SoccerBallSprite.h
//  CoachTools
//
//  Created by cj on 7/25/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Person.h"

@interface SoccerBallSprite : CCSprite <CCTargetedTouchDelegate> {
	
	BOOL        isDrag;
	CGPoint     whereTouch;

    CGPoint     previousPosition;
    NSInteger   postionStartTime;

    
    CCLabelTTF  *scoringPlayerNameLabel;
    CCLabelTTF  *assistingPlayerNameLabel;
    
    Person      *scoringPlayer;
    Person      *assistingPlayer;    
    
    NSString    *scoringPlayerPosition;
    NSString    *assistingPlayerPosition;
    
}
@property (nonatomic, readwrite) BOOL       isDrag;

@property (nonatomic, readwrite) CGPoint    previousPosition;
@property (nonatomic, readwrite) NSInteger  postionStartTime;

@property (nonatomic, retain) CCLabelTTF    *scoringPlayerNameLabel;
@property (nonatomic, retain) CCLabelTTF    *assistingPlayerNameLabel;

@property (nonatomic, retain) Person        *scoringPlayer;
@property (nonatomic, retain) Person        *assistingPlayer;  

@property (nonatomic, retain) NSString      *scoringPlayerPosition;
@property (nonatomic, retain) NSString      *assistingPlayerPosition;

- (BOOL)isTouchOnSprite:(CGPoint)touch;
- (BOOL)collidesWith:(CCNode *)obj;
- (void)reset;

@end
