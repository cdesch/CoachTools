//
//  PlayerLayer.m
//  CoachTools
//
//  Created by cj on 5/19/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import "PlayerLayer.h"
#import "RootViewController.h"
#import "PlayerSprite.h"
#import "Person.h"
#import "PlayerSprite.h"
#import "GameScore.h"
#import "GameSub.h"
#import "GameStart.h"
#import "SlotSprite.h"
#import "Season.h"
#import "Team.h"
#import "iToast.h"

@implementation PlayerLayer

@synthesize playersArray;
@synthesize targetSlot;
@synthesize targetObject;
@synthesize touchedObject;
@synthesize benchPositions;
@synthesize benchSlotsArray;
@synthesize playerFormations;
@synthesize game;
@synthesize storedPositionsListArray;
@synthesize storedPositionsDict;

@synthesize formationSlotsArray;
@synthesize currentFormationName;

@synthesize soccerBall;
@synthesize touchedSoccerBall;
@synthesize awayGoalEvent;
@synthesize homeGoalEvent;
@synthesize targetGoalEvent;
@synthesize soccerBallHomeSlot;

- (id) init {
	if((self = [super init]))
	{

        CGSize size = [[CCDirector sharedDirector] winSize];
        
        self.isTouchEnabled = YES;
        
        //Set the Game and get the players
        game = [GameManagementViewController sharedController].game;
        //Season *season = game.season;
        //Team *team = season.team;
        
        //NSArray *list = [team.players allObjects];
        NSArray *list = [[[game season] team].players allObjects];
        
        playersArray = [list mutableCopy];
        
        touchedObject = NULL;
        targetObject = NULL;
        
        //load All  the formations from the plist
        [self loadFormations];

        //initialize bench slot positions/locations
        benchPositions =  [[NSMutableArray alloc] init];
        
        [benchPositions addObject:[NSValue valueWithCGPoint:CGPointMake(-65, 65)]];
        [benchPositions addObject:[NSValue valueWithCGPoint:CGPointMake(-65, 165)]];                   
        [benchPositions addObject:[NSValue valueWithCGPoint:CGPointMake(-65, 265)]];
        [benchPositions addObject:[NSValue valueWithCGPoint:CGPointMake(-65, 365)]];
        [benchPositions addObject:[NSValue valueWithCGPoint:CGPointMake(-65, 465)]]; 
        [benchPositions addObject:[NSValue valueWithCGPoint:CGPointMake(-65, 565)]];
        [benchPositions addObject:[NSValue valueWithCGPoint:CGPointMake(-65, 665)]];
        [benchPositions addObject:[NSValue valueWithCGPoint:CGPointMake(-165, 65)]];
        [benchPositions addObject:[NSValue valueWithCGPoint:CGPointMake(-165, 165)]];                   
        [benchPositions addObject:[NSValue valueWithCGPoint:CGPointMake(-165, 265)]];
        [benchPositions addObject:[NSValue valueWithCGPoint:CGPointMake(-165, 365)]];
        [benchPositions addObject:[NSValue valueWithCGPoint:CGPointMake(-165, 465)]]; 
        [benchPositions addObject:[NSValue valueWithCGPoint:CGPointMake(-165, 565)]];
        [benchPositions addObject:[NSValue valueWithCGPoint:CGPointMake(-165, 665)]];
        

        //Setup Bench Slots
        benchSlotsArray = [[NSMutableArray alloc] init];
        
        for( NSValue *point in benchPositions){
            SlotSprite *benchSlot = [SlotSprite spriteWithFile:@"playerSelected1.png" ];
            benchSlot.position= [point CGPointValue];
            //[benchSlot.nameLabel setString:[NSString stringWithFormat: @"%d",[benchPositions indexOfObject:point]]];
            [benchSlotsArray addObject:benchSlot];
            [self addChild:benchSlot];
        }
        
        
        //initialize formations - Load intial formation from CoreData and Plist
        //Load Starting Formation
        currentFormationName = game.startingFormation;
        playerFormations = [storedPositionsDict objectForKey:game.startingFormation];
        
        formationSlotsArray = [[NSMutableArray alloc] init];
        
        for(NSDictionary *position in playerFormations){

            SlotSprite *starterSlot = [SlotSprite spriteWithFile:@"playerSelected1.png" ];
            [starterSlot.nameLabel setString:[position objectForKey:@"name"]];
            starterSlot.position=ccp([[position objectForKey:@"x"] intValue],[[position objectForKey:@"y"] intValue]);
            [formationSlotsArray addObject:starterSlot];
            [self addChild:starterSlot];
            
        }
        
        //DONT FORGET THE GOAL
        SlotSprite *starterSlot = [SlotSprite spriteWithFile:@"playerSelected1.png" ];
        [starterSlot.nameLabel setString:@"Goal"];
        starterSlot.position=ccp(160, 380);
        [formationSlotsArray addObject:starterSlot];
        [self addChild:starterSlot];
        
        //Load Starting Players
        //NSArray *startingPlayers = [[ac gameSelected].gameStart allObjects];
        NSArray *startingPlayers = [game.gameStart allObjects];
        
        //Go through each player on the team (absent players should be excluded)
        int benchSlotIndex = 0;
        
        for(Person *playerObject in playersArray){

            int positionSlotIndex =  [self starterPlayerIndex:startingPlayers player:playerObject];
            //Check if the current Player is a starting player
            if (positionSlotIndex >= 0){
                    
                //Player Found!! Add them to their position
                PlayerSprite *player = [PlayerSprite spriteWithFile:@"player1small2.png"];
                player.player = playerObject;
                [player.nameLabel setString:playerObject.lastName];
                CGPoint aPosition = [[formationSlotsArray objectAtIndex:positionSlotIndex] position];
                player.position =aPosition;

                [self addChild:player];
                    
            }else{
                //Player is not a starting player, add them to the bench
                //NSLog(@"Sent to Bench: %@ -- Bench does not exist yet- LOL", playerObject.lastName);
                //Bench does not exist yet
                PlayerSprite *player = [PlayerSprite spriteWithFile:@"player1small2.png"];
                player.player = playerObject;
                [player.nameLabel setString:playerObject.lastName];
                CGPoint aPosition = [[benchSlotsArray objectAtIndex:benchSlotIndex] position];
                
                player.position =aPosition;
                
                [self addChild:player];
                benchSlotIndex ++;
                
            }
            
        }
        //[startingPlayers release];
        
		//We set the layer position to the center of the screen
		//This will also move our player sprite to the center
		self.position = ccp(0,0 );
        
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
        
        // ---- SoccerBall ----- //
        soccerBall = [SoccerBallSprite spriteWithFile:@"soccer_ball.png" ];
        soccerBall.position=ccp(size.width/2, 42);
        [self addChild:soccerBall z:2];
        
        soccerBallHomeSlot = [SlotSprite spriteWithFile:@"playerSelected1.png" ];
        soccerBallHomeSlot.position=ccp(size.width/2, 42);
        [self addChild:soccerBallHomeSlot];
                
	}
    
	return self;
}

