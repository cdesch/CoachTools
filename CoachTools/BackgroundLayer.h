//
//  BackgroundLayer.h
//  CoachTools
//
//  Created by cj on 5/18/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import "cocos2d.h"


@interface BackgroundLayer : CCLayer {
    
    CCLabelTTF	*label;
	CCSprite *background;
	CCTMXLayer *meta;
}

@property(nonatomic, retain) CCLabelTTF *label;
@property(nonatomic, retain) CCSprite *background;
@property(nonatomic, retain) CCTMXLayer *meta;


@end
