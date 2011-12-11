// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Game.m instead.

#import "_Game.h"

@implementation GameID
@end

@implementation _Game

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Game" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Game";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Game" inManagedObjectContext:moc_];
}

- (GameID*)objectID {
	return (GameID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"timeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"time"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"gameIntervalTimeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"gameIntervalTime"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"opponentScoreValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"opponentScore"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"homeScoreValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"homeScore"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"gameIntervalValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"gameInterval"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"playedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"played"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic location;






@dynamic time;



- (short)timeValue {
	NSNumber *result = [self time];
	return [result shortValue];
}

- (void)setTimeValue:(short)value_ {
	[self setTime:[NSNumber numberWithShort:value_]];
}

- (short)primitiveTimeValue {
	NSNumber *result = [self primitiveTime];
	return [result shortValue];
}

- (void)setPrimitiveTimeValue:(short)value_ {
	[self setPrimitiveTime:[NSNumber numberWithShort:value_]];
}





@dynamic opponent;






@dynamic gameIntervalTime;



- (short)gameIntervalTimeValue {
	NSNumber *result = [self gameIntervalTime];
	return [result shortValue];
}

- (void)setGameIntervalTimeValue:(short)value_ {
	[self setGameIntervalTime:[NSNumber numberWithShort:value_]];
}

- (short)primitiveGameIntervalTimeValue {
	NSNumber *result = [self primitiveGameIntervalTime];
	return [result shortValue];
}

- (void)setPrimitiveGameIntervalTimeValue:(short)value_ {
	[self setPrimitiveGameIntervalTime:[NSNumber numberWithShort:value_]];
}





@dynamic eventIdentifier;






@dynamic locationDetail;






@dynamic opponentScore;



- (short)opponentScoreValue {
	NSNumber *result = [self opponentScore];
	return [result shortValue];
}

- (void)setOpponentScoreValue:(short)value_ {
	[self setOpponentScore:[NSNumber numberWithShort:value_]];
}

- (short)primitiveOpponentScoreValue {
	NSNumber *result = [self primitiveOpponentScore];
	return [result shortValue];
}

- (void)setPrimitiveOpponentScoreValue:(short)value_ {
	[self setPrimitiveOpponentScore:[NSNumber numberWithShort:value_]];
}





@dynamic startingFormation;






@dynamic homeScore;



- (short)homeScoreValue {
	NSNumber *result = [self homeScore];
	return [result shortValue];
}

- (void)setHomeScoreValue:(short)value_ {
	[self setHomeScore:[NSNumber numberWithShort:value_]];
}

- (short)primitiveHomeScoreValue {
	NSNumber *result = [self primitiveHomeScore];
	return [result shortValue];
}

- (void)setPrimitiveHomeScoreValue:(short)value_ {
	[self setPrimitiveHomeScore:[NSNumber numberWithShort:value_]];
}





@dynamic gameInterval;



- (short)gameIntervalValue {
	NSNumber *result = [self gameInterval];
	return [result shortValue];
}

- (void)setGameIntervalValue:(short)value_ {
	[self setGameInterval:[NSNumber numberWithShort:value_]];
}

- (short)primitiveGameIntervalValue {
	NSNumber *result = [self primitiveGameInterval];
	return [result shortValue];
}

- (void)setPrimitiveGameIntervalValue:(short)value_ {
	[self setPrimitiveGameInterval:[NSNumber numberWithShort:value_]];
}





@dynamic played;



- (BOOL)playedValue {
	NSNumber *result = [self played];
	return [result boolValue];
}

- (void)setPlayedValue:(BOOL)value_ {
	[self setPlayed:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitivePlayedValue {
	NSNumber *result = [self primitivePlayed];
	return [result boolValue];
}

- (void)setPrimitivePlayedValue:(BOOL)value_ {
	[self setPrimitivePlayed:[NSNumber numberWithBool:value_]];
}





@dynamic numPlayers;






@dynamic gameNumber;






@dynamic date;






@dynamic gameScore;

	
- (NSMutableSet*)gameScoreSet {
	[self willAccessValueForKey:@"gameScore"];
	NSMutableSet *result = [self mutableSetValueForKey:@"gameScore"];
	[self didAccessValueForKey:@"gameScore"];
	return result;
}
	

@dynamic gameLocation;

	

@dynamic playersAttended;

	
- (NSMutableSet*)playersAttendedSet {
	[self willAccessValueForKey:@"playersAttended"];
	NSMutableSet *result = [self mutableSetValueForKey:@"playersAttended"];
	[self didAccessValueForKey:@"playersAttended"];
	return result;
}
	

@dynamic gameOpponent;

	

@dynamic gameSub;

	
- (NSMutableSet*)gameSubSet {
	[self willAccessValueForKey:@"gameSub"];
	NSMutableSet *result = [self mutableSetValueForKey:@"gameSub"];
	[self didAccessValueForKey:@"gameSub"];
	return result;
}
	

@dynamic season;

	

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
	





@end
