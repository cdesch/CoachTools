//
//  HelloWorldLayer.m
//  CoachTools
//
//  Created by cj on 4/4/11.
//  Copyright Desch Enterprises 2011. All rights reserved.
//


// Import the interfaces
#import "ChalkTalkLayer.h"
#import "DragSprite.h"

//#import "DrawMyTouch.h"
#import "TouchDraw.h"

CCSprite *bg;
CCSprite *homeGoalEvent;
CCSprite *awayGoalEvent;

DragSprite *soccerBall;

CGPoint touchOrigin;
CGPoint touchStop;
NSMutableArray* naughtyTouchArray;

NSMutableArray* drawPoints;

NSInteger TOUCH_DRAWER_TAG = 99;
NSInteger ICONS_TAG = 98;

// HelloWorldLayer implementation
@implementation ChalkTalkLayer

/*
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}*/

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        
        //Enable Touch - multiple touch -- not needed if not watching for multiple touch-- each sprite handles its own touch. 
        self.isTouchEnabled = YES;
        
        // ask director the the window size
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        // --- Scene Background --- //
        //create background sprite
        bg = [CCSprite spriteWithFile:@"soccerField3.png"];
        [bg setPosition:ccp(size.width/2 , size.height/2 )];
        [self addChild:bg z:0];
        
        //HomeGoal
        homeGoalEvent = [CCSprite spriteWithFile:@"homeGoal1.png"];
        [homeGoalEvent setPosition:ccp(42, size.height/2+ 23 )];
        [self addChild:homeGoalEvent z:0];
        homeGoalEvent.visible = FALSE;
        
        //AwayGoal
        awayGoalEvent = [CCSprite spriteWithFile:@"awayGoal1.png"];
        [awayGoalEvent setPosition:ccp(982, size.height/2+ 23 )];
        [self addChild:awayGoalEvent z:0];
        awayGoalEvent.visible = FALSE;

        iconsArray = [[NSMutableArray alloc] init];
        
        // --- Scene Menu ---- //
        // Button to add more sprites to the layer
		
        // Player Buttons
        CCMenuItemFont *addHP = [CCMenuItemFont itemFromString:@"Add Home Player" target:self selector:@selector(addHomePlayer:)];
		addHP.position=ccp(915,30);
		
        CCMenuItemFont *addAP = [CCMenuItemFont itemFromString:@"Add Away Player" target:self selector:@selector(addAwayPlayer:)];
		addAP.position=ccp(150,30);
        
        CCMenuItemFont *clearLines = [CCMenuItemFont itemFromString:@"Clear Lines" target:self selector:@selector(cleanLines:)];
		clearLines.position=ccp(425,30);
        
        CCMenuItemFont *clearAll = [CCMenuItemFont itemFromString:@"Clear All" target:self selector:@selector(cleanAll:)];
		clearAll.position=ccp(650,30);

        CCMenu *menu = [CCMenu menuWithItems:addHP,addAP,clearLines,clearAll, nil];
		[self addChild:menu];
		menu.position=ccp(0,0);
        

        // ---- Scene Collision Detection --- //
        // use schedule update to detect for collisions with every frame
        // detect collisions with every frame
        [self scheduleUpdate];

        // ---- SoccerBall ----- //
        soccerBall = [DragSprite spriteWithFile:@"soccer_ball.png" ];
        soccerBall.position=ccp(150, 150);
        [self addChild:soccerBall];

        naughtyTouchArray = [[NSMutableArray alloc] init];
       
	}
	return self;
}


//Testing -- Add a Home Player
- (void) addHomePlayer:(id)sender{
	//
	//	Add a sprite and position it randomly on the screen
	//

    [self spawnSpriteWithImage:@"player1small2.png"];    
}

//Testing -- add a Away Player
- (void) addAwayPlayer:(id)sender{
	//
	//	Add a sprite and position it randomly on the screen
	//
    [self spawnSpriteWithImage:@"player2small.png"];

}

- (void)spawnSpriteWithImage:(NSString*)image{
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    float offsetX = [self randomFloatBetween:.4 and:1.5];
    float offsetY = [self randomFloatBetween:.4 and:1.5];
    
    DragSprite *spriteIcon = [DragSprite spriteWithFile:image];
    spriteIcon.position=ccp( (size.width/2)*offsetX, (size.height/2)*offsetY);
    [spriteIcon setTag:ICONS_TAG];
	[self addChild:spriteIcon];
    [iconsArray addObject:spriteIcon];
}

