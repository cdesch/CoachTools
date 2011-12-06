// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EmergancyContact.h instead.

#import <CoreData/CoreData.h>


@class Person;





@interface EmergancyContactID : NSManagedObjectID {}
@end

@interface _EmergancyContact : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (EmergancyContactID*)objectID;



@property (nonatomic, retain) NSString *contactIdentifier;

//- (BOOL)validateContactIdentifier:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *relation;

//- (BOOL)validateRelation:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *primary;

@property BOOL primaryValue;
- (BOOL)primaryValue;
- (void)setPrimaryValue:(BOOL)value_;

//- (BOOL)validatePrimary:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) Person* player;
//- (BOOL)validatePlayer:(id*)value_ error:(NSError**)error_;




@end

@interface _EmergancyContact (CoreDataGeneratedAccessors)

@end

@interface _EmergancyContact (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveContactIdentifier;
- (void)setPrimitiveContactIdentifier:(NSString*)value;




- (NSString*)primitiveRelation;
- (void)setPrimitiveRelation:(NSString*)value;




- (NSNumber*)primitivePrimary;
- (void)setPrimitivePrimary:(NSNumber*)value;

- (BOOL)primitivePrimaryValue;
- (void)setPrimitivePrimaryValue:(BOOL)value_;





- (Person*)primitivePlayer;
- (void)setPrimitivePlayer:(Person*)value;


@end
