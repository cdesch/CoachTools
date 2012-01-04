//
//  CoachToolsAppDelegate.h
//  CoachTools
//
//  Created by cj on 4/10/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Crittercism.h"
#import "FBConnect.h"

@interface CoachToolsAppDelegate : NSObject <UIApplicationDelegate,CrittercismDelegate,FBSessionDelegate> {

    //Facebook API
    Facebook *facebook;
    NSMutableDictionary *userPermissions;

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

//facebook API
@property (nonatomic, retain) Facebook *facebook;
@property (nonatomic, retain) NSMutableDictionary *userPermissions;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end
