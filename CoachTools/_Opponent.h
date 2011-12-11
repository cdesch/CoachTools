// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Opponent.h instead.

#import <CoreData/CoreData.h>


@class EventLocation;
@class Game;





@interface OpponentID : NSManagedObjectID {}
@end

@interface _Opponent : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (OpponentID*)objectID;



@property (nonatomic, retain) NSString *contactIdentifier;

//- (BOOL)validateContactIdentifier:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *uniformColor;

//- (BOOL)validateUniformColor:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) EventLocation* homeLocation;
//- (BOOL)validateHomeLocation:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSSet* games;
- (NSMutableSet*)gamesSet;




@end

@interface _Opponent (CoreDataGeneratedAccessors)

- (void)addGames:(NSSet*)value_;
- (void)removeGames:(NSSet*)value_;
- (void)addGamesObject:(Game*)value_;
- (void)removeGamesObject:(Game*)value_;

@end

@interface _Opponent (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveContactIdentifier;
- (void)setPrimitiveContactIdentifier:(NSString*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSString*)primitiveUniformColor;
- (void)setPrimitiveUniformColor:(NSString*)value;





- (EventLocation*)primitiveHomeLocation;
- (void)setPrimitiveHomeLocation:(EventLocation*)value;



- (NSMutableSet*)primitiveGames;
- (void)setPrimitiveGames:(NSMutableSet*)value;


@end