//check if that player is a starter player. If it is, return its slot index, if not return -1

- (int)starterPlayerIndex:(NSArray *)startingPlayers player:(Person *)player{

    //check the player is the array
    for(GameStart *starter in startingPlayers){
        if (starter.player == player){
            return [starter.formationSlot  intValue];
        }
    }

    return -1;
}

- (void)setFormation:(NSString *)formationName{
    
    //cycle through all the positions in the array.
    //move one position each time the button is clicked. 
    //NSLog(@"New Formation: %@ ", formationName);
    
    RootViewController *sharedAppController = [RootViewController sharedAppController];
    GameTimer *gameTimer = [sharedAppController gameTimer];
    
    //Get all the childeren
    CCArray *arr = [self children];
    
    if (currentFormationName  != formationName)
    {
        //NSLog(@"Move Formation");
        //Coach May want this later // This should be an option to display in the config menu via a switch
        //[formationLabel  setString:[storedPositionsListArray objectAtIndex:currentFormationIndex]];
        
        //
        
        //Move players into formation
        NSArray* positions = [storedPositionsDict objectForKey:formationName];
        //NSLog(@"num objects in positions %d", [positions count]);
        for(NSDictionary *position in positions){

            SlotSprite *s = [formationSlotsArray objectAtIndex:[positions indexOfObject:position]];
            [s.nameLabel setString:[position objectForKey:@"name"]];
            
            //check if there is a player node on top of that slot, if there is move that with the slot
            for(CCNode *mynode in arr)
            {
                //Only check player sprites
                if([mynode isKindOfClass:[PlayerSprite class]]){
                    
                    PlayerSprite *target = [arr objectAtIndex:[arr indexOfObject:mynode]];
                    if([s collidesWith:target] || [target collidesWith:s])
                    {
                        //Move the Player on top of the slot
                        [target runAction: [CCMoveTo actionWithDuration:2 position:ccp([[position objectForKey:@"x"] intValue],[[position objectForKey:@"y"] intValue])]];
                        
                        [self saveGameSub:target  position:[s.nameLabel string]];
                        touchedObject.postionStartTime = [gameTimer timeToInt];
                    }
                }
            }
            
            //Move the Player Slot
            //NSLog(@"Move Slot");
            [s runAction: [CCMoveTo actionWithDuration:2 position:ccp([[position objectForKey:@"x"] intValue],[[position objectForKey:@"y"] intValue])]];
        }
        
    }else{
    
        // Do Nothing since its the same formation
        
    }
}


