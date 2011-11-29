// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Game.h instead.

#import <CoreData/CoreData.h>


@class GameScore;
@class GameStart;
@class GameSub;
@class GamePenalty;
@class Season;
















@interface GameID : NSManagedObjectID {}
@end

@interface _Game : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (GameID*)objectID;



@property (nonatomic, retain) NSNumber *time;

@property short timeValue;
- (short)timeValue;
- (void)setTimeValue:(short)value_;

//- (BOOL)validateTime:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *location;

//- (BOOL)validateLocation:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *gameIntervalTime;

@property short gameIntervalTimeValue;
- (short)gameIntervalTimeValue;
- (void)setGameIntervalTimeValue:(short)value_;

//- (BOOL)validateGameIntervalTime:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *eventIdentifier;

//- (BOOL)validateEventIdentifier:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *homeScore;

@property short homeScoreValue;
- (short)homeScoreValue;
- (void)setHomeScoreValue:(short)value_;

//- (BOOL)validateHomeScore:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *locationDetail;

//- (BOOL)validateLocationDetail:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *opponentScore;

@property short opponentScoreValue;
- (short)opponentScoreValue;
- (void)setOpponentScoreValue:(short)value_;

//- (BOOL)validateOpponentScore:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *opponent;

//- (BOOL)validateOpponent:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *gameInterval;

@property short gameIntervalValue;
- (short)gameIntervalValue;
- (void)setGameIntervalValue:(short)value_;

//- (BOOL)validateGameInterval:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *played;

@property BOOL playedValue;
- (BOOL)playedValue;
- (void)setPlayedValue:(BOOL)value_;

//- (BOOL)validatePlayed:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *gameNumber;

//- (BOOL)validateGameNumber:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *numPlayers;

//- (BOOL)validateNumPlayers:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *startingFormation;

//- (BOOL)validateStartingFormation:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSDate *date;

//- (BOOL)validateDate:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSSet* gameScore;
- (NSMutableSet*)gameScoreSet;



@property (nonatomic, retain) NSSet* gameStart;
- (NSMutableSet*)gameStartSet;



@property (nonatomic, retain) NSSet* gameSub;
- (NSMutableSet*)gameSubSet;



@property (nonatomic, retain) NSSet* gamePenalty;
- (NSMutableSet*)gamePenaltySet;



@property (nonatomic, retain) Season* season;
//- (BOOL)validateSeason:(id*)value_ error:(NSError**)error_;




@end

@interface _Game (CoreDataGeneratedAccessors)

- (void)addGameScore:(NSSet*)value_;
- (void)removeGameScore:(NSSet*)value_;
- (void)addGameScoreObject:(GameScore*)value_;
- (void)removeGameScoreObject:(GameScore*)value_;

- (void)addGameStart:(NSSet*)value_;
- (void)removeGameStart:(NSSet*)value_;
- (void)addGameStartObject:(GameStart*)value_;
- (void)removeGameStartObject:(GameStart*)value_;

- (void)addGameSub:(NSSet*)value_;
- (void)removeGameSub:(NSSet*)value_;
- (void)addGameSubObject:(GameSub*)value_;
- (void)removeGameSubObject:(GameSub*)value_;

- (void)addGamePenalty:(NSSet*)value_;
- (void)removeGamePenalty:(NSSet*)value_;
- (void)addGamePenaltyObject:(GamePenalty*)value_;
- (void)removeGamePenaltyObject:(GamePenalty*)value_;

@end

@interface _Game (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveTime;
- (void)setPrimitiveTime:(NSNumber*)value;

- (short)primitiveTimeValue;
- (void)setPrimitiveTimeValue:(short)value_;




- (NSString*)primitiveLocation;
- (void)setPrimitiveLocation:(NSString*)value;




- (NSNumber*)primitiveGameIntervalTime;
- (void)setPrimitiveGameIntervalTime:(NSNumber*)value;

- (short)primitiveGameIntervalTimeValue;
- (void)setPrimitiveGameIntervalTimeValue:(short)value_;




- (NSString*)primitiveEventIdentifier;
- (void)setPrimitiveEventIdentifier:(NSString*)value;




- (NSNumber*)primitiveHomeScore;
- (void)setPrimitiveHomeScore:(NSNumber*)value;

- (short)primitiveHomeScoreValue;
- (void)setPrimitiveHomeScoreValue:(short)value_;




- (NSString*)primitiveLocationDetail;
- (void)setPrimitiveLocationDetail:(NSString*)value;




- (NSNumber*)primitiveOpponentScore;
- (void)setPrimitiveOpponentScore:(NSNumber*)value;

- (short)primitiveOpponentScoreValue;
- (void)setPrimitiveOpponentScoreValue:(short)value_;




- (NSString*)primitiveOpponent;
- (void)setPrimitiveOpponent:(NSString*)value;




- (NSNumber*)primitiveGameInterval;
- (void)setPrimitiveGameInterval:(NSNumber*)value;

- (short)primitiveGameIntervalValue;
- (void)setPrimitiveGameIntervalValue:(short)value_;




- (NSNumber*)primitivePlayed;
- (void)setPrimitivePlayed:(NSNumber*)value;

- (BOOL)primitivePlayedValue;
- (void)setPrimitivePlayedValue:(BOOL)value_;




- (NSString*)primitiveGameNumber;
- (void)setPrimitiveGameNumber:(NSString*)value;




- (NSString*)primitiveNumPlayers;
- (void)setPrimitiveNumPlayers:(NSString*)value;




- (NSString*)primitiveStartingFormation;
- (void)setPrimitiveStartingFormation:(NSString*)value;




- (NSDate*)primitiveDate;
- (void)setPrimitiveDate:(NSDate*)value;





- (NSMutableSet*)primitiveGameScore;
- (void)setPrimitiveGameScore:(NSMutableSet*)value;



- (NSMutableSet*)primitiveGameStart;
- (void)setPrimitiveGameStart:(NSMutableSet*)value;



- (NSMutableSet*)primitiveGameSub;
- (void)setPrimitiveGameSub:(NSMutableSet*)value;



- (NSMutableSet*)primitiveGamePenalty;
- (void)setPrimitiveGamePenalty:(NSMutableSet*)value;



- (Season*)primitiveSeason;
- (void)setPrimitiveSeason:(Season*)value;


@end
