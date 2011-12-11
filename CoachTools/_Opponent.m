// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Opponent.m instead.

#import "_Opponent.h"

@implementation OpponentID
@end

@implementation _Opponent

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Opponent" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Opponent";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Opponent" inManagedObjectContext:moc_];
}

- (OpponentID*)objectID {
	return (OpponentID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic contactIdentifier;






@dynamic name;






@dynamic uniformColor;






@dynamic homeLocation;

	

@dynamic games;

	
- (NSMutableSet*)gamesSet {
	[self willAccessValueForKey:@"games"];
	NSMutableSet *result = [self mutableSetValueForKey:@"games"];
	[self didAccessValueForKey:@"games"];
	return result;
}
	





@end
