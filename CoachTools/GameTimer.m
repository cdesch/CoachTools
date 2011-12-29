//
//  segmentedTimer.m
//  segmentedTimer
//
//  Created by Jeffrey Ludwig on 5/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameTimer.h"
#import "cocos2d.h"
#import "GameScene.h"
#import "PlistStringUtil.h"

@implementation GameTimer

@synthesize myTimer;
@synthesize timeString;
@synthesize alerts;
@synthesize homeScore;
@synthesize opponentScore;

@synthesize gameTimerButton;
@synthesize gameTimerDisplay;

@synthesize suspendTime;

@synthesize gameInterval;
@synthesize halfTime;
@synthesize quarter1;
@synthesize quarter2;
@synthesize quarter3;
@synthesize fullTime;
@synthesize warningTime;

//Initializer
- (id)init
{
    
    self = [super init];
    if (self) {
        
        state = stopped;
        
        // Init the time
        timeInt = 0;
        homeScore = 0;
        opponentScore = 0;
        timeString = @"0 00:00 0";
        
        //Set Time 
        halfTime = 30; // Default half time  45 min = 2700, 30 min = 1800 // Should be set when a new game is created. 
        fullTime = halfTime * 2;
        warningTime = 5;
        
        
        //Setup the Controls and Display for the timer
        CGRect gameTimerDisplayFrame =CGRectMake(625, 2, 300, 40);
        gameTimerDisplay = [[GameTimerDisplay alloc] initWithFrame:gameTimerDisplayFrame];
        [gameTimerDisplay setString:timeString];
        
        CGRect gameTimerButtonFrame =CGRectMake(200, 2, 200, 40);
        gameTimerButton = [[GameTimerButton alloc] initWithFrame:gameTimerButtonFrame];
        gameTimerButton.delegate = self;
        
        //SuspendTime

        
    }
    
    return self;
}

- (void)start{
    // Initialize the label for timer output and start the timer from 0.
    [self initAlerts];
    //[self alert:@"Alert!":@"The game has begun!"];
    timeInt = 0;
    state = running;
    myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/1.0 target:self selector:@selector(update) userInfo:nil repeats:YES];
}


- (void)pause{
    // Only pause if the timer is running.
    // Do nothing if the timer is already paused or stopped (not running)
    if(state == running){
        state = paused;
        [myTimer invalidate];
    }
}

- (void)resume{
    // Start the timer back up if it is not running.
    // Do nothing if the timer is already running.
    if(state == paused){        
        state = running;
        myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/1.0 target:self selector:@selector(update) userInfo:nil repeats:YES];
    }
}

- (void)reset{
    // Stop the timer and reset the timer to 0
    [self stop];
    timeInt = 0;
    [self outputTime];
}

-(void)restart{
    [self reset];
    [self start];
}

-(void)stop{
    // Stop the timer if it is running.
    // Do nothing if it is not running.
    if(state == running){
        [myTimer invalidate];
        state = paused;
    }
}

-(void)set:(int)newTime{
    timeInt = newTime;
}

- (void)update{
    // Increment the timer by 1 and call output time to display the new time.
    // Check for any alerts that should be displayed.
    timeInt = timeInt + 1;
    [self outputTime];

    if (gameInterval == 2){
        if(timeInt == halfTime){
            //Half Time - Pause the Game  and display and alert
            [self alert:@"Half Time!":@"The game clock has been paused!"]; 
            [self pause];
            [gameTimerButton setButtonToStart];
            //Push notification
            
        }else if (timeInt == fullTime){
            //Normal Game Time has expired //Extra time
            [self alert:@"Regulation Time Elapsed!":@"The game has now entered overage time!"];
            //Change Color of LCD Display
            //Push Notification
            
        }else if( timeInt == (halfTime - warningTime) || halfTime == (fullTime - warningTime)){
            //Game Half or Game End is approaching -  Flash the timer or display an alert
            
        }
    }else if (gameInterval == 4){
        if(timeInt == quarter1 || timeInt == quarter2 || timeInt == quarter3 ){
            //Half Time - Pause the Game  and display and alert
            [self alert:@"Quarter End!":@"The game clock has been paused!"]; 
            [self pause];
            [gameTimerButton setButtonToStart];
            //Push notification
            
        }else if (timeInt == fullTime){
            //Normal Game Time has expired //Extra time
            [self alert:@"Regulation Time Elapsed!":@"The game has now entered overage time!"];
            //Change Color of LCD Display
            //Push Notification
            
        }else if( timeInt == (halfTime - warningTime) || halfTime == (fullTime - warningTime)){
            //Game Half or Game End is approaching -  Flash the timer or display an alert
        }      
    }
    
}

-(void)outputTime{
    // Output the time to the first segment of the display controller.
    [gameTimerDisplay setString:[NSString stringWithFormat:@"%@ %@ %@" , [[NSNumber numberWithInt:homeScore] stringValue],[self timeToString], [[NSNumber numberWithInt:opponentScore] stringValue] ]];        
}

