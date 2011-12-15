//
//  SelectStartersLayer.m
//  CoachTools
//
//  Created by cj on 7/6/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import "SelectStartersLayer.h"
#import "GameScene.h"
#import "PlayerSprite.h"
#import "SlotSprite.h"
#import "Person.h"
#import "RootViewController.h"
#import "Game.h"
#import "GameStart.h"
#import "PlistStringUtil.h"

#import "GameManagementViewController.h"

static SelectStartersLayer *sharedInstance;

@implementation SelectStartersLayer

@synthesize formationLabel;
@synthesize playersArray;
@synthesize slotPositionsArray;
@synthesize formationPositionsArray;

@synthesize storedPositionsListArray;
@synthesize storedPositionsDict;

@synthesize targetSlot;
@synthesize touchedPlayer;

@synthesize finalFormationSelection;

@synthesize game;

int currentFormationIndex = 0;

+ (SelectStartersLayer *)sharedScene {	
    return sharedInstance;
}

+(CCScene *) scene
{
     // 'scene' is an autorelease object.
     CCScene *scene = [CCScene node];
 
     // 'layer' is an autorelease object.
     SelectStartersLayer *layer = [SelectStartersLayer node];
 
     // add layer as a child to scene
     [scene addChild: layer];
 
     // return the scene
     return scene;
}


// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        self.isTouchEnabled = YES;
        
        
        sharedInstance = self;
        //NSLog(@"%s", __PRETTY_FUNCTION__); 
        
        //load the formations
        [self loadFormations];
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        game = [GameManagementViewController sharedController].game;
        NSArray *list = [[[game season] team].players allObjects];
        
        playersArray = [list mutableCopy];
        
        CCSprite *bg = [CCSprite spriteWithFile:@"soccerField3.png"];
        [bg setPosition:ccp(size.width/2 , size.height/2 )];
        //Add Background to scene
        [self addChild:bg z:0];
        
        // --- Scene Title -----//
		// Create and initialize a Title Label
		//CCLabelTTF *label = [CCLabelTTF labelWithString:@"Select Starters" fontName:@"Helvetica" fontSize:40];
		//label.position =  ccp( size.width/8 , 675 ); //size.height/2 // 750
		// add the label as a child to this Layer
		//[self addChild: label];
        
        CCLabelTTF *gameLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@%@",@"Game: " , game.gameNumber] fontName:@"Helvetica" fontSize:40];
		gameLabel.position =  ccp( 100 , 675 ); //size.height/2 // 750
        [gameLabel setColor:ccRED];
		// add the label as a child to this Layer
		[self addChild: gameLabel];

        
        //CCMenuItemFont *switchSceneButton = [CCMenuItemFont itemFromString:@"Finished Selecting" target:self selector:@selector(switchScene:)];
        //[switchSceneButton setColor:ccBLUE];
		//switchSceneButton.position=ccp(120,650);
        
        CCMenuItemFont *formationButton = [CCMenuItemFont itemFromString:@"Change Formation:"  target:self selector:@selector(formation:)];
		formationButton.position=ccp(435,675);
        [formationButton setColor:ccBLUE];
        
        
        CCMenu *menu = [CCMenu menuWithItems: formationButton, nil];
		[self addChild:menu];
		menu.position=ccp(0,0);
        
        formationLabel = [CCLabelTTF labelWithString:[storedPositionsListArray objectAtIndex:currentFormationIndex] fontName:@"Helvetica" fontSize:40];
        formationLabel.position=ccp(630, 675);
        [self addChild:formationLabel];

        
        //Setup initial Formations
        NSArray* positions = [storedPositionsDict objectForKey:[storedPositionsListArray objectAtIndex:currentFormationIndex]];
        
        formationPositionsArray = [[NSMutableArray alloc] init];

        //Add the Formation Slots
        for(NSDictionary *position in positions){
            
            SlotSprite *s = [SlotSprite spriteWithFile:@"playerSelected1.png" ];
            [s.nameLabel setString:[position objectForKey:@"name"]];
            s.position=ccp([[position objectForKey:@"x"] intValue],[[position objectForKey:@"y"] intValue]);
            [formationPositionsArray addObject:s];
            [self addChild:s];
            
        }
        
        //DONT FORGET THE GOAL
        SlotSprite *s = [SlotSprite spriteWithFile:@"playerSelected1.png" ];
        [s.nameLabel setString:@"Goal"];
        s.position=ccp(160, 380);
        [formationPositionsArray addObject:s];
        [self addChild:s];
        
        //Setup Players in Team
        slotPositionsArray =  [[NSMutableArray alloc] init];

        [slotPositionsArray addObject:[NSValue valueWithCGPoint:CGPointMake(60, 65)]];
        [slotPositionsArray addObject:[NSValue valueWithCGPoint:CGPointMake(160, 65)]];                   
        [slotPositionsArray addObject:[NSValue valueWithCGPoint:CGPointMake(260, 65)]]; //3
        [slotPositionsArray addObject:[NSValue valueWithCGPoint:CGPointMake(360, 65)]]; //4
        [slotPositionsArray addObject:[NSValue valueWithCGPoint:CGPointMake(460, 65)]]; //5
        [slotPositionsArray addObject:[NSValue valueWithCGPoint:CGPointMake(560, 65)]]; //6
        [slotPositionsArray addObject:[NSValue valueWithCGPoint:CGPointMake(660, 65)]];
        [slotPositionsArray addObject:[NSValue valueWithCGPoint:CGPointMake(760, 65)]];
        [slotPositionsArray addObject:[NSValue valueWithCGPoint:CGPointMake(860, 65)]]; //8
        [slotPositionsArray addObject:[NSValue valueWithCGPoint:CGPointMake(960, 65)]];
        [slotPositionsArray addObject:[NSValue valueWithCGPoint:CGPointMake(960, 175)]];
        [slotPositionsArray addObject:[NSValue valueWithCGPoint:CGPointMake(960, 290)]];
        [slotPositionsArray addObject:[NSValue valueWithCGPoint:CGPointMake(960, 405)]];
        [slotPositionsArray addObject:[NSValue valueWithCGPoint:CGPointMake(960, 520)]];
        [slotPositionsArray addObject:[NSValue valueWithCGPoint:CGPointMake(960, 635)]];
        [slotPositionsArray addObject:[NSValue valueWithCGPoint:CGPointMake(860, 175)]];
        [slotPositionsArray addObject:[NSValue valueWithCGPoint:CGPointMake(860, 290)]];
        [slotPositionsArray addObject:[NSValue valueWithCGPoint:CGPointMake(860, 405)]];
        [slotPositionsArray addObject:[NSValue valueWithCGPoint:CGPointMake(860, 520)]];
        [slotPositionsArray addObject:[NSValue valueWithCGPoint:CGPointMake(860, 635)]];
        
        
        for(id playerSlot in slotPositionsArray)
        {
            //FIXME: adjust the number of slots displayed to be the number of players. There is a minimum of players needed to field a team.
            SlotSprite *s = [SlotSprite spriteWithFile:@"playerSelected1.png"];
            s.position= [playerSlot CGPointValue];
            [self addChild:s];
        }
        
        for(Person *playerObject in playersArray)
        {
            if (playerObject.activeValue) {
                PlayerSprite *s = [PlayerSprite spriteWithFile:@"player1small2.png" ];
                s.player = playerObject;
                [s.nameLabel setString:playerObject.lastName];
                s.position=[self setupPlayers:[playersArray indexOfObject:playerObject]];
                [self addChild:s];
            }
        }
        
    }
    return self;
}



//Return the location of the slot for player to go on top of
- (CGPoint)setupPlayers:(NSInteger)playerIndex{
    
    CGPoint point;
    if(playerIndex < [slotPositionsArray count])
    {
        point  = [[slotPositionsArray objectAtIndex:playerIndex] CGPointValue];
    }else {
        NSLog(@"ERROR: Setup players select starters");
    }
    
    return point;
}

