//
//  LeagueFormations.m
//  CoachTools
//
//  Created by cj on 6/7/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import "LeagueFormations.h"
#import "Formation.h"

@implementation LeagueFormations


@synthesize leagueName;
@synthesize numPlayers;
@synthesize formationDictionary;

// we use the singleton approach, one collection for the entire application
static LeagueFormations *sharedLeagueFormationsInstance = nil;

+ (LeagueFormations *)sharedLeagueFormations
{
    @synchronized(self) {
        static dispatch_once_t pred;
        dispatch_once(&pred, ^{ sharedLeagueFormationsInstance = [[self alloc] init]; });
    }
    return sharedLeagueFormationsInstance;
}

- (id)retain {
    return self;
}

- (void)release {
    //do nothing
}

- (id)autorelease {
    return self;
}


// setup the data collection
- (id) init {
	if((self = [super init]))
	{
		[self setupElementsDictionary];
	}
	return self;
}

- (void)setupElementsDictionary {
    
   // NSDictionary *eachFormation;
    
    self.formationDictionary = [NSMutableDictionary dictionary];
        
    // read the element data from the plist
	//NSString *thePath = [[NSBundle mainBundle]  pathForResource:@"Formations" ofType:@"plist"];
//	NSArray *rawElementsArray = [[NSArray alloc] initWithContentsOfFile:thePath];

    
}


@end
