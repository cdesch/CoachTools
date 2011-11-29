//
//  BackgroundLayer.m
//  CoachTools
//
//  Created by cj on 5/18/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import "BackgroundLayer.h"



@implementation BackgroundLayer

@synthesize label;
@synthesize background;
@synthesize meta;

- (id) init {
	if((self = [super init]))
	{
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        self.background = [CCSprite spriteWithFile:@"soccerField3.png"];
        [self.background setPosition:ccp(size.width/2 , size.height/2 )];

        //self.label = [CCLabelTTF labelWithString:@"Background Layer" fontName:@"Helvetica" fontSize:40];
		//self.label.position =  ccp( size.width/10 , 675 ); //size.height/2 // 750
		
        // add the label as a child to this Layer
		//[self addChild: label];
		
        [self addChild:background z:-1];
	}
	return self;
}

- (void) dealloc {
	
	[super dealloc];
}

@end
