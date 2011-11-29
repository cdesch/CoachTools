//
//  HelpStringUtil.m
//  CoachTools
//
//  Created by Lawrence Brooks on 2011/07/12.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import "PlistStringUtil.h"


@implementation PlistStringUtil

+(NSString *)retrieveErrorText: (NSString*)errorId withParams:(NSArray *)params
{
    NSDictionary *myDict = [PlistStringUtil retrieveDictionaryFromPlist:@"ErrorMessages"];
    NSString *errorMessage = [PlistStringUtil replacePlaceHolders:[myDict objectForKey:errorId] withParams:params];
    [myDict dealloc];
    return errorMessage;
}

#pragma mark - 'Private' Methods
+(NSDictionary *) retrieveDictionaryFromPlist:(NSString *)resource
{
    NSString *path = [[NSBundle mainBundle] pathForResource:resource ofType:@"plist"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        //NSLog(@"%@.plist exists", resource);
    } else {
        //NSLog(@"%@.plist does not exist", resource);
    }
    
    return [[NSDictionary alloc] initWithContentsOfFile:path];
}

+(NSString *)replacePlaceHolders:(NSString *)text withParams:(NSArray *)params
{    
    if(params != nil)
    {
        for (int i = 0; i < [params count]; i++)
        {
            NSString * param = [params objectAtIndex:i];
            NSString * key = [NSString stringWithFormat:@"{%d}", i];
            text = [text stringByReplacingOccurrencesOfString:key withString:param];
        }
    }
    return text;
}

@end
