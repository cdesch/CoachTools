//
//  GameScene.m
//  CoachTools
//
//  Created by cj on 5/18/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import "GameScene.h"

#import "HUDLayer.h"
#import "PlayerLayer.h"
#import "BackgroundLayer.h"

static GameScene *sharedInstance;

@implementation GameScene

//@synthesize gameController;

@synthesize hudLayer;
@synthesize playerLayer;
@synthesize backgroundLayer;


+ (GameScene *)sharedScene {	
    return sharedInstance;
}
+ (void)nilSharedScene {	
    sharedInstance = nil;
}


// on "init" you need to initialize your instance
-(id) init
{
	if( (self=[super init] )) {
        //NSLog(@"Entering %s", __PRETTY_FUNCTION__); 
        
        
        sharedInstance = self;
		//Setting up our layers in a specific order so the are layered correctly
		//GameController *gameController = [GameController sharedController];
		//gameController = [GameController sharedController];

		//[self addChild:[gameController backgroundLayer] z:-1];
        //[self addChild:[gameController hudLayer] z:50];
        //[self addChild:[gameController playerLayer] z:100];

        
        // 'layer' is an autorelease object.
        backgroundLayer = [BackgroundLayer node];
        hudLayer = [HUDLayer node];
        playerLayer = [PlayerLayer node];
        
        // add layer as a child to scene
        
		[self addChild:backgroundLayer z:-1];
        [self addChild:hudLayer z:50];
        [self addChild:playerLayer z:100];
        
        
        
		
		//Schedule a tick method. This called our game controller's
		//main loop tick method
		//[self schedule:@selector(tick:)];
        
        //NSLog(@"Exiting %s", __PRETTY_FUNCTION__); 
	}
    
	return self;
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
    //[gameController release];
	[super dealloc];
}

@end
