// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Training.h instead.

#import <CoreData/CoreData.h>


@class Season;
@class Person;








@interface TrainingID : NSManagedObjectID {}
@end

@interface _Training : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (TrainingID*)objectID;



@property (nonatomic, retain) NSString *eventIdentifier;

//- (BOOL)validateEventIdentifier:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSDate *date;

//- (BOOL)validateDate:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *trainingLocation;

//- (BOOL)validateTrainingLocation:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *trainingDescription;

//- (BOOL)validateTrainingDescription:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *trainingNumber;

@property short trainingNumberValue;
- (short)trainingNumberValue;
- (void)setTrainingNumberValue:(short)value_;

//- (BOOL)validateTrainingNumber:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *trainingNotes;

//- (BOOL)validateTrainingNotes:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) Season* season;
//- (BOOL)validateSeason:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSSet* playersAttended;
- (NSMutableSet*)playersAttendedSet;




@end

@interface _Training (CoreDataGeneratedAccessors)

- (void)addPlayersAttended:(NSSet*)value_;
- (void)removePlayersAttended:(NSSet*)value_;
- (void)addPlayersAttendedObject:(Person*)value_;
- (void)removePlayersAttendedObject:(Person*)value_;

@end

@interface _Training (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveEventIdentifier;
- (void)setPrimitiveEventIdentifier:(NSString*)value;




- (NSDate*)primitiveDate;
- (void)setPrimitiveDate:(NSDate*)value;




- (NSString*)primitiveTrainingLocation;
- (void)setPrimitiveTrainingLocation:(NSString*)value;




- (NSString*)primitiveTrainingDescription;
- (void)setPrimitiveTrainingDescription:(NSString*)value;




- (NSNumber*)primitiveTrainingNumber;
- (void)setPrimitiveTrainingNumber:(NSNumber*)value;

- (short)primitiveTrainingNumberValue;
- (void)setPrimitiveTrainingNumberValue:(short)value_;




- (NSString*)primitiveTrainingNotes;
- (void)setPrimitiveTrainingNotes:(NSString*)value;





- (Season*)primitiveSeason;
- (void)setPrimitiveSeason:(Season*)value;



- (NSMutableSet*)primitivePlayersAttended;
- (void)setPrimitivePlayersAttended:(NSMutableSet*)value;


@end
