// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Training.m instead.

#import "_Training.h"

@implementation TrainingID
@end

@implementation _Training

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Training" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Training";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Training" inManagedObjectContext:moc_];
}

- (TrainingID*)objectID {
	return (TrainingID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"completedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"completed"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"trainingNumberValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"trainingNumber"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic trainingDescription;






@dynamic trainingNotes;






@dynamic completed;



- (BOOL)completedValue {
	NSNumber *result = [self completed];
	return [result boolValue];
}

- (void)setCompletedValue:(BOOL)value_ {
	[self setCompleted:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveCompletedValue {
	NSNumber *result = [self primitiveCompleted];
	return [result boolValue];
}

- (void)setPrimitiveCompletedValue:(BOOL)value_ {
	[self setPrimitiveCompleted:[NSNumber numberWithBool:value_]];
}





@dynamic eventIdentifier;






@dynamic date;






@dynamic trainingNumber;



- (short)trainingNumberValue {
	NSNumber *result = [self trainingNumber];
	return [result shortValue];
}

- (void)setTrainingNumberValue:(short)value_ {
	[self setTrainingNumber:[NSNumber numberWithShort:value_]];
}

- (short)primitiveTrainingNumberValue {
	NSNumber *result = [self primitiveTrainingNumber];
	return [result shortValue];
}

- (void)setPrimitiveTrainingNumberValue:(short)value_ {
	[self setPrimitiveTrainingNumber:[NSNumber numberWithShort:value_]];
}





@dynamic trainingLocation;






@dynamic season;

	

@dynamic playersAttended;

	
- (NSMutableSet*)playersAttendedSet {
	[self willAccessValueForKey:@"playersAttended"];
	NSMutableSet *result = [self mutableSetValueForKey:@"playersAttended"];
	[self didAccessValueForKey:@"playersAttended"];
	return result;
}
	





@end
