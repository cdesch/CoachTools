//
//  Formation.h
//  CoachTools
//
//  Created by cj on 6/7/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Formation : NSObject {
    NSString *formationName;
    NSMutableDictionary *formationPositionsDictionary;
}

@property (nonatomic, retain) NSString *formationName;
@property (nonatomic, retain) NSMutableDictionary *formationPositionsDictionary;

- (id)initWithDictionary:(NSDictionary *)aDictionary;
- (void)setupFormationArray;

@end
