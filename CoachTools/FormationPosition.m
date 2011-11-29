//
//  FormationPosition.m
//  CoachTools
//
//  Created by cj on 6/7/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import "FormationPosition.h"


@implementation FormationPosition

@synthesize positionName;
@synthesize x;
@synthesize y;


- (id)initWithDictionary:(NSDictionary *)aDictionary {
	if ([self init]) {
        
        self.positionName = [aDictionary valueForKey:@"positionName"];
        self.x = [aDictionary valueForKey:@"x"];
        self.y = [aDictionary valueForKey:@"y"];
    }
    return self;
}

- (void)dealloc {
    
    [positionName release];
    [x release];
    [y release];
	[super dealloc];
}


// this returns the position for the player
-(CGPoint)positionForPlayer {
	return CGPointMake([[self x] intValue], [[self y] intValue]);
}


@end
