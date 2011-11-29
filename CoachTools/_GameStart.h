// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to GameStart.h instead.

#import <CoreData/CoreData.h>


@class Game;
@class Person;




@interface GameStartID : NSManagedObjectID {}
@end

@interface _GameStart : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (GameStartID*)objectID;



@property (nonatomic, retain) NSNumber *formationSlot;

@property short formationSlotValue;
- (short)formationSlotValue;
- (void)setFormationSlotValue:(short)value_;

//- (BOOL)validateFormationSlot:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *positionName;

//- (BOOL)validatePositionName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) Game* game;
//- (BOOL)validateGame:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) Person* player;
//- (BOOL)validatePlayer:(id*)value_ error:(NSError**)error_;




@end

@interface _GameStart (CoreDataGeneratedAccessors)

@end

@interface _GameStart (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveFormationSlot;
- (void)setPrimitiveFormationSlot:(NSNumber*)value;

- (short)primitiveFormationSlotValue;
- (void)setPrimitiveFormationSlotValue:(short)value_;




- (NSString*)primitivePositionName;
- (void)setPrimitivePositionName:(NSString*)value;





- (Game*)primitiveGame;
- (void)setPrimitiveGame:(Game*)value;



- (Person*)primitivePlayer;
- (void)setPrimitivePlayer:(Person*)value;


@end
