//
//  FormationPosition.h
//  CoachTools
//
//  Created by cj on 6/7/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FormationPosition : NSObject {
    NSString *positionName;
    NSNumber *x;
    NSNumber *y;
}

@property(nonatomic, retain) NSString *positionName;
@property(nonatomic, retain) NSNumber *x;
@property(nonatomic, retain) NSNumber *y;

- (id)initWithDictionary:(NSDictionary *)aDictionary;

@property (readonly) CGPoint positionForPlayer;

@end
