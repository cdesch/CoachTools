// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EventLocation.h instead.

#import <CoreData/CoreData.h>


@class Game;
@class Opponent;
@class Team;











@interface EventLocationID : NSManagedObjectID {}
@end

@interface _EventLocation : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (EventLocationID*)objectID;



@property (nonatomic, retain) NSString *city;

//- (BOOL)validateCity:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *address;

//- (BOOL)validateAddress:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *geoTag;

//- (BOOL)validateGeoTag:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *state;

//- (BOOL)validateState:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *latitude;

@property float latitudeValue;
- (float)latitudeValue;
- (void)setLatitudeValue:(float)value_;

//- (BOOL)validateLatitude:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *longitude;

@property float longitudeValue;
- (float)longitudeValue;
- (void)setLongitudeValue:(float)value_;

//- (BOOL)validateLongitude:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *zip;

@property short zipValue;
- (short)zipValue;
- (void)setZipValue:(short)value_;

//- (BOOL)validateZip:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *des;

//- (BOOL)validateDes:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSSet* game;
- (NSMutableSet*)gameSet;



@property (nonatomic, retain) NSSet* opponent;
- (NSMutableSet*)opponentSet;



@property (nonatomic, retain) NSSet* team;
- (NSMutableSet*)teamSet;




@end

@interface _EventLocation (CoreDataGeneratedAccessors)

- (void)addGame:(NSSet*)value_;
- (void)removeGame:(NSSet*)value_;
- (void)addGameObject:(Game*)value_;
- (void)removeGameObject:(Game*)value_;

- (void)addOpponent:(NSSet*)value_;
- (void)removeOpponent:(NSSet*)value_;
- (void)addOpponentObject:(Opponent*)value_;
- (void)removeOpponentObject:(Opponent*)value_;

- (void)addTeam:(NSSet*)value_;
- (void)removeTeam:(NSSet*)value_;
- (void)addTeamObject:(Team*)value_;
- (void)removeTeamObject:(Team*)value_;

@end

@interface _EventLocation (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveCity;
- (void)setPrimitiveCity:(NSString*)value;




- (NSString*)primitiveAddress;
- (void)setPrimitiveAddress:(NSString*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSString*)primitiveGeoTag;
- (void)setPrimitiveGeoTag:(NSString*)value;




- (NSString*)primitiveState;
- (void)setPrimitiveState:(NSString*)value;




- (NSNumber*)primitiveLatitude;
- (void)setPrimitiveLatitude:(NSNumber*)value;

- (float)primitiveLatitudeValue;
- (void)setPrimitiveLatitudeValue:(float)value_;




- (NSNumber*)primitiveLongitude;
- (void)setPrimitiveLongitude:(NSNumber*)value;

- (float)primitiveLongitudeValue;
- (void)setPrimitiveLongitudeValue:(float)value_;




- (NSNumber*)primitiveZip;
- (void)setPrimitiveZip:(NSNumber*)value;

- (short)primitiveZipValue;
- (void)setPrimitiveZipValue:(short)value_;




- (NSString*)primitiveDes;
- (void)setPrimitiveDes:(NSString*)value;





- (NSMutableSet*)primitiveGame;
- (void)setPrimitiveGame:(NSMutableSet*)value;



- (NSMutableSet*)primitiveOpponent;
- (void)setPrimitiveOpponent:(NSMutableSet*)value;



- (NSMutableSet*)primitiveTeam;
- (void)setPrimitiveTeam:(NSMutableSet*)value;


@end
