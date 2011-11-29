//
//  CompileStats.h
//  CoachTools
//
//  Created by Chris Desch on 8/25/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Team.h"
#import "Season.h"
#import "Game.h"
#import "Person.h"
#import "GameScore.h"

@interface CompileStats : NSObject{
    
    Team *team;
    
}

@property (nonatomic, retain) Team *team;

- (id)initWithTeam:(Team *)aTeam;
- (void)compileTeamStats;
- (void)compileSeasonStats:(Season*)season;

- (void)compileGameStats:(Game*)game;
- (int)compileGameScores:(Game*)game;

- (void)compilePlayerStats;
- (int)compilePlayerScores:(Person*)player;
- (double)compilePlayerTime:(Person*)player;
- (int)compilePlayerStarts:(Person*)player;

@end
