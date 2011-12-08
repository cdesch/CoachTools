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

@class HUDLayer;


// HelloWorldLayer
@interface ChalkTalkLayer : CCLayer
{
    
    NSInteger timeInt;
    
    NSMutableDictionary *myPlayers;
    NSMutableArray *playersList;
    
    //ConfigMenuViewController *configMenuViewController;
    
}

@property (nonatomic, readwrite) NSInteger timeInt;

@property (nonatomic, retain) NSMutableDictionary *myPlayers;
@property (nonatomic, retain) NSMutableArray *playersList;

//@property (nonatomic, retain) ConfigMenuViewController *configMenuViewController;


// returns a CCScene that contains the HelloWorldLayer as the only child
-(void)gameManagementConfigMenu;


@end
