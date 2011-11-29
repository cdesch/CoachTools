//
//  segmentedTimer.h
//  segmentedTimer
//
//  Created by Jeffrey Ludwig on 5/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GameTimerDisplay.h"
#import "GameTimerButton.h"


@interface GameTimer : NSObject <GameTimerButtonDelegate> {
    
    NSTimer         *myTimer;
    NSInteger       timeInt;
    NSInteger       homeScore;
    NSInteger       opponentScore;
    NSString        *timeString;
    bool            timerIsRunning;
    NSMutableArray  *alerts;
    
    enum
    {
        running,
        paused,
        stopped
    }state;

    NSInteger       halfTime;       //Time until Half
    NSInteger       fullTime;       //Time until End of Game (should be half x2)
    
    NSInteger       warningTime;    //5 Min warning to end of half or game 
    
    GameTimerButton  *gameTimerButton;
    GameTimerDisplay *gameTimerDisplay;
    
    NSDate          *suspendTime;
        
}

@property (nonatomic, retain) NSTimer           *myTimer;
@property (nonatomic, retain) NSString          *timeString;
@property (nonatomic, retain) NSMutableArray    *alerts;
@property (nonatomic, readwrite) NSInteger       homeScore;
@property (nonatomic, readwrite) NSInteger       opponentScore;

@property (nonatomic, retain) GameTimerButton  *gameTimerButton;
@property (nonatomic, retain) GameTimerDisplay *gameTimerDisplay;
@property (nonatomic, retain) NSDate           *suspendTime;


@property (nonatomic, readwrite) NSInteger       halfTime;       //Time until Half
@property (nonatomic, readwrite) NSInteger       fullTime;       //Time until End of Game (should be half x2)
@property (nonatomic, readwrite) NSInteger       warningTime;    //5 Min warning to end of half or game 

- (void) start;
- (void) pause;
- (void) resume;
- (void) reset;
- (void) stop;
- (void) alert:(NSString *)title:(NSString *)message;
- (void) initAlerts;
- (void) outputTime;
- (NSString*) timeToString;
- (NSInteger) minutes;
- (NSInteger) seconds;
- (NSInteger) timeToInt;

- (void)setGameTimer:(int)halfInMinutes warningTime:(int)warning;

- (void)addHomeScore;
- (void)addOpponentScore;

- (void)appWillSuspend;
- (void)appWillResume;

@end


