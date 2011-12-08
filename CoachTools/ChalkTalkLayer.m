//
//  HelloWorldLayer.m
//  CoachTools
//
//  Created by cj on 4/4/11.
//  Copyright Desch Enterprises 2011. All rights reserved.
//


// Import the interfaces
#import "ChalkTalkLayer.h"
#import "PlayerSprite.h"
//#import "ConfigMenuViewController.h"
#import "CocoaHelper.h"
#import "HUDLayer.h"

CCSprite *bg;
CCSprite *bench;
CCSprite *homeGoalEvent;
CCSprite *awayGoalEvent;
PlayerSprite *soccerBall;

//CCLayer *hudLayer;

CCLabelTTF *text;
CCLabelTTF *timeLabel;

PlayerSprite *home1;
PlayerSprite *away1;

CGPoint touchOrigin;
CGPoint touchStop;

// HUD Layer - Bench
BOOL benchState = FALSE;
CGPoint benchShowPosition;
CGPoint benchHidePosition;


float SWIPE_Horizontal_THRESHOLD = 10;

// HelloWorldLayer implementation
@implementation ChalkTalkLayer

@synthesize timeInt = _timeInt;
@synthesize playersList;
//@synthesize configMenuViewController;
@synthesize myPlayers;

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
        //Add Background to scene
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
        
        // --- Game Management Config Menu --- // Modal View Controll
        // allocate for later display
        //configMenuViewController = [[ConfigMenuViewController alloc] initWithNibName:@"ConfigMenuViewController" bundle:nil];
        
        // --- Scene Title -----//
		// Create and initialize a Title Label
		//CCLabelTTF *label = [CCLabelTTF labelWithString:@"CoachTools" fontName:@"Helvetica" fontSize:40];
		//label.position =  ccp( size.width/10 , 675 ); //size.height/2 // 750
		// add the label as a child to this Layer
		//[self addChild: label];
        
        // --- Scene Menu ---- //
        // Button to add more sprites to the layer
		
        // Player Buttons
        CCMenuItemFont *addHP = [CCMenuItemFont itemFromString:@"Add Home Player" target:self selector:@selector(addHomePlayer:)];
		addHP.position=ccp(915,30);
		
        CCMenuItemFont *addAP = [CCMenuItemFont itemFromString:@"Add Away Player" target:self selector:@selector(addAwayPlayer:)];
		addAP.position=ccp(675,30);
        
        CCMenuItemFont *playerFormation = [CCMenuItemFont itemFromString:@"Player Formation" target:self selector:@selector(playerConfig:)];
		playerFormation.position=ccp(675,65);
        
        CCMenuItemFont *moveLayer = [CCMenuItemFont itemFromString:@"move Layer" target:self selector:@selector(moveLayer:)];
		moveLayer.position=ccp(915,65);
        
        
        CCMenu *menu = [CCMenu menuWithItems:addHP,addAP,playerFormation,moveLayer, nil];
		[self addChild:menu];
		menu.position=ccp(0,0);
        
        // ---- Scene Game Timer (Game Clock) --- // 
        /*
        NSInteger mins = 0;
        NSInteger secs = 0;
        _timeInt = 0;
        
        //Set Game Timer Schedule with interval of 1 second
        [self schedule: @selector(gameCounter:) interval:1.0f];
        //initialize label and set format 
        timeLabel =[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%02d:%02d", mins, secs]  fontName:@"Helvetica" fontSize:40];
        
		//[timeLabel setAnchorPoint:ccp(0, 0)];   // Not Needed
		timeLabel.position = ccp(size.width/2,675);  //750
        
		[self addChild:timeLabel z:1 tag:timeInt];
        */
        // ---- Add an array of objects with names ---- // 
        // This information is what will be retrieved from coreData 
        // playerName, playerNumber
        
        // Create random list of names for demo purposes
        playersList = [NSMutableArray arrayWithObjects:@"Matt", @"Jack", @"Larry", @"Maureen", @"Ally", @"Shannon", nil];
        
        //Intialize Sprites
        
        myPlayers = [[NSMutableDictionary alloc] init];
        
        for(NSString *nameString in playersList)
        {
            PlayerSprite *s = [PlayerSprite spriteWithFile:@"player1small2.png" ];
            [s setPlayerName:nameString];
            s.position=ccp(arc4random() % 480,arc4random() % 320);
            [myPlayers setObject:s forKey:nameString];
            [self addChild:[myPlayers objectForKey:nameString]];
        }
        
        // ---- Scene Collision Detection --- //
        
        // use schedule update to detect for collisions with every frame
        // detect collisions with every frame
        // TODO: Each object will have to check for collisions with each other -- Must update for performance later to only have the touched object check for collisions with others
        [self scheduleUpdate];
        
        // ---- Set Player Formations ---- //
        
        // ---- SoccerBall ----- //
        soccerBall = [PlayerSprite spriteWithFile:@"soccer_ball.png" ];
        //[soccerBall setPlayerName:@"Larry"];
        soccerBall.position=ccp(size.width/2, 42);
        [self addChild:soccerBall];
       
        
        /*
        hudLayer = [HUDLayer node];
        // add layer as a child to scene
        [self addChild: hudLayer];
        
        CGSize benchSize = [hudLayer contentSize];
        benchShowPosition = CGPointMake(benchSize.width / 2, size.height/2 ); 
        benchHidePosition = CGPointMake(- benchSize.width , size.height/2 ); 

        benchState = FALSE;
        */
	}
	return self;
}


