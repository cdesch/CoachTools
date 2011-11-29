//
//  GameTimerDisplay.h
//  CoachTools
//
//  Created by cj on 7/14/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MTIBulbView;

@interface GameTimerDisplay : UIView {
    MTIBulbView *bulbView;
    NSTimer *timer;
}

@property (nonatomic, retain) MTIBulbView *bulbView;

- (void)setString:(NSString *)aString;
- (void)tick:(NSTimer*)t;

@end