//Return time as String
-(NSString *)timeToString{
    // Convert the time to a formated string.
    return [NSString stringWithFormat:@"%02d:%02d", [self minutes], [self seconds]];    
}
//return minutes
-(NSInteger)minutes{
    return timeInt/60;
}
//return seconds
-(NSInteger)seconds{
    return timeInt % 60;
}
//return total seconds
-(NSInteger)timeToInt{
    return timeInt;
}

-(void)alert:(NSString *)title:(NSString *)message{
    UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle: title message: message delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
    
    [myAlert show];
    [myAlert release];    
}

-(void)initAlerts{
    // This is in development...
    alerts = [[NSMutableArray alloc] init];    
}

/*
-(void)addAlert:(timeAlert *)newAlert{
    [alerts addObject:newAlert];
}
*/



//Start the Timer // Delegate from the gameTimeButton
- (void)startTimer:(GameTimerButton *)button{

    if(state == paused){
        [self resume];
    }else{
        [self start];
    }
}

- (void)pauseTimer:(GameTimerButton *)button{
    [self pause];
}

//Deprecated
- (void)stopTimer:(GameTimerButton *)button{
    //End the Game!!!!!
    //DIVE DOWN INTO THE DIRECTOR --  GO into the Scene, GO into 
    CCDirector *director = [CCDirector sharedDirector];
    if([[director runningScene] isKindOfClass:[GameScene class]]){
        
    }
    
    //tell the Game Management it can save and dimiss. 
    //[perform shut down of cocos2d]
    
    //Reset the Timer // Change to 00:00 too
    
}
- (void)setGameTimer:(int)halfInMinutes warningTime:(int)warning{

    //halfInMinutes = 1;
    if(gameInterval ==2){
        halfTime = halfInMinutes * 60;
        fullTime = halfTime * 2;
        warningTime = warning * 60;
        
    }else if(gameInterval == 4){
        halfTime = halfInMinutes * 60;
        quarter1 = halfInMinutes * 60;
        quarter2 = quarter1 * 2;
        quarter3 = quarter1 * 3;
        fullTime = quarter1 * 4;
        warningTime = warning * 60;
        
    }
    
    homeScore = 0;
    opponentScore = 0;
    
    [self outputTime];
}


- (void)addHomeScore{
    homeScore ++;
    [self outputTime];
}
- (void)addOpponentScore{
    opponentScore ++;
    [self outputTime];
    
}

- (void)appWillSuspend{
    
    suspendTime = [[NSDate alloc] init];
    
}
- (void)appWillResume{

    if (state == running) {

        if(timeInt == (timeInt - (int)[suspendTime timeIntervalSinceNow]))
        {
            //Do Nothing. Just resume
        }
        else if(timeInt < halfTime){
            // Is it less than the half time
            
            if((timeInt - (int)[suspendTime timeIntervalSinceNow]) < halfTime){
                //Determine the difference
                timeInt = timeInt - (int)[suspendTime timeIntervalSinceNow];
            }else{
                
                //Stop Timer
                [self pause];
                [gameTimerButton setButtonToStart];
                
                //Set time                
                timeInt = halfTime;
                
                //Throw Warning that the clock was stopped at the half
                NSMutableArray *msgParams = [[[NSMutableArray alloc] init] autorelease];
                [msgParams addObject:[NSString stringWithFormat:@"%d", halfTime/60]];
                
                UIAlertView *someError = [[UIAlertView alloc] initWithTitle:[PlistStringUtil retrieveErrorText:@"gameTimeStop.title" withParams:msgParams] message:[PlistStringUtil retrieveErrorText:@"gameTimeStop.msg" withParams:msgParams] delegate: self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                
                [someError show];
                [someError release];
                
            }
                
                
        }else if (timeInt > halfTime){
            if((timeInt - (int)[suspendTime timeIntervalSinceNow]) < fullTime){
                //Determine the difference
                timeInt = timeInt - (int)[suspendTime timeIntervalSinceNow];
            }else{
                
                //Stop Timer
                [self pause];
                [gameTimerButton setButtonToStart];
                
                //Set time
                timeInt = fullTime;
                
                  //Throw Warning that the clock was stopped at the full time
                NSMutableArray *msgParams = [[[NSMutableArray alloc] init] autorelease];
                [msgParams addObject:[NSString stringWithFormat:@"%d", fullTime/60]];
                
                UIAlertView *someError = [[UIAlertView alloc] initWithTitle:[PlistStringUtil retrieveErrorText:@"gameTimeStop.title" withParams:msgParams] message:[PlistStringUtil retrieveErrorText:@"gameTimeStop.msg" withParams:msgParams] delegate: self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                
                [someError show];
                [someError release];
                
                //Stop Timer
                
            }
        }
        
    }
    
    //NSLog(@"%f", [suspendTime timeIntervalSinceNow]);
    
    [suspendTime release];
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
    [suspendTime release];
    [gameTimerButton release];
    [gameTimerDisplay release];
    [myTimer release];
    [timeString release];
    [alerts release];
    //[timeColor release];
    [super dealloc];
}

@end