- (void)cleanLines:(id)sender{
    // remove points from the line array
    [drawPoints removeAllObjects];
    
    // remove the node from the scene
    CCNode *drawer = [self getChildByTag:TOUCH_DRAWER_TAG];
    [self removeChild:drawer cleanup:YES];

}
- (void)cleanAll:(id)sender{
    // remove points from the line array
    [drawPoints removeAllObjects];
    
    // remove the node from the scene
    CCNode *drawer = [self getChildByTag:TOUCH_DRAWER_TAG];
    [self removeChild:drawer cleanup:YES];
    
    for (DragSprite* icon in iconsArray){
        [self removeChild:icon cleanup:YES];    
    }
    
    [iconsArray removeAllObjects];    
}




//update - ScheduleUpdate runs every frame
- (void)update:(ccTime)dt{

    //Check if sprite collided with any other sprites
    //Check if sprite collided with any standing objects (sub box, goal)
    
    CGRect touchedObject = [soccerBall boundingBox];
    CGRect targetObjectHomeGoal = [homeGoalEvent boundingBox];
    CGRect targetObjectAwayGoal = [awayGoalEvent boundingBox];    
    
    //Home Goal is touched
    if (CGRectIntersectsRect(touchedObject, targetObjectHomeGoal))
    {
        
        //NSLog(@"Attempting Collision Detected!");
        // Collision!
        if (homeGoalEvent.visible != TRUE)
        {
            homeGoalEvent.visible = TRUE;
        }
    }else
    {
        // No Collision
        if (homeGoalEvent.visible != FALSE)
        {
            homeGoalEvent.visible = FALSE;
        }
    }
    
    //Away Goal is touched
    if (CGRectIntersectsRect(touchedObject, targetObjectAwayGoal))
    {

        //NSLog(@"Attempting Collision Detected!");
        // Collision!
        if (awayGoalEvent.visible != TRUE)
        {
            awayGoalEvent.visible = TRUE;
        }
    }else
    {
        // No Collision
        if (awayGoalEvent.visible != FALSE)
        {
            awayGoalEvent.visible = FALSE;
        }
    }    
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSSet *set = [event allTouches];
    
    if(set.count == 1)
    {       
    }
    
    
    if (drawPoints == nil)
    {
        drawPoints = [[NSMutableArray alloc] initWithCapacity:2];
    }
    
    // add the drawer node to the game view
    TouchDraw *drawer = [TouchDraw node];
    [drawer setDrawPoints:drawPoints];
    [drawer setTag:TOUCH_DRAWER_TAG];

    [self addChild:drawer];
    
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    NSSet *set = [event allTouches];

    if(set.count == 1)
    {
    }    
    /*
    UITouch *touchMyMinge = [touches anyObject];
    
    CGPoint currentTouchArea = [touchMyMinge locationInView:[touchMyMinge view] ];
    CGPoint lastTouchArea = [touchMyMinge previousLocationInView:[touchMyMinge view]];
    
    // flip belly up. no one likes being entered from behind.
    currentTouchArea = [[CCDirector sharedDirector] convertToGL:currentTouchArea];
    lastTouchArea = [[CCDirector sharedDirector] convertToGL:lastTouchArea];
    
    // throw to console my inappropriate touches
    NSLog(@"current x=%2f,y=%2f",currentTouchArea.x, currentTouchArea.y);
    NSLog(@"last x=%2f,y=%2f",lastTouchArea.x, lastTouchArea.y);  
    
    // add my touches to the naughty touch array 
    [naughtyTouchArray addObject:NSStringFromCGPoint(currentTouchArea)];
    [naughtyTouchArray addObject:NSStringFromCGPoint(lastTouchArea)];
     */
    // add the point to the drawer
    UITouch *touch = [touches anyObject];
    CGPoint currentLocation = [touch locationInView:[touch view]];
    CGPoint previousLocation = [touch previousLocationInView:[touch view]];
    currentLocation = [[CCDirector sharedDirector] convertToGL:currentLocation];
    previousLocation = [[CCDirector sharedDirector] convertToGL:previousLocation];
    currentLocation = [self convertToNodeSpace:currentLocation];
    previousLocation = [self convertToNodeSpace:previousLocation];
    
    [drawPoints addObject:NSStringFromCGPoint(currentLocation)];
    [drawPoints addObject:NSStringFromCGPoint(previousLocation)];
}


- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    //DrawMyTouch *line = [DrawMyTouch node];
    //[self addChild: line];
    
    touchStop.x = 0;
    touchStop.y = 0;
}

- (float)randomFloatBetween:(float)smallNumber and:(float)bigNumber {
    float diff = bigNumber - smallNumber;
    return (((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * diff) + smallNumber;
}



// on "dealloc" you need to release all your retained objects
- (void) dealloc
{    [naughtyTouchArray release];
    naughtyTouchArray = nil;
    
    [iconsArray release];
    iconsArray = nil;
    
    // remove points from the line array
    [drawPoints removeAllObjects];
    
    // remove the node from the scene
    CCNode *drawer = [self getChildByTag:TOUCH_DRAWER_TAG];
    [self removeChild:drawer cleanup:YES];	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
    

}
@end