//place the players in the formation
- (CGPoint)setupPlayers:(NSInteger)playerIndex{

    CGPoint point;
    if(playerIndex < [playerFormations count])
    {
        //point  = [[playerFormations objectAtIndex:playerIndex] CGPointValue];
        
        point  = ccp([[[playerFormations objectAtIndex:playerIndex] objectForKey:@"x"] intValue],[[[playerFormations objectAtIndex:playerIndex] objectForKey:@"y"] intValue]);
    }else if( playerIndex < ([playerFormations count] + [benchPositions count]) ){
        point  = [[benchPositions objectAtIndex:(playerIndex -[playerFormations count])] CGPointValue];
        
    }else {
        NSLog(@"ERROR");
    }
        
    return point;
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
   // NSLog(@"Began");
    //UITouch *touch = [touches anyObject];
    //location = [touch locationInView:[touch view]];
    //location = [[CCDirector sharedDirector] convertToGL:location];
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{

    NSSet *set = [event allTouches];
    NSArray *array = [set allObjects];
    CGPoint touch1GL = [[array objectAtIndex:0] locationInView:[[array objectAtIndex:0] view]];
    
    touch1GL = [[CCDirector sharedDirector] convertToGL:touch1GL];
    
    //NSLog(@"Moved");    
    CCArray *arr = [self children];
    //
    //touchedObject = NULL;
    targetObject = NULL;
    targetSlot = NULL;
    targetGoalEvent = NULL;
    
    //Is there already an object being touched?
    if(touchedObject == NULL && (!soccerBall.isDrag))
    {
        //Find the Object that is being Touched
        for(CCNode *mynode in arr)
        {
            //NSLog(@"   INSIDE LOOP");
            //only check PlayerSprite nodes
            if([mynode isKindOfClass:[PlayerSprite class]]){
                PlayerSprite *touched = [arr objectAtIndex:[arr indexOfObject:mynode]];
                if (touched.isDrag)
                {
                    //NSLog(@"%@ is being touched", mynode.playerName);
                    [self reorderChild:mynode z:0]; // Make the sprite touched be the sprite on top
                    touchedObject = touched;
                    break;
                }
            }
        }
    }else if(soccerBall.isDrag){
        touchedSoccerBall = soccerBall;
    }
    
    //Determine if the touched object is colliding with another sprite
    //Check if an object is being touched first
    if(touchedObject != NULL || soccerBall.isDrag)
    {
        //NSLog(@"Targeting...");
        //NSLog(@"%@ is being touched....", touchedObject.playerName);
        for(CCNode *mynode in arr)
        {
            if([mynode isKindOfClass:[SlotSprite class]]){
                
                //NSLog(@"Targeting SLots...");
                SlotSprite *target = [arr objectAtIndex:[arr indexOfObject:mynode]];
                if([target collidesWith:touchedObject])
                {
                    //NSLog(@"Node: %@ collided with: %@", [touchedObject playerName], [mynode playerName]);
                    //target.nodeSelected.visible = TRUE;
                    //Save the object that is under the collision
                    targetSlot = target;
                    break;
                }else if ([target collidesWith:touchedSoccerBall]){
                    //NSLog(@"Target Aquired");
                    targetSlot = target;
                    break;
                }
                else{
                    target.nodeSelected.visible = FALSE;
                }
            }
        }
        
        if([soccerBall collidesWith:homeGoalEvent]){
            homeGoalEvent.visible = TRUE;
            targetGoalEvent = homeGoalEvent;
        }else if([soccerBall collidesWith:awayGoalEvent]){
            awayGoalEvent.visible = TRUE;
            targetGoalEvent = awayGoalEvent;
        }else{
            awayGoalEvent.visible = FALSE;
            homeGoalEvent.visible = FALSE;
        }
    }
}
//Touches have ended, check if there was a move made. 
- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{

    //-----FOR SOCCER BALLS-----//// 
    //check to make sure there was a collision at the end of the touch.
    if((touchedSoccerBall != NULL) && (targetSlot != NULL)){
        //
    
        PlayerSprite *targetPlayer = [self findSoccerBallSpriteCollision];
        SlotSprite *touchedSlot = [self findSlot:targetPlayer]; 
        
        if(targetPlayer != NULL){
        
            //Move the player to the slot
            [touchedSoccerBall runAction:[CCMoveTo actionWithDuration:1 position:targetSlot.position]];
            
            if (touchedSoccerBall.scoringPlayer == NULL)
            {
                touchedSoccerBall.scoringPlayer = targetPlayer.player;
                touchedSoccerBall.scoringPlayerPosition = [touchedSlot.nameLabel string];

                [touchedSoccerBall.scoringPlayerNameLabel setString:[NSString stringWithFormat:@"Scoring: %@", touchedSoccerBall.scoringPlayer.lastName]];
            }else if(touchedSoccerBall.scoringPlayer != targetPlayer.player) {
                touchedSoccerBall.assistingPlayer = touchedSoccerBall.scoringPlayer;
                touchedSoccerBall.scoringPlayer = targetPlayer.player;
                touchedSoccerBall.scoringPlayerPosition = [touchedSlot.nameLabel string];
                [touchedSoccerBall.scoringPlayerNameLabel setString:[NSString stringWithFormat:@"Scoring: %@", touchedSoccerBall.scoringPlayer.lastName]];
                [touchedSoccerBall.assistingPlayerNameLabel setString:[NSString stringWithFormat:@"Assisting: %@", touchedSoccerBall.assistingPlayer.lastName]];
            }

        }
        
        /*else if(targetGoalEvent != NULL){
            //Save Data
            NSLog(@"Save Score");
            [touchedSoccerBall runAction:[CCMoveTo actionWithDuration:1 position:soccerBallHomeSlot.position]];
            [soccerBall reset];
            
        }
         */

         else if(targetSlot == soccerBallHomeSlot){
            //ABORT DO NOT SAVE
            NSLog(@"Abort! Do not save");
            [touchedSoccerBall runAction:[CCMoveTo actionWithDuration:1 position:soccerBallHomeSlot.position]];
            [soccerBall reset];
        }
        else
        {
            //Return soccerball to last slot since no one was there 
            [touchedSoccerBall runAction: [CCMoveTo actionWithDuration:1 position:touchedSoccerBall.previousPosition]];

        }
        
        //Reset if returns to its home location or Goal        
        
    }
    ///-----FOR PLAYERS ---///
    else if((touchedObject != NULL) && (targetSlot != NULL))
    {
        //NSLog(@"Touched %@", touchedObject.playerName);
        //NSLog(@"Target %@", targetObject.playerName);
             
        RootViewController *sharedAppController = [RootViewController sharedAppController];
        GameTimer *gameTimer = [sharedAppController gameTimer];
        
        SlotSprite *touchedSlot = [self findSlot:touchedObject]; 
        
        //Check the slot to see if there was a player there 
        PlayerSprite *targetPlayer = [self findPlayerSpriteCollision];
        if(targetPlayer != NULL){
            
            //Move the player to the slot
            [touchedObject runAction:[CCMoveTo actionWithDuration:1 position:targetSlot.position]];
            [targetPlayer runAction:[CCMoveTo actionWithDuration:1 position:touchedObject.previousPosition]];
            
            //Check if touched player was move FROM the bench
            if([self checkMoveFromBenchSlot:touchedObject]){
                
                //Check if the slot moved to was a bench slot
                if([self checkMoveToBenchSlot:targetSlot]){
                    //To Bench
                    //NSLog(@"From Bench To bench");
                    //Do Nothing
                    
                }else{
                    //From Field
                    //NSLog(@"From Bench To Field");
                    //NSLog(@"Subbing in and Subbing out");
                    //Save the player Target player subing out
                    [[iToast makeText:NSLocalizedString(@"Moving Player ", [touchedSlot.nameLabel string])] show];
                    [self saveGameSub:targetPlayer  position:[targetSlot.nameLabel string]];
                    targetPlayer.postionStartTime = [gameTimer timeToInt];
                    //Set the touched players time to current time
                    touchedObject.postionStartTime = [gameTimer timeToInt];
                }
                
            }else{
                //Move From Field
                
                //Check if the slot moved to was a bench slot
                if([self checkMoveToBenchSlot:targetSlot]){
                    //To Bench
                    NSLog(@"From Field To bench");
                    NSLog(@"Subbing in and Subbing out");
                    [[iToast makeText:NSLocalizedString(@"Moving Player ", [touchedSlot.nameLabel string])] show];
                    //Save the player touched player subing out
                    [self saveGameSub:touchedObject  position:[touchedSlot.nameLabel string]];
                    touchedObject.postionStartTime = [gameTimer timeToInt];
                    //Set the target player time to current time
                    //[self saveGameSub:targetPlayer  position:[targetSlot.nameLabel string]];
                    targetPlayer.postionStartTime = [gameTimer timeToInt];
                    
                    
                }else{
                    //To Field
                    //NSLog(@"From Field To Field");
                    //NSLog(@"Swapping");
                    [[iToast makeText:NSLocalizedString(@"Moving Player ", [touchedSlot.nameLabel string])] show];
                    //Save the player touched player swapping and set the time
                    [self saveGameSub:touchedObject  position:[touchedSlot.nameLabel string]];
                    touchedObject.postionStartTime = [gameTimer timeToInt];
                    //Save the player target player swapping and set the time
                    [self saveGameSub:targetPlayer  position:[targetSlot.nameLabel string]];
                    targetPlayer.postionStartTime = [gameTimer timeToInt];
                }
                
            }
            
        }else{
            
            //There is no player in the slot, move the player to the empty slot.
            [touchedObject runAction: [CCMoveTo actionWithDuration:1 position:targetSlot.position]];
            
            //Check if touched player was move FROM the bench
            if([self checkMoveFromBenchSlot:touchedObject]){
                
                //Check if the slot moved to was a bench slot
                if([self checkMoveToBenchSlot:targetSlot]){
                    //To Bench
                    //NSLog(@"From Bench To bench");
                    //Do Nothing
                    
                }else{
                    //From Field
                    //NSLog(@"From Bench To Field");
                    //NSLog(@"Subbing in ");
                    [[iToast makeText:NSLocalizedString(@"Moving Player ", [touchedSlot.nameLabel string])] show];
                    //Set the touched players time to current time
                    touchedObject.postionStartTime = [gameTimer timeToInt];
                }
                
            }else{
                //Move From Field
                
                //Check if the slot moved to was a bench slot
                if([self checkMoveToBenchSlot:targetSlot]){
                    //To Bench
                    //NSLog(@"From Field To bench");
                    //NSLog(@"Subbing out");
                    [[iToast makeText:NSLocalizedString(@"Moving Player ", [touchedSlot.nameLabel string])] show];
                    //Save the player touched player subing out
                    [self saveGameSub:touchedObject  position:[touchedSlot.nameLabel string]];
                    touchedObject.postionStartTime = [gameTimer timeToInt];
                    
                }else{
                    //To Field
                    //NSLog(@"From Field To Field");
                    //NSLog(@"switching");
                    [[iToast makeText:NSLocalizedString(@"Moving Player ", [touchedSlot.nameLabel string])] show];
                    //The target and touched players are swapping. Save both of them and set their time
                    [self saveGameSub:touchedObject  position:[touchedSlot.nameLabel string]];
                    touchedObject.postionStartTime = [gameTimer timeToInt];
                }
                
            }
            
        }
        
    }
    
    else if (targetGoalEvent == homeGoalEvent){
        [[iToast makeText:NSLocalizedString(@"Score Saved!", @"")] show];
        [self saveGameScore];
        [touchedSoccerBall runAction:[CCMoveTo actionWithDuration:1 position:soccerBallHomeSlot.position]];
        [soccerBall reset];
    }

    
    else if ((touchedObject != NULL) && (targetObject == NULL))
    {
        //Action was incomplete, Move the player back to its origional position
        [touchedObject runAction: [CCMoveTo actionWithDuration:1 position:touchedObject.previousPosition]];
    }
    //If the Goal was selected. 
    else if ((touchedSoccerBall) && (targetObject == NULL) && targetGoalEvent != NULL){
        
        if(touchedSoccerBall.scoringPlayer != NULL){
            //NSLog(@"Save Score");
            [[iToast makeText:NSLocalizedString(@"Score Saved!", @"")] show];
            [self saveGameScore];
            [touchedSoccerBall runAction:[CCMoveTo actionWithDuration:1 position:soccerBallHomeSlot.position]];
            [soccerBall reset];
        }else{
            [touchedSoccerBall runAction: [CCMoveTo actionWithDuration:1 position:touchedSoccerBall.previousPosition]];
        }

    }        
    else if ((touchedSoccerBall) && (targetObject == NULL)){
        //return soccer ball to its position previous position
        //NSLog(@"Soccer ball to last place");
        [touchedSoccerBall runAction: [CCMoveTo actionWithDuration:1 position:touchedSoccerBall.previousPosition]];
    }
    
    targetObject.playerSelected.visible = FALSE;
    touchedObject.playerSelected.visible = FALSE;
    touchedObject = NULL;
    targetObject = NULL;
    touchedSoccerBall = NULL;
    awayGoalEvent.visible = FALSE;
    homeGoalEvent.visible = FALSE;
    
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
            if (playerNode != touchedObject){
                
                //Check if the touched player collides with another player
                if([touchedObject collidesWith:playerNode]){
                    return FALSE;
                }
            }
            
        }
    }
    
    //No Players were found overlapping, Check is complete.
    return TRUE;
}

