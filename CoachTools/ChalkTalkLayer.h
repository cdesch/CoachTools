//
//  HelloWorldLayer.h
//  CoachTools
//
//  Created by cj on 4/4/11.
//  Copyright Desch Enterprises 2011. All rights reserved.
//

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "ConfigMenuViewController.h"
#import <UIKit/UIKit.h>


@interface ChalkTalkLayer : CCLayer{
    
    NSMutableArray *iconsArray;
}
// returns a CCScene that contains the HelloWorldLayer as the only child

- (void)spawnSpriteWithImage:(NSString*)image;
- (void)cleanLines:(id)sender;
- (float)randomFloatBetween:(float)smallNumber and:(float)bigNumber;


@end
