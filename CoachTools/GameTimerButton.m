//
//  GameTimerButton.m
//  CoachTools
//
//  Created by cj on 7/15/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import "GameTimerButton.h"
#import "RootViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation GameTimerButton

@synthesize segControl;

@synthesize soundFileURLRef;
@synthesize soundFileObject;

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //Setup Sound
        NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
        
        // Store the URL as a CFURLRef instance
        self.soundFileURLRef = (CFURLRef) [tapSound retain];
        
        // Create a system sound object representing the sound file.
        AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
        
        
        //Setup SegmentController
        //RootViewController *ac = [RootViewController sharedAppController];
        //TODO: Slide to unlock -  Slide to pause
        segControl = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@"Start", @"Pause", nil]];
        
        segControl.selectedSegmentChangedHandler = ^(id sender) {
            SVSegmentedControl *segControl1 = (SVSegmentedControl *)sender;
            //NSLog(@"segmentedControl %i did select index %i (captured via block)", segControl.tag, segControl.selectedIndex);
            if(segControl1.selectedIndex == 0){
                segControl1.thumb.tintColor = [UIColor colorWithRed:0 green:0.5 blue:0.1 alpha:1];
                [self playSystemSound];
                //[ac.segTimer stop];
                [self.delegate pauseTimer:self];
            }else{
                segControl1.thumb.tintColor = [UIColor colorWithRed:0.6 green:0.2 blue:0.2 alpha:1];
                [self playSystemSound];
               // [ac.segTimer start];
                [self.delegate startTimer:self];
            }
            
        };
        
        segControl.backgroundColor = [UIColor grayColor];
        segControl.crossFadeLabelsOnDrag = YES;
        segControl.font = [UIFont boldSystemFontOfSize:19];
        
        segControl.segmentPadding = 14;
        segControl.height = 35;
        
        segControl.thumb.tintColor = [UIColor colorWithRed:0 green:0.5 blue:0.1 alpha:1];
        
        segControl.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        
        segControl.tag = 3;
        
        
        
        [self addSubview:segControl];
        [segControl release];
        
    }
    return self;
}


- (void)segmentedControl:(SVSegmentedControl*)segmentedControl didSelectIndex:(NSUInteger)index {
	
	NSLog(@"segmentedControl %i did select index %i (captured via delegate method)", segmentedControl.tag, index);
}

- (void)playSystemSound{
    AudioServicesPlaySystemSound (soundFileObject);
}

- (void)setButtonToStart{
    [segControl setSelectedIndex:0];
    segControl.thumb.tintColor = [UIColor colorWithRed:0 green:0.5 blue:0.1 alpha:1];
}

- (void)setButtonToPause{
    [segControl setSelectedIndex:1];
    segControl.thumb.tintColor = [UIColor colorWithRed:0.6 green:0.2 blue:0.2 alpha:1];
}


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
    AudioServicesDisposeSystemSoundID (soundFileObject);
    CFRelease (soundFileURLRef);
    
    [segControl release];
    [super dealloc];
}

@end