//Check if two player sprites are overlapping with the touched player (may want to make this generic and just check if two players are overlapping)
- (PlayerSprite*)findPlayerSpriteCollision{
    
    CCArray *arr = [self children];
    for(CCNode *mynode in arr)
    {
        //Find all the Player sprite Childeren
        if([mynode isKindOfClass:[PlayerSprite class]]){
            
            PlayerSprite *playerNode = [arr objectAtIndex:[arr indexOfObject:mynode]];
            //Check if player is the same node as the one being touched
            if (playerNode != touchedObject){
                
                //Check if the touched player collides with another player
                if([touchedObject collidesWith:playerNode]){
                    return playerNode;
                }
            }
            
        }
    }
    
    //No Players were found overlapping, Check is complete.
    return NULL;
}

- (PlayerSprite*)findSoccerBallSpriteCollision{
    
    CCArray *arr = [self children];
    for(CCNode *mynode in arr)
    {
        //Find all the Player sprite Childeren
        if([mynode isKindOfClass:[PlayerSprite class]]){
            
            PlayerSprite *playerNode = [arr objectAtIndex:[arr indexOfObject:mynode]];
            //Check if player is the same node as the one being touched

                //Check if the touched player collides with another player
                if([touchedSoccerBall collidesWith:playerNode]){
                    return playerNode;
            }
            
        }
    }
    
    //No Players were found overlapping, Check is complete.
    return NULL;
}

