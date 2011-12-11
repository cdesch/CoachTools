// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EventLocation.m instead.

#import "_EventLocation.h"

@implementation EventLocationID
@end

@implementation _EventLocation

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"EventLocation" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"EventLocation";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"EventLocation" inManagedObjectContext:moc_];
}

- (EventLocationID*)objectID {
	return (EventLocationID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"latitudeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"latitude"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"longitudeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"longitude"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"zipValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"zip"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic city;






@dynamic address;






@dynamic name;






@dynamic geoTag;






@dynamic state;






@dynamic latitude;



- (float)latitudeValue {
	NSNumber *result = [self latitude];
	return [result floatValue];
}

- (void)setLatitudeValue:(float)value_ {
	[self setLatitude:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveLatitudeValue {
	NSNumber *result = [self primitiveLatitude];
	return [result floatValue];
}

- (void)setPrimitiveLatitudeValue:(float)value_ {
	[self setPrimitiveLatitude:[NSNumber numberWithFloat:value_]];
}





@dynamic longitude;



- (float)longitudeValue {
	NSNumber *result = [self longitude];
	return [result floatValue];
}

- (void)setLongitudeValue:(float)value_ {
	[self setLongitude:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveLongitudeValue {
	NSNumber *result = [self primitiveLongitude];
	return [result floatValue];
}

- (void)setPrimitiveLongitudeValue:(float)value_ {
	[self setPrimitiveLongitude:[NSNumber numberWithFloat:value_]];
}





@dynamic zip;



- (short)zipValue {
	NSNumber *result = [self zip];
	return [result shortValue];
}

- (void)setZipValue:(short)value_ {
	[self setZip:[NSNumber numberWithShort:value_]];
}

- (short)primitiveZipValue {
	NSNumber *result = [self primitiveZip];
	return [result shortValue];
}

- (void)setPrimitiveZipValue:(short)value_ {
	[self setPrimitiveZip:[NSNumber numberWithShort:value_]];
}





@dynamic des;






@dynamic game;

	
- (NSMutableSet*)gameSet {
	[self willAccessValueForKey:@"game"];
	NSMutableSet *result = [self mutableSetValueForKey:@"game"];
	[self didAccessValueForKey:@"game"];
	return result;
}
	

@dynamic opponent;

	
- (NSMutableSet*)opponentSet {
	[self willAccessValueForKey:@"opponent"];
	NSMutableSet *result = [self mutableSetValueForKey:@"opponent"];
	[self didAccessValueForKey:@"opponent"];
	return result;
}
	

@dynamic team;

	
- (NSMutableSet*)teamSet {
	[self willAccessValueForKey:@"team"];
	NSMutableSet *result = [self mutableSetValueForKey:@"team"];
	[self didAccessValueForKey:@"team"];
	return result;
}
	





@end
