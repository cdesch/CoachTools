// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to GamePenalty.m instead.

#import "_GamePenalty.h"

@implementation GamePenaltyID
@end

@implementation _GamePenalty

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"GamePenalty" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"GamePenalty";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"GamePenalty" inManagedObjectContext:moc_];
}

- (GamePenaltyID*)objectID {
	return (GamePenaltyID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic type;






@dynamic game;

	

@dynamic player;

	





@end
