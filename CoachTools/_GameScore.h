// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to GameScore.h instead.

#import <CoreData/CoreData.h>


@class Game;
@class Person;
@class Person;




@interface GameScoreID : NSManagedObjectID {}
@end

@interface _GameScore : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (GameScoreID*)objectID;



@property (nonatomic, retain) NSString *scoringPosition;

//- (BOOL)validateScoringPosition:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *time;

@property short timeValue;
- (short)timeValue;
- (void)setTimeValue:(short)value_;

//- (BOOL)validateTime:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) Game* game;
//- (BOOL)validateGame:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) Person* assistingPlayer;
//- (BOOL)validateAssistingPlayer:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) Person* player;
//- (BOOL)validatePlayer:(id*)value_ error:(NSError**)error_;




@end

@interface _GameScore (CoreDataGeneratedAccessors)

@end

@interface _GameScore (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveScoringPosition;
- (void)setPrimitiveScoringPosition:(NSString*)value;




- (NSNumber*)primitiveTime;
- (void)setPrimitiveTime:(NSNumber*)value;

- (short)primitiveTimeValue;
- (void)setPrimitiveTimeValue:(short)value_;





- (Game*)primitiveGame;
- (void)setPrimitiveGame:(Game*)value;



- (Person*)primitiveAssistingPlayer;
- (void)setPrimitiveAssistingPlayer:(Person*)value;



- (Person*)primitivePlayer;
- (void)setPrimitivePlayer:(Person*)value;


@end
