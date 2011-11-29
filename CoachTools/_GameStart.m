// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to GameStart.m instead.

#import "_GameStart.h"

@implementation GameStartID
@end

@implementation _GameStart

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"GameStart" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"GameStart";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"GameStart" inManagedObjectContext:moc_];
}

- (GameStartID*)objectID {
	return (GameStartID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"formationSlotValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"formationSlot"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic formationSlot;



- (short)formationSlotValue {
	NSNumber *result = [self formationSlot];
	return [result shortValue];
}

- (void)setFormationSlotValue:(short)value_ {
	[self setFormationSlot:[NSNumber numberWithShort:value_]];
}

- (short)primitiveFormationSlotValue {
	NSNumber *result = [self primitiveFormationSlot];
	return [result shortValue];
}

- (void)setPrimitiveFormationSlotValue:(short)value_ {
	[self setPrimitiveFormationSlot:[NSNumber numberWithShort:value_]];
}





@dynamic positionName;






@dynamic game;

	

@dynamic player;

	





@end