//Move to the next scene. The starters and starting formation have been selected. 
- (void)switchScene:(id)sender{
    
    //NSLog(@"Entering %s", __PRETTY_FUNCTION__); 
    
    //Check to make sure that all the starting player slots have been filled. 
    if ([formationPositionsArray count] == [self findStartingPlayers]) {
        //Save the Starters
        [self saveStarters];
        
        //Signal that the GameController can start the next sene. 
        GameManagementViewController *sharedGameManagement = [GameManagementViewController sharedController];
        [sharedGameManagement runGameScene];
    }else{
        
        //Check if empty
        NSMutableArray *msgParams = [[[NSMutableArray alloc] init] autorelease];
        [msgParams addObject:@"Starting Players"];
        
        UIAlertView *someError = [[UIAlertView alloc] initWithTitle:[PlistStringUtil retrieveErrorText:@"startingPlayerSlots.title" withParams:msgParams] message:[PlistStringUtil retrieveErrorText:@"startingPlayerSlots.msg" withParams:msgParams] delegate: self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [someError show];
        [someError release];
        
    }
        
    //NSLog(@"Exiting %s", __PRETTY_FUNCTION__); 
     
}

- (BOOL)starterSelectionComplete{
    //Check to make sure that all the starting player slots have been filled. 
    if ([formationPositionsArray count] == [self findStartingPlayers]) {
        //Save the Starters
        [self saveStarters];
        
        return TRUE;
        
    }else{
        
        //Check if empty
        NSMutableArray *msgParams = [[[NSMutableArray alloc] init] autorelease];
        [msgParams addObject:@"Starting Players"];
        
        UIAlertView *someError = [[UIAlertView alloc] initWithTitle:[PlistStringUtil retrieveErrorText:@"startingPlayerSlots.title" withParams:msgParams] message:[PlistStringUtil retrieveErrorText:@"startingPlayerSlots.msg" withParams:msgParams] delegate: self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [someError show];
        [someError release];
        
    }
    
    return FALSE;
}


//Setup the Formation Slots. If the user clicks the formation button, rearrange the position slot to the new location
- (void)formation:(id)sender{

    //cycle through all the positions in the array.
    //move one position each time the button is clicked. 
    
    currentFormationIndex ++;
    
    //Get all the childeren
    CCArray *arr = [self children];
    
    if (currentFormationIndex  < [storedPositionsListArray count])
    {
        [formationLabel  setString:[storedPositionsListArray objectAtIndex:currentFormationIndex]];
        
        //
        //Move players into formation
        NSArray* positions = [storedPositionsDict objectForKey:[storedPositionsListArray objectAtIndex:currentFormationIndex]];
        
        for(NSDictionary *position in positions){
            //NSLog(@"pos: %@",[position objectForKey:@"name"]);
            //NSLog(@"x  : %@",[position objectForKey:@"x"]);
            //NSLog(@"y  : %@",[position objectForKey:@"y"]);
            
            SlotSprite *s = [formationPositionsArray objectAtIndex:[positions indexOfObject:position]];
            [s.nameLabel setString:[position objectForKey:@"name"]];
            
            //check if there is a player node on top of that slot.
            for(CCNode *mynode in arr)
            {
                //Only check player sprites
                if([mynode isKindOfClass:[PlayerSprite class]]){
                    PlayerSprite *target = [arr objectAtIndex:[arr indexOfObject:mynode]];
                    if([s collidesWith:target] || [target collidesWith:s])
                    {
                        //Move the Player on top of the slot
                        [target runAction: [CCMoveTo actionWithDuration:1 position:ccp([[position objectForKey:@"x"] intValue],[[position objectForKey:@"y"] intValue])]];
                    }
                }
            }

            //Move the Player Slot
            [s runAction: [CCMoveTo actionWithDuration:1 position:ccp([[position objectForKey:@"x"] intValue],[[position objectForKey:@"y"] intValue])]];
        }

  
    }else{
        currentFormationIndex = 0;
        [formationLabel  setString:[storedPositionsListArray objectAtIndex:currentFormationIndex]];
        
        //
        //Move players into formation
        NSArray* positions = [storedPositionsDict objectForKey:[storedPositionsListArray objectAtIndex:currentFormationIndex]];
                
        for(NSDictionary *position in positions){
            //NSLog(@"pos: %@",[position objectForKey:@"name"]);
            //NSLog(@"x  : %@",[position objectForKey:@"x"]);
            //NSLog(@"y  : %@",[position objectForKey:@"y"]);
            
            SlotSprite *s = [formationPositionsArray objectAtIndex:[positions indexOfObject:position]];
            [s.nameLabel setString:[position objectForKey:@"name"]];
            
            //check if there is a player node on top of that slot.
            for(CCNode *mynode in arr)
            {
                //Only check player sprites
                if([mynode isKindOfClass:[PlayerSprite class]]){

                    PlayerSprite *target = [arr objectAtIndex:[arr indexOfObject:mynode]];
                    if([s collidesWith:target] || [target collidesWith:s])
                    {
                        //Move the Player on top of the slot
                        [target runAction: [CCMoveTo actionWithDuration:1 position:ccp([[position objectForKey:@"x"] intValue],[[position objectForKey:@"y"] intValue])]];
                    }
                }
            }
            
            //Move the player slot
            [s runAction: [CCMoveTo actionWithDuration:1 position:ccp([[position objectForKey:@"x"] intValue],[[position objectForKey:@"y"] intValue])]];
        }
    }
}

//Load the formations from the plist. The number of slots on the formation will depend on the league --> Num players on field
- (void)loadFormations{
    
    storedPositionsListArray = [[NSMutableArray alloc] init];
    storedPositionsDict = [[NSMutableDictionary alloc] init];
    
    // Path to the plist (in the application bundle)
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Formations" ofType:@"plist"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        //NSLog(@"The file exists");
    } else {
        NSLog(@"The file does not exist");
    }
    
    NSArray *myArray = [[NSArray alloc] initWithContentsOfFile:path];
    //NSLog(@"The count: %i", [myArray count]);
    
    for(NSDictionary *dict in myArray)
    {
        NSString *numPlayers = [dict objectForKey:@"numPlayers"];
        
        //Load the formations based on the number of players in that formation
        if([numPlayers intValue] == [GameManagementViewController sharedController].numPlayers ){
            NSArray *formArray = [dict objectForKey:@"formations"];
            for(NSDictionary *formsDict in formArray)
            {
                [storedPositionsListArray addObject:[formsDict objectForKey:@"name"]];
                [storedPositionsDict setValue:[formsDict objectForKey:@"positions"] forKey:[formsDict objectForKey:@"name"]];
                
            }
        }
    }
    
    [myArray dealloc];
}

////////////////////////////////
//touches
- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    // NSLog(@"Began");
    //UITouch *touch = [touches anyObject];
    //location = [touch locationInView:[touch view]];
    //location = [[CCDirector sharedDirector] convertToGL:location];
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{

    //Get All the touches on the screen
    NSSet *set = [event allTouches];
    NSArray *array = [set allObjects];
    CGPoint touch1GL = [[array objectAtIndex:0] locationInView:[[array objectAtIndex:0] view]];
    touch1GL = [[CCDirector sharedDirector] convertToGL:touch1GL];

    //Get all the children
    CCArray *arr = [self children];
    
    //
    touchedPlayer = NULL;
    targetSlot = NULL;
    //DragSprite *touchedObject = NULL; //Set the pointer to default as NULL because Objective-C Blows. 15 minutes on stupid empty pointers.... I want to smack steve jobs. 
    
    
    //Find the Object that is being Touched
    for(CCNode *mynode in arr)
    {
        
        if([mynode isKindOfClass:[PlayerSprite class]]){
            
            PlayerSprite *touched = [arr objectAtIndex:[arr indexOfObject:mynode]];
            if (touched.isDrag)
            {
                //NSLog(@"%@ is being touched", mynode.playerName);
                //[self reorderChild:mynode z:0]; // Make the sprite touched be the sprite on top
                touchedPlayer = touched;
                touchedPlayer.playerSelected.visible = FALSE;
                break;
            }
        }
        
    }
    
    //Determine if the touched object is colliding with another sprite
    //Check if an object is being touched first
    if(touchedPlayer != NULL)
    {
        //NSLog(@"%@ is being touched....", touchedObject.playerName);
        for(CCNode *mynode in arr)
        {
            if([mynode isKindOfClass:[SlotSprite class]]){

                SlotSprite *target = [arr objectAtIndex:[arr indexOfObject:mynode]];
                if([touchedPlayer collidesWith:target])
                {
                    //NSLog(@"Node: %@ collided with: %@", [touchedObject playerName], [mynode playerName]);
                    //target.nodeSelected.visible = TRUE;
                    //Save the player that is under the collision
                    targetSlot = target;
                    break;
                }else{
                    //target.nodeSelected.visible = FALSE;
                }
            }
        }
    }
}

//Touches have ended
- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{


    //check to make sure there was a collision at the end of the touch.
    if((touchedPlayer != NULL) && (targetSlot != NULL))
    {
        //NSLog(@"Touched %@", touchedPlayer.playerName);
        //NSLog(@"Target %@", targetSlot.nameLabel);

        //Check if there is NOT another player on that slot before moving it
        if([self checkPlayerOverlap]){
            //Move the player to the slot
            [touchedPlayer runAction: [CCMoveTo actionWithDuration:1 position:targetSlot.position]];
            
        }else{
            //Move Player back to its orgional spot
            [touchedPlayer runAction: [CCMoveTo actionWithDuration:1 position:touchedPlayer.previousPosition]];
        }
        
        //Reset the target and touched object
        targetSlot.nodeSelected.visible = FALSE;
        touchedPlayer.playerSelected.visible = FALSE;
        touchedPlayer = NULL;
        targetSlot = NULL;
        
    }else if ( (touchedPlayer != NULL) && (targetSlot == NULL))
    {
        //Move Player back to its orgional spot
        [touchedPlayer runAction: [CCMoveTo actionWithDuration:1 position:touchedPlayer.previousPosition]];
    }
    
}

//Check if two player sprites are overlapping with the touched player (may want to make this generic and just check if two players are overlapping)
- (BOOL)checkPlayerOverlap{
    
    CCArray *arr = [self children];
    for(CCNode *mynode in arr)
    {
        //Find all the Player sprite Childeren
        if([mynode isKindOfClass:[PlayerSprite class]]){
            
            PlayerSprite *playerNode = [arr objectAtIndex:[arr indexOfObject:mynode]];
            //Check if player is the same node as the one being touched
            if (playerNode != touchedPlayer){
                
                //Check if the touched player collides with another player
                if([touchedPlayer collidesWith:playerNode]){
                    return FALSE;
                }
            }
            
        }
    }
    
    //No Players were found overlapping, Check is complete.
    return TRUE;
}

- (int)findStartingPlayers{
    
    //May not need
    /*****
    //Check if this has been allocated
    if(finalFormationSelection == nil){
        //allocate
        finalFormationSelection = [[NSMutableArray alloc] init];   
    }else
    {
        [formationPositionsArray release];
        finalFormationSelection = [[NSMutableArray alloc] init];   

    }
    
    NSMutableDictionary *finalStartingFormations = [[NSMutableDictionary alloc ] init];
    */
    int count = 0;
    
    CCArray *arr = [self children];
    for(CCNode *mynode in arr)
    {
        //Find all the Player sprite Childeren
        if([mynode isKindOfClass:[PlayerSprite class]]){
            
            PlayerSprite *playerNode = [arr objectAtIndex:[arr indexOfObject:mynode]];
            //Check if player is the same node as the one being touched
            for(SlotSprite *formationSlot in formationPositionsArray){
                //Check if the slot player collides with player
                if([formationSlot collidesWith:playerNode]){
                  
                    count ++;
                                      
                }
            }
            
        }
    }

    
    return count;

}


//Find all the players that are starters.
//Save the players that were on in the formation slots, which slot and which formation to the database
- (void)saveStarters{
    
    
    RootViewController *sharedAppController = [RootViewController sharedAppController];
    NSManagedObjectContext *managedObjectContext = [sharedAppController managedObjectContext];
    
    CCArray *arr = [self children];
    for(CCNode *mynode in arr)
    {
        //Find all the Player sprite Childeren
        if([mynode isKindOfClass:[PlayerSprite class]]){
            
            PlayerSprite *playerNode = [arr objectAtIndex:[arr indexOfObject:mynode]];
            //Check if player is the same node as the one being touched
            for(SlotSprite *formationSlot in formationPositionsArray){
                //Check if the slot player collides with player
                if([formationSlot collidesWith:playerNode]){
                    
                    //Create New Game Sub Entry
                    GameStart *gameStarter = [NSEntityDescription insertNewObjectForEntityForName:@"GameStart" inManagedObjectContext:managedObjectContext];
                
                    //Assign the Game
                    gameStarter.game = game;

                    //Assign the player thats at that node
                    gameStarter.player = playerNode.player;
                    //Assign Position
                    gameStarter.positionName = [[formationSlot nameLabel] string];
                    
                    gameStarter.formationSlot = [NSNumber numberWithInt:[formationPositionsArray indexOfObject:formationSlot]];
                    
                    //Save this new Starter to DB
                    NSError *error = nil;
                    if (![managedObjectContext save:&error]) {
                        
                        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                        abort();
                    }
                
                }
            }
                
        }
    }
    
    game.startingFormation = [formationLabel string];
    
    //Save this new Formation to DB
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }

}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
    [playersArray release];
    [slotPositionsArray release];
    [formationPositionsArray release];
    [storedPositionsDict release];
    [storedPositionsListArray release];
    [finalFormationSelection release];
	[super dealloc];
}

@end
