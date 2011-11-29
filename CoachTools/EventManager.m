//
//  EventManager.m
//  CoachTools
//
//  Created by Chris Desch on 8/30/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import "EventManager.h"
#import <EventKit/EventKit.h>


@implementation EventManager


//Combine the two date components and return the result. Date from one, time from the other
- (NSDate*)combineDate:(NSDate*)date time:(NSDate*)time{
    
    NSDate* tempDate;
    
    NSCalendar *dateCal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComponent = [dateCal components:( NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekCalendarUnit | NSWeekdayCalendarUnit |NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:date];
    
    NSCalendar *timeCal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *timeComponent = [timeCal components:( NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:time];
    
    // adjust them for first day of previous week (Monday)
    [dateComponent setHour:[timeComponent hour]];
    [dateComponent setMinute:[timeComponent minute]];
    
    //Format Date for display
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    
    // construct new date and return
    //dateTextField.text = [dateFormatter stringFromDate:[dateCal dateFromComponents:dateComponent]];
    //self.game.date = [dateCal dateFromComponents:dateComponent];
    tempDate =  [[dateCal dateFromComponents:dateComponent] copy];
    
    [timeCal release];
    [dateCal release];
    [dateFormatter release];
    
    return tempDate;
}


+ (BOOL)checkCalendarEntryExists:(NSString*)eventIdentifier{

    //Get the Event DB
    EKEventStore *eventDB = [[EKEventStore alloc] init];
    EKEvent *myEvent;
    
    //Check if the eventidentifier actually exists
    if((myEvent  = [eventDB eventWithIdentifier:eventIdentifier])){
    
        [eventDB release];
        return TRUE;
    }
    
    [eventDB release];
    return FALSE;
    
}
//Check if the date on the game is different from the date on the calendar
+ (BOOL)checkCalendarDateIsEqaul:(NSString*)eventIdentifier startDate:(NSDate *)startDate{
    
    //Get the Event DB    
    EKEventStore *eventDB = [[EKEventStore alloc] init];
    EKEvent *myEvent;

    //Update the Event Date if it has changed. 
    if([startDate isEqualToDate:myEvent.startDate]){
       //Do nothing // Date is equal
        
        [eventDB release];
        return TRUE;
    }    
    
    [eventDB release];
    return FALSE;
}

+ (NSDate*)getCurrentCalendarDate:(NSString*)eventIdentifier{
    
    //Get the Event DB    
    EKEventStore *eventDB = [[EKEventStore alloc] init];
    EKEvent *myEvent;
    
     
    [eventDB release];
    return myEvent.startDate;
    
}

//Creates a entry in the calendar and returns the coorsponding eventindentifier
- (NSString*)setCalendarEntry:(NSDate*)startDate title:(NSString*)title{
    EKEventStore *eventDB = [[EKEventStore alloc] init];
    EKEvent *myEvent  = [EKEvent eventWithEventStore:eventDB];
    
    myEvent.title     = title;
    myEvent.startDate = startDate; 
    myEvent.endDate   = [startDate dateByAddingTimeInterval:7200];
    
    //myEvent.allDay = YES;
    [myEvent setCalendar:[eventDB defaultCalendarForNewEvents]];
    
    
    
    
    NSError *err;
    [eventDB saveEvent:myEvent span:EKSpanThisEvent error:&err];
    
    if (err != noErr) {
        
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Error saving Entry to calendar"
                              message:@"Not saved!"
                              delegate:nil
                              cancelButtonTitle:@"Okay"
                              otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
    
    [eventDB release];
    return myEvent.eventIdentifier;    
    
}


@end
