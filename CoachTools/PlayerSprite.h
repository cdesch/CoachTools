//
//  DragSprite.h
//  DevCoachTools
//
//  Created by cj on 3/7/11.
//  Copyright Desch Enterprises 2011. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Person.h"

@interface PlayerSprite : CCSprite <CCTargetedTouchDelegate> {
	
	BOOL        isDrag;
	CGPoint     whereTouch;
    NSString    *playerName;
    NSString    *playerNumber;
    CCSprite    *playerSelected;
    CGPoint     previousPosition;
    NSInteger   postionStartTime;
    NSString    *positionName;
    
    CCLabelTTF *nameLabel;
    CCLabelTTF *numberLabel;
    
    Person      *player;
    
}
@property (nonatomic, readwrite) BOOL       isDrag;
@property (nonatomic, retain) NSString      *playerName;
@property (nonatomic, retain) NSString      *playerNumber;
@property (nonatomic, retain) CCSprite      *playerSelected;
@property (nonatomic, readwrite) CGPoint    previousPosition;
@property (nonatomic, readwrite) NSInteger  postionStartTime;
@property (nonatomic, retain) NSString      *positionName;

@property (nonatomic, retain) CCLabelTTF    *nameLabel;
@property (nonatomic, retain) CCLabelTTF    *numberLabel;

@property (nonatomic, retain) Person        *player;


- (BOOL) isTouchOnSprite:(CGPoint)touch;
- (bool) collidesWith:(CCNode *)obj;

@end
