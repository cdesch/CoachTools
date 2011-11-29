// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to GameSub.m instead.

#import "_GameSub.h"

@implementation GameSubID
@end

@implementation _GameSub

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"GameSub" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"GameSub";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"GameSub" inManagedObjectContext:moc_];
}

- (GameSubID*)objectID {
	return (GameSubID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"startTimeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"startTime"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"endTimeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"endTime"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic startTime;



- (double)startTimeValue {
	NSNumber *result = [self startTime];
	return [result doubleValue];
}

- (void)setStartTimeValue:(double)value_ {
	[self setStartTime:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveStartTimeValue {
	NSNumber *result = [self primitiveStartTime];
	return [result doubleValue];
}

- (void)setPrimitiveStartTimeValue:(double)value_ {
	[self setPrimitiveStartTime:[NSNumber numberWithDouble:value_]];
}





@dynamic positionName;






@dynamic endTime;



- (double)endTimeValue {
	NSNumber *result = [self endTime];
	return [result doubleValue];
}

- (void)setEndTimeValue:(double)value_ {
	[self setEndTime:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveEndTimeValue {
	NSNumber *result = [self primitiveEndTime];
	return [result doubleValue];
}

- (void)setPrimitiveEndTimeValue:(double)value_ {
	[self setPrimitiveEndTime:[NSNumber numberWithDouble:value_]];
}





@dynamic game;

	

@dynamic player;

	





@end
