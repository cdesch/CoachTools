// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Person.m instead.

#import "_Person.h"

@implementation PersonID
@end

@implementation _Person

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Person";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Person" inManagedObjectContext:moc_];
}

- (PersonID*)objectID {
	return (PersonID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"cPlayingTimeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"cPlayingTime"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"activeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"active"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"cGoalsValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"cGoals"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"phoneNumberValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"phoneNumber"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"cStartsValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"cStarts"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"cAbsencesValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"cAbsences"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic cPlayingTime;



- (double)cPlayingTimeValue {
	NSNumber *result = [self cPlayingTime];
	return [result doubleValue];
}

- (void)setCPlayingTimeValue:(double)value_ {
	[self setCPlayingTime:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveCPlayingTimeValue {
	NSNumber *result = [self primitiveCPlayingTime];
	return [result doubleValue];
}

- (void)setPrimitiveCPlayingTimeValue:(double)value_ {
	[self setPrimitiveCPlayingTime:[NSNumber numberWithDouble:value_]];
}





@dynamic active;



- (BOOL)activeValue {
	NSNumber *result = [self active];
	return [result boolValue];
}

- (void)setActiveValue:(BOOL)value_ {
	[self setActive:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveActiveValue {
	NSNumber *result = [self primitiveActive];
	return [result boolValue];
}

- (void)setPrimitiveActiveValue:(BOOL)value_ {
	[self setPrimitiveActive:[NSNumber numberWithBool:value_]];
}





@dynamic lastName;






@dynamic firstName;






@dynamic contactIdentifier;






@dynamic secondaryPosition;






@dynamic cGoals;



- (short)cGoalsValue {
	NSNumber *result = [self cGoals];
	return [result shortValue];
}

- (void)setCGoalsValue:(short)value_ {
	[self setCGoals:[NSNumber numberWithShort:value_]];
}

- (short)primitiveCGoalsValue {
	NSNumber *result = [self primitiveCGoals];
	return [result shortValue];
}

- (void)setPrimitiveCGoalsValue:(short)value_ {
	[self setPrimitiveCGoals:[NSNumber numberWithShort:value_]];
}





@dynamic phoneNumber;



- (short)phoneNumberValue {
	NSNumber *result = [self phoneNumber];
	return [result shortValue];
}

- (void)setPhoneNumberValue:(short)value_ {
	[self setPhoneNumber:[NSNumber numberWithShort:value_]];
}

- (short)primitivePhoneNumberValue {
	NSNumber *result = [self primitivePhoneNumber];
	return [result shortValue];
}

- (void)setPrimitivePhoneNumberValue:(short)value_ {
	[self setPrimitivePhoneNumber:[NSNumber numberWithShort:value_]];
}





@dynamic emergancyContact;






@dynamic email;






@dynamic cStarts;



- (short)cStartsValue {
	NSNumber *result = [self cStarts];
	return [result shortValue];
}

- (void)setCStartsValue:(short)value_ {
	[self setCStarts:[NSNumber numberWithShort:value_]];
}

- (short)primitiveCStartsValue {
	NSNumber *result = [self primitiveCStarts];
	return [result shortValue];
}

- (void)setPrimitiveCStartsValue:(short)value_ {
	[self setPrimitiveCStarts:[NSNumber numberWithShort:value_]];
}





@dynamic playerNumber;






@dynamic birthdate;






@dynamic cAbsences;



- (short)cAbsencesValue {
	NSNumber *result = [self cAbsences];
	return [result shortValue];
}

- (void)setCAbsencesValue:(short)value_ {
	[self setCAbsences:[NSNumber numberWithShort:value_]];
}

- (short)primitiveCAbsencesValue {
	NSNumber *result = [self primitiveCAbsences];
	return [result shortValue];
}

- (void)setPrimitiveCAbsencesValue:(short)value_ {
	[self setPrimitiveCAbsences:[NSNumber numberWithShort:value_]];
}





@dynamic primaryPosition;






@dynamic training;

	
- (NSMutableSet*)trainingSet {
	[self willAccessValueForKey:@"training"];
	NSMutableSet *result = [self mutableSetValueForKey:@"training"];
	[self didAccessValueForKey:@"training"];
	return result;
}
	

@dynamic team;

	

@dynamic gameScore;

	
- (NSMutableSet*)gameScoreSet {
	[self willAccessValueForKey:@"gameScore"];
	NSMutableSet *result = [self mutableSetValueForKey:@"gameScore"];
	[self didAccessValueForKey:@"gameScore"];
	return result;
}
	

@dynamic gameSub;

	
- (NSMutableSet*)gameSubSet {
	[self willAccessValueForKey:@"gameSub"];
	NSMutableSet *result = [self mutableSetValueForKey:@"gameSub"];
	[self didAccessValueForKey:@"gameSub"];
	return result;
}
	

@dynamic gameAssist;

	
- (NSMutableSet*)gameAssistSet {
	[self willAccessValueForKey:@"gameAssist"];
	NSMutableSet *result = [self mutableSetValueForKey:@"gameAssist"];
	[self didAccessValueForKey:@"gameAssist"];
	return result;
}
	

@dynamic gameStart;

	
- (NSMutableSet*)gameStartSet {
	[self willAccessValueForKey:@"gameStart"];
	NSMutableSet *result = [self mutableSetValueForKey:@"gameStart"];
	[self didAccessValueForKey:@"gameStart"];
	return result;
}
	

@dynamic gamePenalty;

	
- (NSMutableSet*)gamePenaltySet {
	[self willAccessValueForKey:@"gamePenalty"];
	NSMutableSet *result = [self mutableSetValueForKey:@"gamePenalty"];
	[self didAccessValueForKey:@"gamePenalty"];
	return result;
}
	






+ (NSArray*)fetchGetAllPlayers:(NSManagedObjectContext*)moc_ {
	NSError *error = nil;
	NSArray *result = [self fetchGetAllPlayers:moc_ error:&error];
	if (error) {
#if TARGET_OS_IPHONE
		NSLog(@"error: %@", error);
#else
		[NSApp presentError:error];
#endif
	}
	return result;
}
+ (NSArray*)fetchGetAllPlayers:(NSManagedObjectContext*)moc_ error:(NSError**)error_ {
	NSParameterAssert(moc_);
	NSError *error = nil;
	
	NSManagedObjectModel *model = [[moc_ persistentStoreCoordinator] managedObjectModel];
	
	NSDictionary *substitutionVariables = [NSDictionary dictionary];
										
	NSFetchRequest *fetchRequest = [model fetchRequestFromTemplateWithName:@"getAllPlayers"
													 substitutionVariables:substitutionVariables];
	NSAssert(fetchRequest, @"Can't find fetch request named \"getAllPlayers\".");
	
	NSArray *result = [moc_ executeFetchRequest:fetchRequest error:&error];
	if (error_) *error_ = error;
	return result;
}


@end
