// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Person.h instead.

#import <CoreData/CoreData.h>


@class Training;
@class GamePenalty;
@class GameScore;
@class Team;
@class Game;
@class GameSub;
@class GameScore;
@class GameStart;
@class EmergencyContact;













@interface PersonID : NSManagedObjectID {}
@end

@interface _Person : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PersonID*)objectID;



@property (nonatomic, retain) NSString *lastName;

//- (BOOL)validateLastName:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *phoneNumber;

@property short phoneNumberValue;
- (short)phoneNumberValue;
- (void)setPhoneNumberValue:(short)value_;

//- (BOOL)validatePhoneNumber:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *contactIdentifier;

//- (BOOL)validateContactIdentifier:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *firstName;

//- (BOOL)validateFirstName:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *playerNumber;

//- (BOOL)validatePlayerNumber:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *active;

@property BOOL activeValue;
- (BOOL)activeValue;
- (void)setActiveValue:(BOOL)value_;

//- (BOOL)validateActive:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *email;

//- (BOOL)validateEmail:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *secondaryPosition;

//- (BOOL)validateSecondaryPosition:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSDate *birthdate;

//- (BOOL)validateBirthdate:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *teamCaptain;

@property BOOL teamCaptainValue;
- (BOOL)teamCaptainValue;
- (void)setTeamCaptainValue:(BOOL)value_;

//- (BOOL)validateTeamCaptain:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *primaryPosition;

//- (BOOL)validatePrimaryPosition:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSSet* training;
- (NSMutableSet*)trainingSet;



@property (nonatomic, retain) NSSet* gamePenalty;
- (NSMutableSet*)gamePenaltySet;



@property (nonatomic, retain) NSSet* gameScore;
- (NSMutableSet*)gameScoreSet;



@property (nonatomic, retain) Team* team;
//- (BOOL)validateTeam:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSSet* game;
- (NSMutableSet*)gameSet;



@property (nonatomic, retain) NSSet* gameSub;
- (NSMutableSet*)gameSubSet;



@property (nonatomic, retain) NSSet* gameAssist;
- (NSMutableSet*)gameAssistSet;



@property (nonatomic, retain) NSSet* gameStart;
- (NSMutableSet*)gameStartSet;



@property (nonatomic, retain) NSSet* emergencyContact;
- (NSMutableSet*)emergencyContactSet;




+ (NSArray*)fetchGetAllPlayers:(NSManagedObjectContext*)moc_ ;
+ (NSArray*)fetchGetAllPlayers:(NSManagedObjectContext*)moc_ error:(NSError**)error_;



@end

@interface _Person (CoreDataGeneratedAccessors)

- (void)addTraining:(NSSet*)value_;
- (void)removeTraining:(NSSet*)value_;
- (void)addTrainingObject:(Training*)value_;
- (void)removeTrainingObject:(Training*)value_;

- (void)addGamePenalty:(NSSet*)value_;
- (void)removeGamePenalty:(NSSet*)value_;
- (void)addGamePenaltyObject:(GamePenalty*)value_;
- (void)removeGamePenaltyObject:(GamePenalty*)value_;

- (void)addGameScore:(NSSet*)value_;
- (void)removeGameScore:(NSSet*)value_;
- (void)addGameScoreObject:(GameScore*)value_;
- (void)removeGameScoreObject:(GameScore*)value_;

- (void)addGame:(NSSet*)value_;
- (void)removeGame:(NSSet*)value_;
- (void)addGameObject:(Game*)value_;
- (void)removeGameObject:(Game*)value_;

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

- (void)addEmergencyContact:(NSSet*)value_;
- (void)removeEmergencyContact:(NSSet*)value_;
- (void)addEmergencyContactObject:(EmergencyContact*)value_;
- (void)removeEmergencyContactObject:(EmergencyContact*)value_;

@end

@interface _Person (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveLastName;
- (void)setPrimitiveLastName:(NSString*)value;




- (NSNumber*)primitivePhoneNumber;
- (void)setPrimitivePhoneNumber:(NSNumber*)value;

- (short)primitivePhoneNumberValue;
- (void)setPrimitivePhoneNumberValue:(short)value_;




- (NSString*)primitiveContactIdentifier;
- (void)setPrimitiveContactIdentifier:(NSString*)value;




- (NSString*)primitiveFirstName;
- (void)setPrimitiveFirstName:(NSString*)value;




- (NSString*)primitivePlayerNumber;
- (void)setPrimitivePlayerNumber:(NSString*)value;




- (NSNumber*)primitiveActive;
- (void)setPrimitiveActive:(NSNumber*)value;

- (BOOL)primitiveActiveValue;
- (void)setPrimitiveActiveValue:(BOOL)value_;




- (NSString*)primitiveEmail;
- (void)setPrimitiveEmail:(NSString*)value;




- (NSString*)primitiveSecondaryPosition;
- (void)setPrimitiveSecondaryPosition:(NSString*)value;




- (NSDate*)primitiveBirthdate;
- (void)setPrimitiveBirthdate:(NSDate*)value;




- (NSNumber*)primitiveTeamCaptain;
- (void)setPrimitiveTeamCaptain:(NSNumber*)value;

- (BOOL)primitiveTeamCaptainValue;
- (void)setPrimitiveTeamCaptainValue:(BOOL)value_;




- (NSString*)primitivePrimaryPosition;
- (void)setPrimitivePrimaryPosition:(NSString*)value;





- (NSMutableSet*)primitiveTraining;
- (void)setPrimitiveTraining:(NSMutableSet*)value;



- (NSMutableSet*)primitiveGamePenalty;
- (void)setPrimitiveGamePenalty:(NSMutableSet*)value;



- (NSMutableSet*)primitiveGameScore;
- (void)setPrimitiveGameScore:(NSMutableSet*)value;



- (Team*)primitiveTeam;
- (void)setPrimitiveTeam:(Team*)value;



- (NSMutableSet*)primitiveGame;
- (void)setPrimitiveGame:(NSMutableSet*)value;



- (NSMutableSet*)primitiveGameSub;
- (void)setPrimitiveGameSub:(NSMutableSet*)value;



- (NSMutableSet*)primitiveGameAssist;
- (void)setPrimitiveGameAssist:(NSMutableSet*)value;



- (NSMutableSet*)primitiveGameStart;
- (void)setPrimitiveGameStart:(NSMutableSet*)value;



- (NSMutableSet*)primitiveEmergencyContact;
- (void)setPrimitiveEmergencyContact:(NSMutableSet*)value;


@end
