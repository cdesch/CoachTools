//
//  CompileStats.m
//  CoachTools
//
//  Created by Chris Desch on 8/25/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import "CompileStats.h"
#import "Team.h"
#import "Season.h"
#import "Game.h"
#import "Person.h"
#import "GameScore.h"
#import "GameSub.h"
#import "GameStart.h"

@implementation CompileStats

@synthesize team;

- (id)initWithTeam:(Team *)aTeam
{
    self = [super init];
    if (self) {
        
        // Initialization code here.
        team = aTeam;
        
        [self compileTeamStats];
        [self compilePlayerStats];
    }
    
    return self;
}

- (void)compileTeamStats{
    
    //compile the team stats
    int wins = 0;
    int losses = 0;
    //int draw = 0;
    
    //Add up the number of wins and number of losses for the team
    NSArray *seasonsArray = [team.seasons allObjects];
    
    //Cycle through each season in team
    for (Season* season in seasonsArray){
        
        [self compileSeasonStats:season];
        
        wins += [season.cWins intValue];
        losses += [season.cLosses intValue];

    }
    
    NSLog(@"team: %@ Wins %d, losses %d", team.name, wins, losses);
    team.cWins =  [NSNumber numberWithInt:wins];
    team.cLosses = [NSNumber numberWithInt:losses];
    
    
    NSManagedObjectContext *managedObjectContext = team.managedObjectContext;
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    
}

- (void)compileSeasonStats:(Season*)season{
    
    int seasonWins = 0;
    int seasonLosses = 0;
    int seasonDraw = 0;
    //Cycle through each game in season
    NSArray *gamesArray = [season.games allObjects];
    for (Game* game in gamesArray){
        
        [self compileGameStats:game];
        
        //Check Scores
        if ([game.homeScore intValue] > [game.opponentScore intValue]){
            //Win
            seasonWins ++;
        }else if ([game.homeScore intValue] < [game.opponentScore intValue]){
            //Losses
            seasonLosses ++;
        }else {
            //Draw
            seasonDraw ++;
        }
        
    }
    
    season.cWins = [NSNumber numberWithInt:seasonWins];
    season.cLosses = [NSNumber numberWithInt:seasonLosses];

    
}

- (void)compileGameStats:(Game*)game{
   
    game.homeScore = [NSNumber numberWithInt:[self compileGameScores:game]];
    
}

- (int)compileGameScores:(Game*)game{
    
    return [game.gameScoreSet count];
    
}

- (void)compilePlayerStats{
    
    NSArray* playersArray = [team.players allObjects];
    for (Person *player in playersArray){
        NSLog(@"Player:%@ Goals: %@ Starts: %@ Time: %@", player.lastName, player.cGoals, player.cStarts, player.cPlayingTime);
        player.cGoals = [NSNumber numberWithInt:[self compilePlayerScores:player]];
        player.cPlayingTime = [NSNumber numberWithDouble:[self compilePlayerTime:player]];
        player.cStarts = [NSNumber numberWithInt:[self compilePlayerStarts:player]];
        NSLog(@"Player:%@ Goals: %@ Starts: %@ Time: %@", player.lastName, player.cGoals, player.cStarts, player.cPlayingTime);
    }
    
    
    NSManagedObjectContext *managedObjectContext = team.managedObjectContext;
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    

}

- (int)compilePlayerScores:(Person*)player{
    return [player.gameScoreSet count];
}

- (double)compilePlayerTime:(Person*)player{
    
    int time =0;
    NSArray *gameSubArray = [player.gameSub allObjects];
    
    for(GameSub* sub in gameSubArray){
        time += ([sub.endTime intValue] - [sub.startTime intValue]);
    }
    
    return time;
}

- (int)compilePlayerStarts:(Person*)player{
    return [player.gameStartSet count];
}


- (void)dealloc
{

    [super dealloc];
}

@end