//Check if the slot is a slot on the bench array
- (BOOL)checkMoveToBenchSlot:(SlotSprite *)slot{
    //Check each bench slot 
    for(SlotSprite *benchSlot in benchSlotsArray){
        if(slot == benchSlot){
            return TRUE;
        }
    }
    return FALSE;
}

//Check if the Player is being move From a benchSlot
- (BOOL)checkMoveFromBenchSlot:(PlayerSprite*)player{
    
    // Create two rectangles with CGRectMake, using each sprite's x/y position and width/height
	CGRect playerRect = CGRectMake(player.previousPosition.x - (player.contentSize.width / 2), player.previousPosition.y - (player.contentSize.height / 2), player.contentSize.width, player.contentSize.height);
    
    //Check each bench slot 
    for(SlotSprite *benchSlot in benchSlotsArray){
        //Find rect of the bench slot
        CGRect slotRect = CGRectMake(benchSlot.position.x - (benchSlot.contentSize.width / 2), benchSlot.position.y - (benchSlot.contentSize.height / 2), benchSlot.contentSize.width, benchSlot.contentSize.height);
    
        // Feed the results into CGRectIntersectsRect() which tells if the rectangles intersect (obviously)
        if(CGRectIntersectsRect(playerRect, slotRect)){
            //They did collide, so the player did come from the bench
            return TRUE;
        }
    }
    
    //They did not collide, the player did not come from the bench
    return FALSE;
}

