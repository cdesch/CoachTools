//
//  CalendarManager.h
//  CoachTools
//
//  Created by Chris Desch on 12/12/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import <EventKit/EventKit.h>

@interface CalendarManager : NSObject {

	EKEventStore *eventStore;
	EKCalendar *defaultCalendar;
	NSMutableArray *eventsList;
}

@property (nonatomic, retain) EKEventStore *eventStore;
@property (nonatomic, retain) EKCalendar *defaultCalendar;
@property (nonatomic, retain) NSMutableArray *eventsList;

- (NSString*)addEvent:(NSString*)title location:(NSString*)location notes:(NSString*)notes date:(NSDate*)date;
- (BOOL)updateEvent:(NSString*)eventIdenifier;
- (BOOL)removeEvent:(NSString*)eventIdenifier;
- (BOOL)syncEvents:(NSArray*)eventsList;

@end
