//
//  DrawMyTouch.m
//  CoachTools
//
//  Created by Chris Desch on 12/9/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//


#import "DrawMyTouch.h"

@implementation DrawMyTouch 
-(id) init
{
    if( (self=[super init])) 
    { }
    return self;
}

-(void)draw
{
    glEnable(GL_LINE_SMOOTH);
    
    /*
    for(int i = 0; i < [naughtyTouchArray count]; i+=2)
    {
        CGPoint start = CGPointFromString([naughtyTouchArray objectAtIndex:i]);
        CGPoint end = CGPointFromString([naughtyTouchArray objectAtIndex:i+1]);
        
        ccDrawLine(start, end);
    }*/
}


-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{   
    DrawMyTouch *line = [DrawMyTouch node];
    [self addChild: line];
}

@end