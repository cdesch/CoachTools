// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Team.h instead.

#import <CoreData/CoreData.h>


@class Season;
@class Person;








@interface TeamID : NSManagedObjectID {}
@end

@interface _Team : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (TeamID*)objectID;



@property (nonatomic, retain) NSString *homeLocation;

//- (BOOL)validateHomeLocation:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *cWins;

@property short cWinsValue;
- (short)cWinsValue;
- (void)setCWinsValue:(short)value_;

//- (BOOL)validateCWins:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *leagueType;

//- (BOOL)validateLeagueType:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *uniformColor;

//- (BOOL)validateUniformColor:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *cLosses;

@property short cLossesValue;
- (short)cLossesValue;
- (void)setCLossesValue:(short)value_;

//- (BOOL)validateCLosses:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSSet* seasons;
- (NSMutableSet*)seasonsSet;



@property (nonatomic, retain) NSSet* players;
- (NSMutableSet*)playersSet;




+ (NSArray*)fetchGetAllTeams:(NSManagedObjectContext*)moc_ ;
+ (NSArray*)fetchGetAllTeams:(NSManagedObjectContext*)moc_ error:(NSError**)error_;



@end

@interface _Team (CoreDataGeneratedAccessors)

- (void)addSeasons:(NSSet*)value_;
- (void)removeSeasons:(NSSet*)value_;
- (void)addSeasonsObject:(Season*)value_;
- (void)removeSeasonsObject:(Season*)value_;

- (void)addPlayers:(NSSet*)value_;
- (void)removePlayers:(NSSet*)value_;
- (void)addPlayersObject:(Person*)value_;
- (void)removePlayersObject:(Person*)value_;

@end

@interface _Team (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveHomeLocation;
- (void)setPrimitiveHomeLocation:(NSString*)value;




- (NSNumber*)primitiveCWins;
- (void)setPrimitiveCWins:(NSNumber*)value;

- (short)primitiveCWinsValue;
- (void)setPrimitiveCWinsValue:(short)value_;




- (NSString*)primitiveLeagueType;
- (void)setPrimitiveLeagueType:(NSString*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSString*)primitiveUniformColor;
- (void)setPrimitiveUniformColor:(NSString*)value;




- (NSNumber*)primitiveCLosses;
- (void)setPrimitiveCLosses:(NSNumber*)value;

- (short)primitiveCLossesValue;
- (void)setPrimitiveCLossesValue:(short)value_;





- (NSMutableSet*)primitiveSeasons;
- (void)setPrimitiveSeasons:(NSMutableSet*)value;



- (NSMutableSet*)primitivePlayers;
- (void)setPrimitivePlayers:(NSMutableSet*)value;


@end
