//
//  EventManager.h
//  CoachTools
//
//  Created by Chris Desch on 8/30/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventManager : NSObject {
    
    
}

- (NSDate*)combineDate:(NSDate*)date time:(NSDate*)time;
+ (BOOL)checkCalendarEntryExists:(NSString*)eventIdentifier;
+ (BOOL)checkCalendarDateIsEqaul:(NSString*)eventIdentifier startDate:(NSDate *)startDate;
+ (NSDate*)getCurrentCalendarDate:(NSString*)eventIdentifier;
+ (NSString*)setCalendarEntry:(NSDate*)startDate title:(NSString*)title;
+ (void)updateCalendarEntry:(NSDate*)startDate title:(NSString*)title eventIdentifier:(NSString*)eventIdentifier;
+ (void)deleteCalendarEntry:(NSString*)eventIdentifier;

@end
