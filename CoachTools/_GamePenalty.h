// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to GamePenalty.h instead.

#import <CoreData/CoreData.h>


@class Game;
@class Person;



@interface GamePenaltyID : NSManagedObjectID {}
@end

@interface _GamePenalty : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (GamePenaltyID*)objectID;



@property (nonatomic, retain) NSString *type;

//- (BOOL)validateType:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) Game* game;
//- (BOOL)validateGame:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) Person* player;
//- (BOOL)validatePlayer:(id*)value_ error:(NSError**)error_;




@end

@interface _GamePenalty (CoreDataGeneratedAccessors)

@end

@interface _GamePenalty (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveType;
- (void)setPrimitiveType:(NSString*)value;





- (Game*)primitiveGame;
- (void)setPrimitiveGame:(Game*)value;



- (Person*)primitivePlayer;
- (void)setPrimitivePlayer:(Person*)value;


@end
