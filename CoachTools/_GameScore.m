// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to GameScore.m instead.

#import "_GameScore.h"

@implementation GameScoreID
@end

@implementation _GameScore

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"GameScore" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"GameScore";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"GameScore" inManagedObjectContext:moc_];
}

- (GameScoreID*)objectID {
	return (GameScoreID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"timeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"time"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic scoringPosition;






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





@dynamic game;

	

@dynamic assistingPlayer;

	

@dynamic player;

	





@end
