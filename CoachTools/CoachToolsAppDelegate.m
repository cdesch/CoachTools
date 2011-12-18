//
//  CoachToolsAppDelegate.m
//  CoachTools
//
//  Created by cj on 4/10/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import "CoachToolsAppDelegate.h"
#import "RootViewController.h"
#import "cocos2d.h"
#import "FlurryAnalytics.h"
#import "HelpManagement.h"
#import "Crittercism.h"
#import "TestFlight.h"
#import <Foundation/Foundation.h>
#import "InAppRageIAPHelper.h"

@implementation CoachToolsAppDelegate

@synthesize window=_window;
@synthesize managedObjectContext=__managedObjectContext;
@synthesize managedObjectModel=__managedObjectModel;
@synthesize persistentStoreCoordinator=__persistentStoreCoordinator;
@synthesize navigationController=_navigationController;

//Flurr Excepption Handler
void uncaughtExceptionHandler(NSException *exception) {
    [FlurryAnalytics logError:@"uncaughtExceptionHandler" message:@"Crash!" exception:exception];
    NSLog(@"uncaughtExceptionHandler");
    NSLog(@"Unresolved error %@, %@", exception, [exception debugDescription] );
    //NSLog(@"This is where we save the application data during a exception");
}

/*
 My Apps Custom uncaught exception catcher, we do special stuff here, and TestFlight takes care of the rest
 **/
/*
void HandleExceptions(NSException *exception) {
    NSLog(@"This is where we save the application data during a exception");
    // Save application data on crash
}*/

/*
 My Apps Custom signal catcher, we do special stuff here, and TestFlight takes care of the rest
 **/
void SignalHandler(int sig) {
    NSLog(@"This is where we save the application data during a signal");
    // Save application data on crash
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    //Start In App Purchase Manager
    [[SKPaymentQueue defaultQueue] addTransactionObserver:[InAppRageIAPHelper sharedHelper]];

    
    //APIs
    

    
    //Test Flight
    // installs HandleExceptions as the Uncaught Exception Handler
    //NSSetUncaughtExceptionHandler(&HandleExceptions);
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    
    // create the signal action structure 
    struct sigaction newSignalAction;
    // initialize the signal action structure
    memset(&newSignalAction, 0, sizeof(newSignalAction));
    // set SignalHandler as the handler in the signal action structure
    newSignalAction.sa_handler = &SignalHandler;
    // set SignalHandler as the handlers for SIGABRT, SIGILL and SIGBUS
    sigaction(SIGABRT, &newSignalAction, NULL);
    sigaction(SIGILL, &newSignalAction, NULL);
    sigaction(SIGBUS, &newSignalAction, NULL);
    // Call takeOff after install your own unhandled exception and signal handlers
    //[TestFlight takeOff:@"0458201e65ba81f1484cc143b2350c36_NDI1NzcyMDExLTExLTIxIDE5OjU4OjE3LjA4Nzg5Mg"];
    //[TestFlight passCheckpoint:@"CHECKPOINT_NAME"];
    //[TestFlight openFeedbackView];

    
    //Setup Flurry
    [FlurryAnalytics startSession:@"XCHIX4BBSVNWK861PWPC"];

    NSString * version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSString * buildNo = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBuildNumber"];
    NSString * buildDate = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBuildDate"];
    NSLog(@"Application Version: %@ Build No: %@ Build Date: %@",version,buildNo,buildDate);

    version = nil;
    buildNo = nil;
    buildDate = nil;

    if( ! [CCDirector setDirectorType:kCCDirectorTypeDisplayLink] )
		[CCDirector setDirectorType:kCCDirectorTypeThreadMainLoop];
    
	CCDirector *director = [CCDirector sharedDirector];
    [director setAnimationInterval:1.0/60];
	[director setDisplayFPS:YES];

    /*
    // NOT NEEDED FOR IPAD
    // Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
	if( ! [director enableRetinaDisplay:YES] )
		CCLOG(@"Retina Display Not supported");
    */
    
    // Override point for customization after application launch.
    // Add the split view controller's view to the window and display.
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    
    //Crittercism API
    [Crittercism initWithAppID:@"4ec82c723f5b316f9a00004f" andKey:@"4ec82c723f5b316f9a00004flwax7sls" andSecret:@"if9cgs1z3bhu8gncwufsolmenpjeqvtq" andMainViewController:self.navigationController ];
    [Crittercism sharedInstance].delegate = self;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    
    //NSLog(@" %s", __PRETTY_FUNCTION__);

    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
    
   	if([RootViewController sharedAppController].gameTimer != nil){
    
        //NSLog(@"Suspend");
        [[RootViewController sharedAppController].gameTimer appWillSuspend];
    }
    
  	//[[CCDirector sharedDirector] stopAnimation];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    //NSLog(@" %s", __PRETTY_FUNCTION__);
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
    

    //[self saveContext];

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    //NSLog(@" %s", __PRETTY_FUNCTION__);
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
    
   	if([RootViewController sharedAppController].gameTimer != nil){
    
         //NSLog(@"Resume");
        [[RootViewController sharedAppController].gameTimer appWillResume];
    }    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    //NSLog(@" %s", __PRETTY_FUNCTION__);
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    
  //  [[CCDirector sharedDirector] startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    //NSLog(@" %s", __PRETTY_FUNCTION__);
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
    //
    //Coocos2d
    [[CCDirector sharedDirector] end];

}

