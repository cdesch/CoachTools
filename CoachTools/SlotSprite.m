//
//  StarterLocationSprite.m
//  CoachTools
//
//  Created by cj on 7/7/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import "SlotSprite.h"


@implementation SlotSprite

@synthesize nameLabel;
@synthesize nodeSelected;

-(id) init{
    
	if((self=[super init])){
        
        nameLabel = [CCLabelTTF labelWithString:@"" fontName:@"Arial Rounded MT Bold" fontSize:24];
        [nameLabel setColor:ccGOLDENROD];
        nameLabel.position =  ccp(((self.position.x + 40)) , ((self.position.y + 86))); 
        [self addChild:nameLabel];
        
        nodeSelected = [CCSprite spriteWithFile:@"playerSelected2.png"];
        //FIXME: - Needs to be the center of the sprite being passed to dragsprite.
        [nodeSelected setPosition:ccp(38, 38)];
        nodeSelected.visible = false;
        [self addChild:nodeSelected];
    }
    
    return self;
    
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
