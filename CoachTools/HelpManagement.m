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

+ (void)errorMessage:(NSString*)title error:(NSString *)error{

    NSMutableArray *msgParams = [[[NSMutableArray alloc] init] autorelease];
    [msgParams addObject:title];
    
    UIAlertView *someError = [[UIAlertView alloc] initWithTitle:[PlistStringUtil retrieveErrorText:[error stringByAppendingString:@".title"] withParams:msgParams] message:[PlistStringUtil retrieveErrorText:[error stringByAppendingString:@".msg"] withParams:msgParams] delegate: self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    [someError show];
    [someError release];
}

@end
