//
//  GameController.m
//  CoachTools
//
//  Created by cj on 5/18/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import "GameController.h"

@implementation GameController


@synthesize backgroundLayer;
@synthesize hudLayer;
@synthesize playerLayer;
@synthesize team;

static GameController *gInstance = NULL;

+ (GameController *) sharedController
{
	@synchronized(self)
    {
		if (gInstance == NULL) {
			gInstance = [[self alloc] init];
		}
    }
	return(gInstance);
}

- (id) init {
	if((self = [super init]))
	{
        NSLog(@"Entering %s", __PRETTY_FUNCTION__); 

		//Initialize and keep track of our game layers
		//The GameScene will add these to the scene as childs
		//in a very specific order.      
/*
		BackgroundLayer *newBackground = [[BackgroundLayer alloc] init];
		[self setBackgroundLayer:newBackground];
		
        HUDLayer *newHud = [[HUDLayer alloc] init];
		[self setHudLayer:newHud];
        
		PlayerLayer *newPlayer = [[PlayerLayer alloc] init];
		[self setPlayerLayer:newPlayer];
*/
        backgroundLayer = [[BackgroundLayer alloc] init];
		[self setBackgroundLayer:backgroundLayer];
		
        hudLayer= [[HUDLayer alloc] init];
		[self setHudLayer:hudLayer];
        
		playerLayer = [[PlayerLayer alloc] init];
		[self setPlayerLayer:playerLayer];

        NSLog(@"Exiting %s", __PRETTY_FUNCTION__); 
	}
    
	return self;
}

+(CGPoint) locationFromTouch:(UITouch*)touch
{
	CGPoint touchLocation = [touch locationInView: [touch view]];
	return [[CCDirector sharedDirector] convertToGL:touchLocation];
}

+(CGPoint) locationFromTouches:(NSSet*)touches
{
	return [self locationFromTouch:[touches anyObject]];
}

- (void)shutdownGameScene{
    
    //PopChalkTalk if needed
    
    //Save all players last positions to Database and mark the game closed 
    
}


- (void) dealloc {
	//self.backgroundLayer = nil;
	//self.playerLayer = nil;
	//self.hudLayer = nil;
    
    [hudLayer release];
    [backgroundLayer release];
    [playerLayer release];
	
	[super dealloc];
}


@end
