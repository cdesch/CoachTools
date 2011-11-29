//
//  StarterLocationSprite.h
//  CoachTools
//
//  Created by cj on 7/7/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface SlotSprite : CCSprite {
    
    CCLabelTTF  *nameLabel;
    CCSprite    *nodeSelected;
}

@property (nonatomic, retain) CCLabelTTF    *nameLabel;
@property (nonatomic, retain) CCSprite      *nodeSelected;

- (bool) collidesWith:(CCNode *)obj;

@end