// purge memroy
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    [[CCDirector sharedDirector] purgeCachedData];
}

- (void)dealloc
{
    [_window release];
    [__managedObjectContext release];
    [__managedObjectModel release];
    [__persistentStoreCoordinator release];
    [_navigationController release];

    
    [super dealloc];
}

- (void)awakeFromNib
{
    // Pass the managed object context to the root view controller.
    //self.rootViewController.managedObjectContext = self.managedObjectContext; 
    RootViewController *rootViewController = (RootViewController *)[self.navigationController topViewController];
    rootViewController.managedObjectContext = self.managedObjectContext;
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            
            NSException *exception = [NSException exceptionWithName: @"Context Save Failed"   
                                                             reason: @"Bad Programming" userInfo: nil];  
            uncaughtExceptionHandler(exception);
            
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    
    
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoachTools" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CoachTools.sqlite"];
    
    //Lightweight Migration
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,nil];
                             //[NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];

    //
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error])
    {
        

        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        NSException *exception = [NSException exceptionWithName: @"Migration Failed"   
                                                         reason: @"Default Migration failed - Attempting to recover by removing Data Store " userInfo: nil]; 
        
        [FlurryAnalytics logError:[NSString stringWithFormat:@"Unresolved Error CoreData %s", __PRETTY_FUNCTION__] message:@"CoreData" error:error];
        uncaughtExceptionHandler(exception);

        //TODO: Throw Warning about migration failure. 
        /*
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"UIAlertView" message:@"<Alert message>" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        [alert show];
        [alert release];
        */
        
        //Attempting to recover from error as last resort of failed migration
        
        // Delete file
        if ([[NSFileManager defaultManager] fileExistsAtPath:storeURL.path]) {
            if (![[NSFileManager defaultManager] removeItemAtPath:storeURL.path error:&error]) {
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                NSException *exception = [NSException exceptionWithName: @"Migration Failed"   
                                                                 reason: @"Removing the DataStore Failed" userInfo: nil];  
                uncaughtExceptionHandler(exception);
                
                [HelpManagement errorMessage:@"Data Store Delete" error:@"criticalError"];
                abort();
            } 
        }
        
        if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) 
        {
            // Handle the error.
            NSLog(@"Error: %@",error);
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);

            NSException *exception = [NSException exceptionWithName: @"Migration Failed"   
                                                             reason: @"Creating a new DataStore Failed" userInfo: nil];  
            uncaughtExceptionHandler(exception);
            [HelpManagement errorMessage:@"Data Store Create" error:@"criticalError"];

            abort();
            
        }
        

        //abort();
    }    
    
    return __persistentStoreCoordinator;
}

/*
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // the user clicked one of the OK/Cancel buttons
    if (buttonIndex == 0)
    {
        NSLog(@"ok");
    }
    else
    {
        NSLog(@"cancel");
    }
}
*/


// Implement the protocol
#pragma mark CrittercismDelegate
-(void)crittercismDidCrashOnLastLoad {
    
    NSLog(@"App crashed the last time it was loaded");
    
    [FlurryAnalytics logEvent:@"Crittercism: App crashed the last time it was loaded"];
}

-(void)crittercismDidClose{
    //Do Nothing
}



#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
