//
//  CalendarManager.m
//  CoachTools
//
//  Created by Chris Desch on 12/12/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import "CalendarManager.h"

@implementation CalendarManager

@synthesize eventStore;
@synthesize eventsList;
@synthesize defaultCalendar;

- (id) init
{
    if (self = [super init])
    {
        /*
        self.eventStore = [[EKEventStore alloc] init];
        
        self.eventsList = [[NSMutableArray alloc] initWithArray:0];
        
        // Get the default calendar from store.
        self.defaultCalendar = [self.eventStore defaultCalendarForNewEvents];
         */

    }
    return self;
}

- (NSString*)addEvent:(NSString*)title location:(NSString*)location notes:(NSString*)notes date:(NSDate*)date{
    
    EKEventStore *eventDB = [[EKEventStore alloc] init];
    EKEvent *myEvent  = [EKEvent eventWithEventStore:eventDB];
    
    myEvent.title     = title;//[NSString stringWithFormat:@"%@ - Game: %@", season.team.name, self.gameNumberTextField.text];
    myEvent.startDate = date; 
    myEvent.endDate   = [date dateByAddingTimeInterval:7200];
    myEvent.location  = location;
    myEvent.notes     = notes;
    myEvent.allDay = NO;

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
        
        [eventDB release];
        return @"";
        
    }
    [eventDB release];
    
    return myEvent.eventIdentifier;

} 

- (BOOL)updateEvent:(NSString*)eventIdenifier{
    
    return TRUE;
    
}

- (BOOL)removeEvent:(NSString*)eventIdenifier{
    
    return TRUE;
    
}

- (BOOL)syncEvents:(NSArray*)eventsList{
    
    return TRUE;
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[eventStore release];
	[eventsList release];
	[defaultCalendar release];

	[super dealloc];
}

@end
