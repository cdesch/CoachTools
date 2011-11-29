//
//  SoccerBallSprite.m
//  CoachTools
//
//  Created by cj on 7/25/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import "SoccerBallSprite.h"


@implementation SoccerBallSprite


@synthesize isDrag;

@synthesize previousPosition;
@synthesize postionStartTime;

@synthesize scoringPlayerNameLabel;
@synthesize assistingPlayerNameLabel;

@synthesize scoringPlayer;
@synthesize assistingPlayer;

@synthesize scoringPlayerPosition;
@synthesize assistingPlayerPosition;

-(id) init{
    
	if((self=[super init])){
		
		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:1 swallowsTouches:NO];
        isDrag = FALSE;
        // Custom Initilize Sprite Code Here
        
 
        //
        postionStartTime = 0;
        
        scoringPlayer = NULL;
        assistingPlayer = NULL;
        
        scoringPlayerNameLabel = [CCLabelTTF labelWithString:@"" fontName:@"Helvetica" fontSize:24];
        [scoringPlayerNameLabel setColor:ccRED];
        [scoringPlayerNameLabel setAnchorPoint: ccp(0, 0.5f)];
        scoringPlayerNameLabel.position =  ccp(((self.position.x + 75)) , ((self.position.y +40))); 
        [self addChild:scoringPlayerNameLabel];
        
        assistingPlayerNameLabel = [CCLabelTTF labelWithString:@"" fontName:@"Helvetica" fontSize:22];
        [assistingPlayerNameLabel setColor:ccRED];
        [assistingPlayerNameLabel setAnchorPoint: ccp(0, 0.5f)];
        assistingPlayerNameLabel.position =  ccp( ((self.position.x + 75)) , ((self.position.y +20))); 
        [self addChild: assistingPlayerNameLabel]; // add the label as a child to this Layer
        
	}
	return self;
}


//  ----  Touches on Sprite Actions ----- // 

//Determine if Touch is on the sprite
-(BOOL) isTouchOnSprite:(CGPoint)touch{
	if(CGRectContainsPoint(CGRectMake(self.position.x - ((self.contentSize.width/2)*self.scale), self.position.y - ((self.contentSize.height/2)*self.scale), self.contentSize.width*self.scale, self.contentSize.height*self.scale), touch)){
        return YES;
    }
    
	else return NO;
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	CGPoint touchPoint = [touch locationInView:[touch view]];
	touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
	previousPosition = self.position;
	//NSLog(@"touch began");
	if([self isTouchOnSprite:touchPoint]){
		whereTouch=ccpSub(self.position, touchPoint);
        isDrag = TRUE;
        //NSLog(@"Drag on");
		return YES;
	}
	
	return NO;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
	CGPoint touchPoint = [touch locationInView:[touch view]];
	touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
	
	self.position=ccpAdd(touchPoint,whereTouch);
    //NSLog(@"x: %02f y: %02f", self.position.x, self.position.y);
	
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    
	//NSLog(@"Sprite Touch Ended");
    isDrag = FALSE;
    
    //NSLog(@"Drag off");
}

// Super-basic AABB collision detection
- (BOOL)collidesWith:(CCNode *)obj
{
	// Create two rectangles with CGRectMake, using each sprite's x/y position and width/height
	CGRect ownRect = CGRectMake(self.position.x - (self.contentSize.width / 2), self.position.y - (self.contentSize.height / 2), self.contentSize.width, self.contentSize.height);
	CGRect otherRect = CGRectMake(obj.position.x - (obj.contentSize.width / 2), obj.position.y - (obj.contentSize.height / 2), obj.contentSize.width, obj.contentSize.height);
    
	// Feed the results into CGRectIntersectsRect() which tells if the rectangles intersect (obviously)
	return CGRectIntersectsRect(ownRect, otherRect);
}

- (void)reset{
    scoringPlayer = NULL;
    assistingPlayer = NULL;
    [scoringPlayerNameLabel setString:@""];
    [assistingPlayerNameLabel setString:@""];
    scoringPlayerPosition = @"";
    assistingPlayerPosition = @"";
    
}

@end
