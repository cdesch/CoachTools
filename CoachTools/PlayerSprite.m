//
//  DragSprite.m
//  DevCoachTools
//
//  Created by cj on 3/7/11.
//  Copyright Desch Enterprises 2011. All rights reserved.
//

#import "PlayerSprite.h"
#import "GameScene.h"

@implementation PlayerSprite

@synthesize playerName;
@synthesize playerNumber;
@synthesize isDrag;
@synthesize playerSelected;
@synthesize previousPosition;

@synthesize postionStartTime;
@synthesize positionName;

@synthesize nameLabel;
@synthesize numberLabel;

@synthesize player;

-(id) init{

	if((self=[super init])){
		
		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];
        isDrag = FALSE;
        // Custom Initilize Sprite Code Here
        
        
        playerSelected = [CCSprite spriteWithFile:@"playerSelected2.png"];
        //FIXME: - Needs to be the center of the sprite being passed to dragsprite.
        [playerSelected setPosition:ccp(38, 38)];
        playerSelected.visible = false;
        [self addChild:playerSelected];
        
        //
        postionStartTime = 0;
        
        playerName = @"No Name";
        playerNumber = @"";
        
        nameLabel = [CCLabelTTF labelWithString:playerName fontName:@"Helvetica" fontSize:24];
        nameLabel.position =  ccp(((self.position.x + 42)) , ((self.position.y - 15))); 
        [self addChild:nameLabel];
        
        numberLabel = [CCLabelTTF labelWithString:playerNumber fontName:@"Helvetica" fontSize:22];
        numberLabel.position =  ccp( ((self.position.x + 42)) , ((self.position.y + 40))); 
        [self addChild: numberLabel]; // add the label as a child to this Layer

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
    //Is the sprite being touched and the soccerball not being touched
    if([GameScene sharedScene] != nil){
        //FIXME: BUG After running two in a row
        //Check only if GameScene is running. Dont check in other scenes. 
        if([self isTouchOnSprite:touchPoint] && (![[[GameScene sharedScene] playerLayer ] soccerBall ].isDrag)){
            whereTouch=ccpSub(self.position, touchPoint);
            isDrag = TRUE;
            //NSLog(@"Drag on");
            return YES;
        }
    }else{
        if([self isTouchOnSprite:touchPoint])
        {
            whereTouch=ccpSub(self.position, touchPoint);
            isDrag = TRUE;
            //NSLog(@"Drag on");
            return YES;
        }
    }
	
	return NO;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    //Check if soccerBall has been moved first
    if(![[[GameScene sharedScene] playerLayer ] soccerBall ].isDrag)
    {
        CGPoint touchPoint = [touch locationInView:[touch view]];
        touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
        
        self.position=ccpAdd(touchPoint,whereTouch);
        //NSLog(@"x: %02f y: %02f", self.position.x, self.position.y);
    }
    
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    
	//NSLog(@"Sprite Touch Ended");
    isDrag = FALSE;
    
    //NSLog(@"Drag off");
}

// Super-basic AABB collision detection
- (bool)collidesWith:(CCNode *)obj
{
	// Create two rectangles with CGRectMake, using each sprite's x/y position and width/height
	CGRect ownRect = CGRectMake(self.position.x - (self.contentSize.width / 2), self.position.y - (self.contentSize.height / 2), self.contentSize.width, self.contentSize.height);
	CGRect otherRect = CGRectMake(obj.position.x - (obj.contentSize.width / 2), obj.position.y - (obj.contentSize.height / 2), obj.contentSize.width, obj.contentSize.height);
    
	// Feed the results into CGRectIntersectsRect() which tells if the rectangles intersect (obviously)
	return CGRectIntersectsRect(ownRect, otherRect);
}

@end
