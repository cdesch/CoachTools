// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EmergencyContact.h instead.

#import <CoreData/CoreData.h>


@class Person;





@interface EmergencyContactID : NSManagedObjectID {}
@end

@interface _EmergencyContact : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (EmergencyContactID*)objectID;



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

@interface _EmergencyContact (CoreDataGeneratedAccessors)

@end

@interface _EmergencyContact (CoreDataGeneratedPrimitiveAccessors)


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
