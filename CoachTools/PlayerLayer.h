//
//  PlayerLayer.h
//  CoachTools
//
//  Created by cj on 5/19/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Game.h"
#import "PlayerSprite.h"
#import "SlotSprite.h"
#import "SoccerBallSprite.h"

@interface PlayerLayer : CCLayer {

    NSMutableArray          *playersArray;
    SlotSprite              *targetSlot;
    PlayerSprite            *targetObject;
    PlayerSprite            *touchedObject;
    NSMutableArray          *benchPositions;
    NSMutableArray          *benchSlotsArray;
    NSMutableArray          *playerFormations;
    Game                    *game;
    
    NSMutableArray          *storedPositionsListArray;
    NSMutableDictionary     *storedPositionsDict;
    
    NSMutableArray          *formationSlotsArray;
    NSString                *currentFormationName;
    SoccerBallSprite        *soccerBall;
    SoccerBallSprite        *touchedSoccerBall;
    CCSprite                *homeGoalEvent;
    CCSprite                *awayGoalEvent;
    CCSprite                *targetGoalEvent;
    SlotSprite              *soccerBallHomeSlot;

}

@property (nonatomic, retain) NSMutableArray        *playersArray;
@property (nonatomic, retain) SlotSprite            *targetSlot;
@property (nonatomic, retain) PlayerSprite          *targetObject;
@property (nonatomic, retain) PlayerSprite          *touchedObject;
@property (nonatomic, retain) NSMutableArray        *benchPositions;
@property (nonatomic, retain) NSMutableArray        *benchSlotsArray;
@property (nonatomic, retain) NSMutableArray        *playerFormations;
@property (nonatomic, retain) Game                  *game;

@property (nonatomic, retain) NSMutableArray        *storedPositionsListArray;
@property (nonatomic, retain) NSMutableDictionary   *storedPositionsDict;

@property (nonatomic, retain) NSMutableArray        *formationSlotsArray;
@property (nonatomic, retain) NSString              *currentFormationName;
@property (nonatomic, retain) SoccerBallSprite      *soccerBall;
@property (nonatomic, retain) SoccerBallSprite      *touchedSoccerBall;
@property (nonatomic, retain) CCSprite              *homeGoalEvent;
@property (nonatomic, retain) CCSprite              *awayGoalEvent;
@property (nonatomic, retain) CCSprite              *targetGoalEvent;
@property (nonatomic, retain) SlotSprite            *soccerBallHomeSlot;

- (int)starterPlayerIndex:(NSArray *)startingPlayers player:(Person *)player;

- (void)setFormation:(NSString *)formationName;
- (BOOL)checkPlayerOverlap;
- (PlayerSprite *)findPlayerSpriteCollision;
- (PlayerSprite *)findSoccerBallSpriteCollision;

- (BOOL)checkMoveToBenchSlot:(SlotSprite *)slot;
- (BOOL)checkMoveFromBenchSlot:(PlayerSprite*)player;
- (SlotSprite *)findSlot:(PlayerSprite *)player;
- (void)saveGameSub:(PlayerSprite *)player position:(NSString *)position;
- (void)saveGameScore;
- (void)benchOffSet:(NSInteger )offSet;

- (CGPoint)setupPlayers:(NSInteger)playerIndex;

- (void)loadFormations;
- (void)testfunction;
- (void)saveEndGameData;

@end



