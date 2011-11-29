//
//  HelpStringUtil.h
//  CoachTools
//
//  Created by Lawrence Brooks on 2011/07/12.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PlistStringUtil : NSObject {
    
}

+(NSString *)retrieveErrorText: (NSString*)errorId withParams: (NSArray *)params;

#pragma mark - 'Private' Methods
+(NSDictionary *) retrieveDictionaryFromPlist: (NSString *)resource;
+(NSString *) replacePlaceHolders: (NSString *)text withParams: (NSArray *)params;

@end