//Testing -- Add a Home Player
- (void) addHomePlayer:(id)sender{
	//
	//	Add a sprite and position it randomly on the screen
	//
	PlayerSprite *s = [PlayerSprite spriteWithFile:@"player1small2.png"];
    [s setPlayerName:@"Home Player"];
    NSInteger mins = self.timeInt %  60;
    [s setPlayerNumber:[NSString stringWithFormat:@"%02d", mins]];
    s.position=ccp(arc4random() % 480,arc4random() % 320);
	[self addChild:s];
    
}

//Testing -- add a Away Player
- (void) addAwayPlayer:(id)sender{
	//
	//	Add a sprite and position it randomly on the screen
	//
	PlayerSprite *s = [PlayerSprite spriteWithFile:@"player2small.png"];
	//[s setPlayerName:@"Ally"];
    //NSInteger mins = self.timeInt %  60;
    //[s setPlayerNumber:[NSString stringWithFormat:@"%02d", mins]];
    s.position=ccp(arc4random() % 480,arc4random() % 320);
	[self addChild:s];
    
}

//Pause 'game' and go to the ConfiguMenuViewController -- Animated
//May not need
-(void)gameManagementConfigMenu{
    //[CocoaHelper showUIViewController:configMenuViewController];
}


//Testing - Player Formation
- (void) playerConfig:(id)sender{
    
    //TODO: Fix
    NSMutableArray *b = [NSMutableArray arrayWithObjects:@"Matt", @"Jack", @"Larry", @"Maureen", @"Ally", @"Shannon", nil];
    
    CGPoint vertices2[] = { ccp(460, 600), ccp(460, 410), ccp(460, 245), ccp(285, 600), ccp(285,245), ccp(62,410) }; 
    int i = 0;

    for(NSString *nameString in b)
    {
        //NSLog(@"Moving Sprites");
        //CGPoint location = [self convertTouchToNodeSpace: touch];
        
        [[myPlayers objectForKey:nameString] stopAllActions];
        [[myPlayers objectForKey:nameString] runAction: [CCMoveTo actionWithDuration:1 position:vertices2[i]]];
        i++;
    }
    
}

- (void) moveLayer:(id)sender{
    NSLog(@"Moving the Layer");
   // hudLayer.position(
//    NSLog(@"x: %02f y: %02f", hudLayer.position.x, hudLayer.position.y);                  
//    CGPoint touchPoint = CGPointMake( hudLayer.position.x +5, hudLayer.position.y);
//    hudLayer.position = touchPoint;
//    NSLog(@"x: %02f y: %02f", hudLayer.position.x, hudLayer.position.y);       
}

