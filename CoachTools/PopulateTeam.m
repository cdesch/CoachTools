//
//  PopulateTeam.m
//  CoachTools
//
//  Created by Chris Desch on 10/22/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import "PopulateTeam.h"
#import "RootViewController.h"
#import "FlurryAnalytics.h"
#import "Team.h"
#import "Season.h"
#import "Game.h"
#import "Training.h"
#import "Person.h"
@implementation PopulateTeam

- (void)populate{
    //
    //Create Team
    
    NSArray* locationsList = [[NSArray alloc] initWithObjects:@"Hackensack, NJ", @"Lodi, NJ",@"Saddlebrook, NJ",@"Verona, NJ",@"Hoboken,NJ",@"Cedar Grove, NJ",@"East Rutheford NJ",@"Adams, NY",@"Flushing, NY", @"Far Rockaway, NY", @"Miller Place, NY", @"Harlem, NY", @"White Plains, NY", @"New Milford, NJ",@"Belmar, NJ", @"Toms River, NJ", @"Jersey City, NJ",@"Paterson, NJ", @"North Bergen, NJ", @"Newark, NJ", @"Camdem, NJ",@"Elizibeth, NJ", @"Iron Bound, NJ", @"Garfield, NJ", @"Lyndhurst, NJ", nil];
    NSArray* opponentsList = [[NSArray alloc] initWithObjects:@"Wolves", @"Titans",@"Bears",@"Knights",@"Mud Hens",@"Hawks",@"Spartans",@"Bobcats",@"Eagles",@"Cougars",@"Bulldogs",@"Lions",@"United Essex",@"Greasers",@"Fighting Irish",@"Jager Bombs",@"Red Bears",@"Bombers",@"Saturday Night Fever",@"Schiltz Scoundrels",@"Bullfrogs",@"Pinkertons",@"Shooting Stars",@"The Monstars",@"Fire Strikers",@"Maroon Madness",@"Sharks",@"Shamrocks",@"Midnight Rage",@"Midnight Rally",@"King and Blood",@"Three Man",@"Strange Brew",@"Sixes",@"Shotgun",@"Pocket Aces",@"Beer League",@"Ed's Bar and Grill", nil];
    
    RootViewController *sharedController = [RootViewController sharedAppController];
    NSManagedObjectContext *managedObjectContext = [sharedController managedObjectContext];
    
    NSError *error = nil;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription 
                                   entityForName:@"Team" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release];
    
    int numberOfTeams = [fetchedObjects count];
    
    Team* team =  [NSEntityDescription insertNewObjectForEntityForName:@"Team" inManagedObjectContext:managedObjectContext];

    NSString* teamName = @"Team ";
    team.name = [teamName stringByAppendingString:[NSString stringWithFormat:@"%d", numberOfTeams + 1]];
    //Add 14 players
    for (int i = 1; i < 15; i++){
    
        Person* player =  [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:managedObjectContext];
        player.playerNumber = [NSString stringWithFormat:@"%d", i];
        player.firstName = [NSString stringWithFormat:@"%d", i];
        player.lastName = @"Player";
        player.team = team;
        error = nil;
     
        if (![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            [FlurryAnalytics logError:[NSString stringWithFormat:@"Unresolved Error CoreData %s", __PRETTY_FUNCTION__] message:@"CoreData" error:error];
            abort();
        }		
        
    }
    
    //Create Seasons
    Season* season1 =  [NSEntityDescription insertNewObjectForEntityForName:@"Season" inManagedObjectContext:managedObjectContext];
    Season* season2 =  [NSEntityDescription insertNewObjectForEntityForName:@"Season" inManagedObjectContext:managedObjectContext];
    
    season1.name = @"Season 1";
    season1.team = team;
    season2.name = @"Season 2";
    season2.team = team;
    
    error = nil;
    if (![managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        [FlurryAnalytics logError:[NSString stringWithFormat:@"Unresolved Error CoreData %s", __PRETTY_FUNCTION__] message:@"CoreData" error:error];
        abort();
    }		
    
    //Add 10 Games
    //Add 10 Training Sessions
    //Create Season 2
    //Add 10 Games
    //Add 10 Training Sessions
    for (int i = 1; i < 11; i++){
        NSTimeInterval secondsPerDay = (24 * 60 * 60) *(i*3);
        NSDate *tomorrow = [[NSDate alloc]
                            initWithTimeIntervalSinceNow:secondsPerDay];
        
        Game* game1 =  [NSEntityDescription insertNewObjectForEntityForName:@"Game" inManagedObjectContext:managedObjectContext];
        game1.gameNumber = [NSString stringWithFormat:@"%d", i]; 
        game1.opponent = [opponentsList objectAtIndex:[[NSNumber numberWithInt:(arc4random() % ([opponentsList count]-1))] intValue]];
        game1.location = [locationsList objectAtIndex:[[NSNumber numberWithInt:(arc4random() % ([locationsList count]-1))] intValue]];
        game1.season = season1;
        game1.date = tomorrow;
        
        Game* game2 =  [NSEntityDescription insertNewObjectForEntityForName:@"Game" inManagedObjectContext:managedObjectContext];
        game2.gameNumber = [NSString stringWithFormat:@"%d", i];
        game2.opponent = [opponentsList objectAtIndex:[[NSNumber numberWithInt:(arc4random() % ([opponentsList count]-1))] intValue]];
        game2.location = [locationsList objectAtIndex:[[NSNumber numberWithInt:(arc4random() % ([locationsList count]-1))] intValue]];
        game2.season = season2;
        game2.date = tomorrow;

        Training* training1 =  [NSEntityDescription insertNewObjectForEntityForName:@"Training" inManagedObjectContext:managedObjectContext];
        training1.trainingNumber = [NSNumber numberWithInteger:i];
        training1.season = season1;
        training1.date = tomorrow;
        
        Training* training2 =  [NSEntityDescription insertNewObjectForEntityForName:@"Training" inManagedObjectContext:managedObjectContext];
        training2.trainingNumber = [NSNumber numberWithInteger:i];
        training2.season = season2;
        training2.date = tomorrow;
        
        error = nil;
        if (![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            [FlurryAnalytics logError:[NSString stringWithFormat:@"Unresolved Error CoreData %s", __PRETTY_FUNCTION__] message:@"CoreData" error:error];
            abort();
        }		
        
        [tomorrow release];
    }
    
    error = nil;
    if (![managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        [FlurryAnalytics logError:[NSString stringWithFormat:@"Unresolved Error CoreData %s", __PRETTY_FUNCTION__] message:@"CoreData" error:error];
        abort();
    }		
    
    
}

/*
- (Team*)createTeam{
    
    RootViewController *sharedController = [RootViewController sharedAppController];
    NSManagedObjectContext *managedObjectContext = [sharedController managedObjectContext];
    return [NSEntityDescription insertNewObjectForEntityForName:@"Team" inManagedObjectContext:managedObjectContext];
    
}*/



@end
