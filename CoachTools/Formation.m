//
//  Formation.m
//  CoachTools
//
//  Created by cj on 6/7/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import "Formation.h"
#import "FormationPosition.h"

@implementation Formation

@synthesize formationName;
@synthesize formationPositionsDictionary;


- (id)initWithDictionary:(NSDictionary *)aDictionary {
	if ([self init]) {
		//self.formationName = [aDictionary valueForKey:@"formationName"];
        //self.formationPositionsDictionary = [NSMutableArray arrayWithArray:[aDictionary objectForKey:@"formationPositionsArray"]];
	}
    
	return self;
}

- (id) init {
	if((self = [super init]))
	{
        //Nothing
        //self.formationName = [aDictionary valueForKey:@"formationName"];
        [self setupFormationArray];
	}
	return self;
}

- (void)setupFormationArray {

    NSDictionary *eachPosition;
    // create dictionaries that contain the arrays of element data indexed by
	// name
	self.formationPositionsDictionary = [NSMutableDictionary dictionary];
   
    // read the element data from the plist
	NSString *thePath = [[NSBundle mainBundle]  pathForResource:@"Formations" ofType:@"plist"];
	NSArray *rawPositionArray = [[NSArray alloc] initWithContentsOfFile:thePath];

    // iterate over the values in the raw elements dictionary
	for (eachPosition in rawPositionArray)
	{
		// create an atomic element instance for each
		FormationPosition *aPosition = [[FormationPosition alloc] initWithDictionary:eachPosition];
		NSLog(@"Position %@", aPosition.positionName);
        
            // store that item in the elements dictionary with the name as the key
		[formationPositionsDictionary setObject:aPosition forKey:aPosition.positionName];
		
        [aPosition release];
		
	}
	// release the raw element data
	[rawPositionArray release];
}


- (void)dealloc {
    [formationName release];
    [formationPositionsDictionary release];
	[super dealloc];
}


@end
