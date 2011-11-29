//
//  GameTimerButton.h
//  CoachTools
//
//  Created by cj on 7/15/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVSegmentedControl.h"
#include <AudioToolbox/AudioToolbox.h>

@protocol GameTimerButtonDelegate;

@interface GameTimerButton : UIView <SVSegmentedControlDelegate> {
    id <GameTimerButtonDelegate> delegate;
    
    SVSegmentedControl *segControl;
    
    CFURLRef		soundFileURLRef;
	SystemSoundID	soundFileObject;
}

@property (retain) id delegate;

@property (nonatomic,retain)  SVSegmentedControl *segControl;

@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;


- (void)playSystemSound;
- (void)setButtonToStart;
- (void)setButtonToPause;

@end


@protocol GameTimerButtonDelegate <NSObject>

- (void)startTimer:(GameTimerButton *)button;
- (void)pauseTimer:(GameTimerButton *)button;
- (void)stopTimer:(GameTimerButton *)button;

@end