// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Person.h instead.

#import <CoreData/CoreData.h>


@class Training;
@class Team;
@class GameScore;
@class GameSub;
@class GameScore;
@class GameStart;
@class GamePenalty;

















@interface PersonID : NSManagedObjectID {}
@end

@interface _Person : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PersonID*)objectID;



@property (nonatomic, retain) NSNumber *cPlayingTime;

@property double cPlayingTimeValue;
- (double)cPlayingTimeValue;
- (void)setCPlayingTimeValue:(double)value_;

//- (BOOL)validateCPlayingTime:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *active;

@property BOOL activeValue;
- (BOOL)activeValue;
- (void)setActiveValue:(BOOL)value_;

//- (BOOL)validateActive:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *lastName;

//- (BOOL)validateLastName:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *firstName;

//- (BOOL)validateFirstName:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *contactIdentifier;

@property double contactIdentifierValue;
- (double)contactIdentifierValue;
- (void)setContactIdentifierValue:(double)value_;

//- (BOOL)validateContactIdentifier:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *secondaryPosition;

//- (BOOL)validateSecondaryPosition:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *cGoals;

@property short cGoalsValue;
- (short)cGoalsValue;
- (void)setCGoalsValue:(short)value_;

//- (BOOL)validateCGoals:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *phoneNumber;

@property short phoneNumberValue;
- (short)phoneNumberValue;
- (void)setPhoneNumberValue:(short)value_;

//- (BOOL)validatePhoneNumber:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *emergancyContact;

@property double emergancyContactValue;
- (double)emergancyContactValue;
- (void)setEmergancyContactValue:(double)value_;

//- (BOOL)validateEmergancyContact:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *email;

//- (BOOL)validateEmail:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *cStarts;

@property short cStartsValue;
- (short)cStartsValue;
- (void)setCStartsValue:(short)value_;

//- (BOOL)validateCStarts:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *playerNumber;

//- (BOOL)validatePlayerNumber:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSDate *birthdate;

//- (BOOL)validateBirthdate:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *cAbsences;

@property short cAbsencesValue;
- (short)cAbsencesValue;
- (void)setCAbsencesValue:(short)value_;

//- (BOOL)validateCAbsences:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *primaryPosition;

//- (BOOL)validatePrimaryPosition:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSSet* training;
- (NSMutableSet*)trainingSet;



@property (nonatomic, retain) Team* team;
//- (BOOL)validateTeam:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSSet* gameScore;
- (NSMutableSet*)gameScoreSet;



@property (nonatomic, retain) NSSet* gameSub;
- (NSMutableSet*)gameSubSet;



@property (nonatomic, retain) NSSet* gameAssist;
- (NSMutableSet*)gameAssistSet;



@property (nonatomic, retain) NSSet* gameStart;
- (NSMutableSet*)gameStartSet;



@property (nonatomic, retain) NSSet* gamePenalty;
- (NSMutableSet*)gamePenaltySet;




+ (NSArray*)fetchGetAllPlayers:(NSManagedObjectContext*)moc_ ;
+ (NSArray*)fetchGetAllPlayers:(NSManagedObjectContext*)moc_ error:(NSError**)error_;



@end

@interface _Person (CoreDataGeneratedAccessors)

- (void)addTraining:(NSSet*)value_;
- (void)removeTraining:(NSSet*)value_;
- (void)addTrainingObject:(Training*)value_;
- (void)removeTrainingObject:(Training*)value_;

- (void)addGameScore:(NSSet*)value_;
- (void)removeGameScore:(NSSet*)value_;
- (void)addGameScoreObject:(GameScore*)value_;
- (void)removeGameScoreObject:(GameScore*)value_;

- (void)addGameSub:(NSSet*)value_;
- (void)removeGameSub:(NSSet*)value_;
- (void)addGameSubObject:(GameSub*)value_;
- (void)removeGameSubObject:(GameSub*)value_;

- (void)addGameAssist:(NSSet*)value_;
- (void)removeGameAssist:(NSSet*)value_;
- (void)addGameAssistObject:(GameScore*)value_;
- (void)removeGameAssistObject:(GameScore*)value_;

