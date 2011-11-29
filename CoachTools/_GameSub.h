// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to GameSub.h instead.

#import <CoreData/CoreData.h>


@class Game;
@class Person;





@interface GameSubID : NSManagedObjectID {}
@end

@interface _GameSub : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (GameSubID*)objectID;



@property (nonatomic, retain) NSNumber *startTime;

@property double startTimeValue;
- (double)startTimeValue;
- (void)setStartTimeValue:(double)value_;

//- (BOOL)validateStartTime:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *positionName;

//- (BOOL)validatePositionName:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *endTime;

@property double endTimeValue;
- (double)endTimeValue;
- (void)setEndTimeValue:(double)value_;

//- (BOOL)validateEndTime:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) Game* game;
//- (BOOL)validateGame:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) Person* player;
//- (BOOL)validatePlayer:(id*)value_ error:(NSError**)error_;




@end

@interface _GameSub (CoreDataGeneratedAccessors)

@end

@interface _GameSub (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveStartTime;
- (void)setPrimitiveStartTime:(NSNumber*)value;

- (double)primitiveStartTimeValue;
- (void)setPrimitiveStartTimeValue:(double)value_;




- (NSString*)primitivePositionName;
- (void)setPrimitivePositionName:(NSString*)value;




- (NSNumber*)primitiveEndTime;
- (void)setPrimitiveEndTime:(NSNumber*)value;

- (double)primitiveEndTimeValue;
- (void)setPrimitiveEndTimeValue:(double)value_;





- (Game*)primitiveGame;
- (void)setPrimitiveGame:(Game*)value;



- (Person*)primitivePlayer;
- (void)setPrimitivePlayer:(Person*)value;


@end
