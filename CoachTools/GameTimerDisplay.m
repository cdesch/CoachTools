//
//  GameTimerDisplay.m
//  CoachTools
//
//  Created by cj on 7/14/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import "GameTimerDisplay.h"
#import "MTIBulbView.h"
#import "RootViewController.h"

@implementation GameTimerDisplay

@synthesize bulbView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
         
        // Initialization code
        //NSLog(@"BulbView");
        bulbView = [[MTIBulbView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
        const CGFloat red[] = {1.0, 0.0, 0.0, 1.0};
        const CGFloat clearRed[] = {1.0, 0.0, 0.0, 0.15};
        bulbView.litColor	= CGColorCreate(rgb, red);
        bulbView.dimColor	= CGColorCreate(rgb, clearRed);
        CGColorSpaceRelease(rgb);
        
        bulbView.alpha = 1.0;
        bulbView.clearsContextBeforeDrawing = TRUE;
        [bulbView setBackgroundColor:[UIColor blackColor]];
         
        //RootViewController *ac = [RootViewController sharedAppController];
        //bulbView.text          = [ac.segTimer timeToString];
        
/*
        //timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                 target:self
                                               selector:@selector(tick:)
                                               userInfo:NULL
                                                repeats:YES];
         */
         
        //[self tick:timer];
        
        [self addSubview:bulbView];
        [bulbView release];
        
    }
     
    return self;
}


- (void)setString:(NSString *)aString{
    //bulbView.text = aString;
     [bulbView setText:aString];
}

//Update the timer
- (void)tick:(NSTimer*)t
{
 
     //Set time with current game time from the GameTimer
    RootViewController *ac = [RootViewController sharedAppController];
	[bulbView setText:[ac.gameTimer timeToString]];

}

//- (void)flashScreen:(UIColor *)color{
     
//}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [bulbView release];
    [timer invalidate];
    [super dealloc];
}

@end
