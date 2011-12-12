// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EmergencyContact.m instead.

#import "_EmergencyContact.h"

@implementation EmergencyContactID
@end

@implementation _EmergencyContact

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"EmergencyContact" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"EmergencyContact";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"EmergencyContact" inManagedObjectContext:moc_];
}

- (EmergencyContactID*)objectID {
	return (EmergencyContactID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"primaryValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"primary"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic contactIdentifier;






@dynamic relation;






@dynamic primary;



- (BOOL)primaryValue {
	NSNumber *result = [self primary];
	return [result boolValue];
}

- (void)setPrimaryValue:(BOOL)value_ {
	[self setPrimary:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitivePrimaryValue {
	NSNumber *result = [self primitivePrimary];
	return [result boolValue];
}

- (void)setPrimitivePrimaryValue:(BOOL)value_ {
	[self setPrimitivePrimary:[NSNumber numberWithBool:value_]];
}





@dynamic player;

	





@end
