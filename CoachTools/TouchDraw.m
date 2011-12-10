//
//  TouchDraw.m
//  CoachTools
//
//  Created by Chris Desch on 12/9/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import "TouchDraw.h"

@implementation TouchDraw

@synthesize drawPoints;

- (id) init
{
    self = [super init];
    glEnable(GL_LINE_SMOOTH);
    glLineWidth(5.0f);
    return self;
}

- (void) draw
{
    if (drawPoints && [drawPoints count] < 2)
    {
        // not enough points to draw a line
        return;
    }
    
    // draw a line from 1 point to the other
    for (unsigned int i = 0; i < [drawPoints count]; i += 2)
    {
        CGPoint first = CGPointFromString([drawPoints objectAtIndex:i]);
        CGPoint second = CGPointFromString([drawPoints objectAtIndex:i + 1]);
        ccDrawLine(first, second);
    }
}

@end