//
//  HelpManagement.m
//  CoachTools
//
//  Created by Chris Desch on 11/19/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import "HelpManagement.h"
#import "PlistStringUtil.h"
#import "FlurryAnalytics.h"

@implementation HelpManagement

+ (void)errorMessage:(NSString*)title error:(NSString *)errorId{

    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ErrorMessages" ofType:@"plist"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        //NSLog(@"%@.plist exists", resource);
    } else {
        //NSLog(@"%@.plist does not exist", resource);
    }


    
    NSDictionary *myDict =  [[NSDictionary alloc] initWithContentsOfFile:path];    
    NSString *errorTitle = [myDict objectForKey:[errorId stringByAppendingString:@".title"]];
    NSString *errorMessage= [myDict objectForKey:[errorId stringByAppendingString:@".msg"]];

    NSMutableArray *msgParams = [[[NSMutableArray alloc] init] autorelease];
    [msgParams addObject:errorTitle];

    UIAlertView *someError = [[UIAlertView alloc] initWithTitle:title message:errorMessage delegate: self cancelButtonTitle:@"Ok" otherButtonTitles: nil];

    [someError show];
    [someError release];
    [myDict release];

}

+ (void)errorMessageWithParams:(NSMutableArray*)msgParams error:(NSString *)error{
    
    UIAlertView *someError = [[UIAlertView alloc] initWithTitle:[PlistStringUtil retrieveErrorText:[error stringByAppendingString:@".title"] withParams:msgParams] message:[PlistStringUtil retrieveErrorText:[error stringByAppendingString:@".msg"] withParams:msgParams] delegate: self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    [someError show];
    [someError release];

}




@end
