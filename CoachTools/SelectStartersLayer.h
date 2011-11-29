//
//  SelectStartersLayer.h
//  CoachTools
//
//  Created by cj on 7/6/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import "cocos2d.h"
#import "PlayerSprite.h"
#import "SlotSprite.h"
#import "Game.h"


@interface SelectStartersLayer : CCLayer {
        
    CCLabelTTF          *formationLabel;
    NSMutableArray      *playersArray;
    NSMutableArray      *slotPositionsArray;
    NSMutableArray      *formationPositionsArray;
    
    NSMutableArray      *storedPositionsListArray;
    NSMutableDictionary *storedPositionsDict;
    
    SlotSprite          *targetSlot;
    PlayerSprite        *touchedPlayer;
    
    NSMutableArray      *finalFormationSelection;
    
    Game                *game;
}


@property (nonatomic, retain) CCLabelTTF            *formationLabel;
@property (nonatomic, retain) NSMutableArray        *playersArray;
@property (nonatomic, retain) NSMutableArray        *slotPositionsArray;
@property (nonatomic, retain) NSMutableArray        *formationPositionsArray;

@property (nonatomic, retain) NSMutableArray        *storedPositionsListArray;
@property (nonatomic, retain) NSMutableDictionary   *storedPositionsDict;

@property (nonatomic, retain) SlotSprite *targetSlot;
@property (nonatomic, retain) PlayerSprite          *touchedPlayer;

@property (nonatomic, retain) NSMutableArray        *finalFormationSelection;
@property (nonatomic, retain) Game                  *game;

+ (id) sharedScene;

- (CGPoint)setupPlayers:(NSInteger)playerIndex;
- (void)loadFormations;
- (BOOL)checkPlayerOverlap;

- (void)saveStarters;

- (int)findStartingPlayers;
- (BOOL)starterSelectionComplete;


@end


