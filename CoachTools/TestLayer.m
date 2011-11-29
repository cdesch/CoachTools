//
//  Layer.m
//  TestApp
//
//  Created by cj on 4/8/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import "TestLayer.h"

CCSprite *grossini;


@implementation TestLayer

-(id) init
{
	if( (self=[super init] ) )
	{
		self.isTouchEnabled = YES;
		
		CGSize s = [[CCDirector sharedDirector] winSize];
        
		grossini = [CCSprite spriteWithFile:@"player2small.png"];
		CCLabelTTF *label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%dx%d",(int)s.width, (int)s.height] fontName:@"Helvetica" fontSize:28];
        
        CCLabelTTF *labelnew = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"TEST"] fontName:@"Helvetica" fontSize:28]; 
		
		[self addChild:label];
        [self addChild:labelnew];
		[self addChild:grossini z:0];
		labelnew.position =  ccp( s.width/2, s.height/2);
        [labelnew setColor:ccc3(255, 0, 0)];
		grossini.position = ccp( s.width/2, s.height/2);
		label.position = ccp( s.width/2, s.height-40);
		
		id sc = [CCScaleBy actionWithDuration:2 scale:1.5f];
		id sc_back = [sc reverse];
		[grossini runAction: [CCRepeatForever actionWithAction:
                              [CCSequence actions: sc, sc_back, nil]]];
	}
	return self;
}

- (void) dealloc
{
	[super dealloc];
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touching!...");
	UITouch *touch = [touches anyObject];
	
	CGPoint location = [touch locationInView: [touch view]];
	CGPoint convertedLocation = [[CCDirector sharedDirector] convertToGL:location];
	
	//CCNode *s = [self grossini];
	[grossini stopAllActions];
	[grossini runAction: [CCMoveTo actionWithDuration:1 position:ccp(convertedLocation.x, convertedLocation.y)]];
	float o = convertedLocation.x - [grossini position].x;
	float a = convertedLocation.y - [grossini position].y;
	float at = (float) CC_RADIANS_TO_DEGREES( atanf( o/a) );
	
	if( a < 0 ) {
		if(  o < 0 )
			at = 180 + abs(at);
		else
			at = 180 - abs(at);	
	}
	
	[grossini runAction: [CCRotateTo actionWithDuration:1 angle: at]];	
}
 
@end

