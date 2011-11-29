//
//  LeagueFormations.h
//  CoachTools
//
//  Created by cj on 6/7/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LeagueFormations : NSObject {
    NSString *leagueName;
    int numPlayers;             // Num Players on field at one time // Varies between Youth and Adult Leagues 8 vs 11 players
    NSMutableDictionary *formationDictionary;
}

@property (nonatomic, retain) NSString *leagueName;
@property (nonatomic, readwrite) int numPlayers;
@property (nonatomic, retain) NSMutableDictionary *formationDictionary;

+ (LeagueFormations*) sharedLeagueFormations;
- (void)setupElementsDictionary ;



@end
