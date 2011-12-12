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
	
	if ([key isEqualToString:@"phoneNumberValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"phoneNumber"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"activeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"active"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"teamCaptainValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"teamCaptain"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic lastName;






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





@dynamic contactIdentifier;






@dynamic firstName;






@dynamic playerNumber;






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





@dynamic email;






@dynamic secondaryPosition;






@dynamic birthdate;






@dynamic teamCaptain;



- (BOOL)teamCaptainValue {
	NSNumber *result = [self teamCaptain];
	return [result boolValue];
}

- (void)setTeamCaptainValue:(BOOL)value_ {
	[self setTeamCaptain:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveTeamCaptainValue {
	NSNumber *result = [self primitiveTeamCaptain];
	return [result boolValue];
}

- (void)setPrimitiveTeamCaptainValue:(BOOL)value_ {
	[self setPrimitiveTeamCaptain:[NSNumber numberWithBool:value_]];
}





@dynamic primaryPosition;






@dynamic training;

	
- (NSMutableSet*)trainingSet {
	[self willAccessValueForKey:@"training"];
	NSMutableSet *result = [self mutableSetValueForKey:@"training"];
	[self didAccessValueForKey:@"training"];
	return result;
}
	

@dynamic gamePenalty;

	
- (NSMutableSet*)gamePenaltySet {
	[self willAccessValueForKey:@"gamePenalty"];
	NSMutableSet *result = [self mutableSetValueForKey:@"gamePenalty"];
	[self didAccessValueForKey:@"gamePenalty"];
	return result;
}
	

@dynamic gameScore;

	
- (NSMutableSet*)gameScoreSet {
	[self willAccessValueForKey:@"gameScore"];
	NSMutableSet *result = [self mutableSetValueForKey:@"gameScore"];
	[self didAccessValueForKey:@"gameScore"];
	return result;
}
	

@dynamic team;

	

@dynamic game;

	
- (NSMutableSet*)gameSet {
	[self willAccessValueForKey:@"game"];
	NSMutableSet *result = [self mutableSetValueForKey:@"game"];
	[self didAccessValueForKey:@"game"];
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
	

@dynamic emergencyContact;

	
- (NSMutableSet*)emergencyContactSet {
	[self willAccessValueForKey:@"emergencyContact"];
	NSMutableSet *result = [self mutableSetValueForKey:@"emergencyContact"];
	[self didAccessValueForKey:@"emergencyContact"];
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
