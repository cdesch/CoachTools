//
//  CoachToolsAppDelegate.h
//  CoachTools
//
//  Created by cj on 4/10/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Crittercism.h"

@interface CoachToolsAppDelegate : NSObject <UIApplicationDelegate,CrittercismDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end