//Finds the returns the slot the player is currently on
- (CCSprite *)findSlot:(PlayerSprite *)player{
    
    CCArray *arr = [self children];
    for(CCNode *mynode in arr)
    {
        //Find all the Player sprite Childeren
        if([mynode isKindOfClass:[SlotSprite class]]){
            
            SlotSprite *slotNode = [arr objectAtIndex:[arr indexOfObject:mynode]];
            //Check if player is the same node as the one being touched
            if ([player collidesWith:slotNode]){
                
                return slotNode;
            }
            
        }
    }
    
    //No Players were found overlapping, Check is complete.
    //ERROR: - Throw Exception
    return NULL;
    
}

//Save GameSub to DB
- (void)saveGameSub:(PlayerSprite *)aPlayer position:(NSString *)positionName{
    //Get shared app controller instance
    RootViewController *sharedAppController = [RootViewController sharedAppController];
    NSManagedObjectContext *managedObjectContext = [sharedAppController managedObjectContext];
    
    if(aPlayer.postionStartTime <[[sharedAppController gameTimer] timeToInt]){
        //Create new GameSub
        GameSub *sub = [NSEntityDescription insertNewObjectForEntityForName:@"GameSub" inManagedObjectContext:managedObjectContext];
        sub.game = game;
        sub.player = aPlayer.player;
        sub.positionName = positionName;
        sub.endTime = [NSNumber numberWithInt:[[sharedAppController gameTimer] timeToInt]];
        sub.startTime = [NSNumber numberWithInt:aPlayer.postionStartTime];
        
        //Save to DB
        NSError *error = nil;
        if (![managedObjectContext save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }	
    }else{
        //Do not Save
    }
    
}

- (void)saveGameScore{
    
    RootViewController *sharedAppController = [RootViewController sharedAppController];
    NSManagedObjectContext *managedObjectContext = [sharedAppController managedObjectContext];

    
    if (targetGoalEvent == homeGoalEvent){
        game.opponentScore = [NSNumber numberWithInt:[game.opponentScore intValue] + 1];
        [[sharedAppController gameTimer] addOpponentScore];
        
        //Save to DB
        NSError *error = nil;
        if (![managedObjectContext save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
		
    }else{
        //Create new GameScore
        GameScore *score = [NSEntityDescription insertNewObjectForEntityForName:@"GameScore" inManagedObjectContext:managedObjectContext];
        
        score.game = game;
        score.player = soccerBall.scoringPlayer;
        score.scoringPosition = soccerBall.scoringPlayerPosition;
        NSLog(@"saving:%@",touchedSoccerBall.scoringPlayerPosition);
        if(soccerBall.assistingPlayer != NULL){
            score.assistingPlayer = soccerBall.assistingPlayer;
        }
        score.time = [NSNumber numberWithInt:[[sharedAppController gameTimer] timeToInt]];
        
        //sub.endTime = [NSNumber numberWithInt:[[sharedAppController gameTimer] timeToInt]];
        //sub.startTime = [NSNumber numberWithInt:aPlayer.postionStartTime];
        game.homeScore = [NSNumber numberWithInt:[game.homeScore intValue] + 1];
        [[sharedAppController gameTimer] addHomeScore];
        
        //Save to DB
        NSError *error = nil;
        if (![managedObjectContext save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }		
    }

}

//Turn on the bench
- (void)benchOffSet:(NSInteger )offSet{
    CCArray *arr = [self children];
    for(PlayerSprite *mynode in arr)
    {
        [mynode runAction: [CCMoveTo actionWithDuration:1 position:CGPointMake((mynode.position.x + offSet), (mynode.position.y))]];

        //NSLog(@"name %@", mynode.playerName);
       
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
    
    [myArray release];
}


- (void)testfunction{
    NSLog(@"TEST FUNCTION EXCUTED");
    
}

//Save all players last positions to Database and mark the game closed 
- (void)saveEndGameData{
    
    CCArray *arr = [self children];
            
    for(SlotSprite *formationSlot in formationSlotsArray){
        for(CCNode *mynode in arr)
        {
            //Find all the Player sprite Childeren
            if([mynode isKindOfClass:[PlayerSprite class]]){
                                
                PlayerSprite *playerNode = [arr objectAtIndex:[arr indexOfObject:mynode]];
                //Check if player is the same node as the one being touched
                if ([formationSlot collidesWith:playerNode]){
                    
                    //SAVE
                    [self saveGameSub:playerNode position:[formationSlot.nameLabel string]];
                    
                }

            }
        }
    }
    
    // Mark Game Complete and final Score complete
    RootViewController *sharedAppController = [RootViewController sharedAppController];
    NSManagedObjectContext *managedObjectContext = [sharedAppController managedObjectContext];
    
    //Mark Complete
    game.played = [NSNumber numberWithBool:TRUE];
    
    //Save Score
    
    //Save to DB
    NSError *error = nil;
	if (![managedObjectContext save:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}		
    
}


- (void) dealloc {

    //NSLog(@"Entering %s", __PRETTY_FUNCTION__);
    
    [benchSlotsArray release];
    [benchPositions release];
    [formationSlotsArray release];
	[playersArray release];
    [storedPositionsDict release];
    [storedPositionsListArray release];
    
	[super dealloc];
    //NSLog(@"Exiting %s", __PRETTY_FUNCTION__);
}

@end