// Game Counter
- (void) gameCounter: (ccTime)dt
{	
    //TODO: Change Label from String to LabelAtlas - Since this is updated frequently, the label takes long to draw and consumes resources. Use Hiero to make font atlas
    //TODO: Game Counter stops when entering GameManagementConfigMenu -- Game Counter may need to be moved outside of scene and into world. Need to explor this issue. 
    
    //Increment the for every second of the game
	self.timeInt++;
    
    //Find the minutes and seconds based on the seconds counted
	NSInteger secs = self.timeInt %  60;
	NSInteger mins = self.timeInt /  60;
    
    //Update the Game Clock on the screen with 00:00 format.
	[timeLabel setString:[NSString stringWithFormat:@"%02d:%02d", mins, secs]];
    
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
    
    //TODO:Animate the process of the assist or Goal achivement
    
}

- (void) stopGameCounter:(id)sender{
    //Pause/Stop Game Counter
    [self unschedule:@selector(gameCounter:)];
}

- (void) resumeGameCounter:(id)sender{
    [self schedule: @selector(gameCounter:) interval:1.0f];
    
}


- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSSet *set = [event allTouches];
    
    if(set.count == 2)
    {
        NSArray *array = [set allObjects];
       	CGPoint touch1GL = [[array objectAtIndex:0] locationInView:[[array objectAtIndex:0] view]];
       	CGPoint touch2GL = [[array objectAtIndex:1] locationInView:[[array objectAtIndex:1] view]];
        touch1GL = [[CCDirector sharedDirector] convertToGL:touch1GL];
        touch2GL = [[CCDirector sharedDirector] convertToGL:touch2GL];
        
        // calculate the distance between the two points
        //GLfloat currentDistance = ccpDistance(touch1GL, touch2GL);
        
        // calculate the new mid point between the two touches
        touchOrigin = CGPointMake((touch1GL.x + touch2GL.x) / 2, (touch1GL.y + touch2GL.y) / 2);

        //NSLog(@"Multi Touch! Began");
    }
    
    /*
    if(set.count == 2)
    {
        //DONE --> TODO: When in Game Config Menu - If multi touch is received again, the game menu should dissappear
        if([CocoaHelper isViewControllerInUse]){
            [CocoaHelper hideUIViewController];
        }else{
            [CocoaHelper showUIViewController:configMenuViewController]; 
        }
        
        NSLog(@"Multi Touch! Began");
    }
     */
    
    
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    NSSet *set = [event allTouches];
    
    if(set.count == 2)
    {
        NSArray *array = [set allObjects];
       	CGPoint touch1GL = [[array objectAtIndex:0] locationInView:[[array objectAtIndex:0] view]];
       	CGPoint touch2GL = [[array objectAtIndex:1] locationInView:[[array objectAtIndex:1] view]];
        touch1GL = [[CCDirector sharedDirector] convertToGL:touch1GL];
        touch2GL = [[CCDirector sharedDirector] convertToGL:touch2GL];
        
        // calculate the distance between the two points
        GLfloat currentDistance = ccpDistance(touch1GL, touch2GL);
        
        // calculate the new mid point between the two touches
        touchStop = CGPointMake((touch1GL.x + touch2GL.x) / 2, (touch1GL.y + touch2GL.y) / 2);
        
        float deltaX = touchStop.x - touchOrigin.x;
        NSLog(@"delta x %f", deltaX);
        NSLog(@"current x %f", currentDistance);
        if (deltaX>SWIPE_Horizontal_THRESHOLD) {
			//distanceX = touchStop.x - touchOrigin.x;
			NSLog(@"good swipe");
            
            
             if(benchState == FALSE){
                 //hudLayer.position = CGPointMake((hudLayer.position.x + 120), hudLayer.position.y);;
                 //[hudLayer showBench];
                 self.position = CGPointMake((self.position.x + 120), self.position.y);
                 benchState = TRUE;
             }else{
                 NSLog(@"Bench Showing");
             }

		}
        
        else if (deltaX<SWIPE_Horizontal_THRESHOLD){
            if(benchState == TRUE){
                //hudLayer.position = CGPointMake((hudLayer.position.x - 120), hudLayer.position.y);;
                //[hudLayer showBench];
                self.position = CGPointMake((self.position.x - 120), self.position.y);
                benchState = FALSE;
            }else{
                NSLog(@"Bench Showing");
            }

        }
        //NSLog(@"Multi Touch! Began");
    }
    
    
    
    
    /*
    if(set.count == 2)
    {
        NSLog(@"Multi Touch! Moved");
        
    }
    */
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    // NSLog(@"Background Touch Ended");
    
    touchStop.x = 0;
    touchStop.y = 0;
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
