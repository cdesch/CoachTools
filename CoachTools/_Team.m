// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Team.m instead.

#import "_Team.h"

@implementation TeamID
@end

@implementation _Team

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Team" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Team";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Team" inManagedObjectContext:moc_];
}

- (TeamID*)objectID {
	return (TeamID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic leagueType;






@dynamic name;






@dynamic uniformColor;






@dynamic homeLocation;

	

@dynamic seasons;

	
- (NSMutableSet*)seasonsSet {
	[self willAccessValueForKey:@"seasons"];
	NSMutableSet *result = [self mutableSetValueForKey:@"seasons"];
	[self didAccessValueForKey:@"seasons"];
	return result;
}
	

@dynamic players;

	
- (NSMutableSet*)playersSet {
	[self willAccessValueForKey:@"players"];
	NSMutableSet *result = [self mutableSetValueForKey:@"players"];
	[self didAccessValueForKey:@"players"];
	return result;
}
	






+ (NSArray*)fetchGetAllTeams:(NSManagedObjectContext*)moc_ {
	NSError *error = nil;
	NSArray *result = [self fetchGetAllTeams:moc_ error:&error];
	if (error) {
#if TARGET_OS_IPHONE
		NSLog(@"error: %@", error);
#else
		[NSApp presentError:error];
#endif
	}
	return result;
}
+ (NSArray*)fetchGetAllTeams:(NSManagedObjectContext*)moc_ error:(NSError**)error_ {
	NSParameterAssert(moc_);
	NSError *error = nil;
	
	NSManagedObjectModel *model = [[moc_ persistentStoreCoordinator] managedObjectModel];
	
	NSDictionary *substitutionVariables = [NSDictionary dictionary];
										
	NSFetchRequest *fetchRequest = [model fetchRequestFromTemplateWithName:@"getAllTeams"
													 substitutionVariables:substitutionVariables];
	NSAssert(fetchRequest, @"Can't find fetch request named \"getAllTeams\".");
	
	NSArray *result = [moc_ executeFetchRequest:fetchRequest error:&error];
	if (error_) *error_ = error;
	return result;
}


@end