- (void)addGameStart:(NSSet*)value_;
- (void)removeGameStart:(NSSet*)value_;
- (void)addGameStartObject:(GameStart*)value_;
- (void)removeGameStartObject:(GameStart*)value_;

- (void)addGamePenalty:(NSSet*)value_;
- (void)removeGamePenalty:(NSSet*)value_;
- (void)addGamePenaltyObject:(GamePenalty*)value_;
- (void)removeGamePenaltyObject:(GamePenalty*)value_;

@end

@interface _Person (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveCPlayingTime;
- (void)setPrimitiveCPlayingTime:(NSNumber*)value;

- (double)primitiveCPlayingTimeValue;
- (void)setPrimitiveCPlayingTimeValue:(double)value_;




- (NSNumber*)primitiveActive;
- (void)setPrimitiveActive:(NSNumber*)value;

- (BOOL)primitiveActiveValue;
- (void)setPrimitiveActiveValue:(BOOL)value_;




- (NSString*)primitiveLastName;
- (void)setPrimitiveLastName:(NSString*)value;




- (NSString*)primitiveFirstName;
- (void)setPrimitiveFirstName:(NSString*)value;




- (NSNumber*)primitiveContactIdentifier;
- (void)setPrimitiveContactIdentifier:(NSNumber*)value;

- (double)primitiveContactIdentifierValue;
- (void)setPrimitiveContactIdentifierValue:(double)value_;




- (NSString*)primitiveSecondaryPosition;
- (void)setPrimitiveSecondaryPosition:(NSString*)value;




- (NSNumber*)primitiveCGoals;
- (void)setPrimitiveCGoals:(NSNumber*)value;

- (short)primitiveCGoalsValue;
- (void)setPrimitiveCGoalsValue:(short)value_;




- (NSNumber*)primitivePhoneNumber;
- (void)setPrimitivePhoneNumber:(NSNumber*)value;

- (short)primitivePhoneNumberValue;
- (void)setPrimitivePhoneNumberValue:(short)value_;




- (NSNumber*)primitiveEmergancyContact;
- (void)setPrimitiveEmergancyContact:(NSNumber*)value;

- (double)primitiveEmergancyContactValue;
- (void)setPrimitiveEmergancyContactValue:(double)value_;




- (NSString*)primitiveEmail;
- (void)setPrimitiveEmail:(NSString*)value;




- (NSNumber*)primitiveCStarts;
- (void)setPrimitiveCStarts:(NSNumber*)value;

- (short)primitiveCStartsValue;
- (void)setPrimitiveCStartsValue:(short)value_;




- (NSString*)primitivePlayerNumber;
- (void)setPrimitivePlayerNumber:(NSString*)value;




- (NSDate*)primitiveBirthdate;
- (void)setPrimitiveBirthdate:(NSDate*)value;




- (NSNumber*)primitiveCAbsences;
- (void)setPrimitiveCAbsences:(NSNumber*)value;

- (short)primitiveCAbsencesValue;
- (void)setPrimitiveCAbsencesValue:(short)value_;




- (NSString*)primitivePrimaryPosition;
- (void)setPrimitivePrimaryPosition:(NSString*)value;





- (NSMutableSet*)primitiveTraining;
- (void)setPrimitiveTraining:(NSMutableSet*)value;



- (Team*)primitiveTeam;
- (void)setPrimitiveTeam:(Team*)value;



- (NSMutableSet*)primitiveGameScore;
- (void)setPrimitiveGameScore:(NSMutableSet*)value;



- (NSMutableSet*)primitiveGameSub;
- (void)setPrimitiveGameSub:(NSMutableSet*)value;



- (NSMutableSet*)primitiveGameAssist;
- (void)setPrimitiveGameAssist:(NSMutableSet*)value;



- (NSMutableSet*)primitiveGameStart;
- (void)setPrimitiveGameStart:(NSMutableSet*)value;



- (NSMutableSet*)primitiveGamePenalty;
- (void)setPrimitiveGamePenalty:(NSMutableSet*)value;


@end
