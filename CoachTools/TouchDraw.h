//
//  TouchDraw.h
//  CoachTools
//
//  Created by Chris Desch on 12/9/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import "cocos2d.h"

@interface TouchDraw : CCNode {
@private
    NSMutableArray *drawPoints;
}

@property (nonatomic, assign) NSMutableArray *drawPoints;

@end