// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Season.m instead.

#import "_Season.h"

@implementation SeasonID
@end

@implementation _Season

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Season" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Season";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Season" inManagedObjectContext:moc_];
}

- (SeasonID*)objectID {
	return (SeasonID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"endedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"ended"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic name;






@dynamic startDate;






@dynamic ended;



- (BOOL)endedValue {
	NSNumber *result = [self ended];
	return [result boolValue];
}

- (void)setEndedValue:(BOOL)value_ {
	[self setEnded:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveEndedValue {
	NSNumber *result = [self primitiveEnded];
	return [result boolValue];
}

- (void)setPrimitiveEndedValue:(BOOL)value_ {
	[self setPrimitiveEnded:[NSNumber numberWithBool:value_]];
}





@dynamic endDate;






@dynamic league;






@dynamic games;

	
- (NSMutableSet*)gamesSet {
	[self willAccessValueForKey:@"games"];
	NSMutableSet *result = [self mutableSetValueForKey:@"games"];
	[self didAccessValueForKey:@"games"];
	return result;
}
	

@dynamic team;

	

@dynamic training;

	
- (NSMutableSet*)trainingSet {
	[self willAccessValueForKey:@"training"];
	NSMutableSet *result = [self mutableSetValueForKey:@"training"];
	[self didAccessValueForKey:@"training"];
	return result;
}
	





@end
