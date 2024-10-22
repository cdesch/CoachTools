// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Season.h instead.

#import <CoreData/CoreData.h>


@class Game;
@class Team;
@class Training;







@interface SeasonID : NSManagedObjectID {}
@end

@interface _Season : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SeasonID*)objectID;



@property (nonatomic, retain) NSString *name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSDate *startDate;

//- (BOOL)validateStartDate:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *ended;

@property BOOL endedValue;
- (BOOL)endedValue;
- (void)setEndedValue:(BOOL)value_;

//- (BOOL)validateEnded:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSDate *endDate;

//- (BOOL)validateEndDate:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *league;

//- (BOOL)validateLeague:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSSet* games;
- (NSMutableSet*)gamesSet;



@property (nonatomic, retain) Team* team;
//- (BOOL)validateTeam:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSSet* training;
- (NSMutableSet*)trainingSet;




@end

@interface _Season (CoreDataGeneratedAccessors)

- (void)addGames:(NSSet*)value_;
- (void)removeGames:(NSSet*)value_;
- (void)addGamesObject:(Game*)value_;
- (void)removeGamesObject:(Game*)value_;

- (void)addTraining:(NSSet*)value_;
- (void)removeTraining:(NSSet*)value_;
- (void)addTrainingObject:(Training*)value_;
- (void)removeTrainingObject:(Training*)value_;

@end

@interface _Season (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSDate*)primitiveStartDate;
- (void)setPrimitiveStartDate:(NSDate*)value;




- (NSNumber*)primitiveEnded;
- (void)setPrimitiveEnded:(NSNumber*)value;

- (BOOL)primitiveEndedValue;
- (void)setPrimitiveEndedValue:(BOOL)value_;




- (NSDate*)primitiveEndDate;
- (void)setPrimitiveEndDate:(NSDate*)value;




- (NSString*)primitiveLeague;
- (void)setPrimitiveLeague:(NSString*)value;





- (NSMutableSet*)primitiveGames;
- (void)setPrimitiveGames:(NSMutableSet*)value;



- (Team*)primitiveTeam;
- (void)setPrimitiveTeam:(Team*)value;



- (NSMutableSet*)primitiveTraining;
- (void)setPrimitiveTraining:(NSMutableSet*)value;


@end
