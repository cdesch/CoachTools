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
#import "iVersion.h"
#import "InAppRageIAPHelper.h"


static NSString* kAppId = @"328310270514873";

@implementation CoachToolsAppDelegate

@synthesize window=_window;
@synthesize managedObjectContext=__managedObjectContext;
@synthesize managedObjectModel=__managedObjectModel;
@synthesize persistentStoreCoordinator=__persistentStoreCoordinator;
@synthesize navigationController=_navigationController;

@synthesize facebook;
@synthesize userPermissions;

//Flurry Excepption Handler
void uncaughtExceptionHandler(NSException *exception) {
    [FlurryAnalytics logError:@"uncaughtExceptionHandler" message:@"Crash!" exception:exception];
    NSLog(@"uncaughtExceptionHandler");
    NSLog(@"Unresolved error %@, %@", exception, [exception debugDescription] );
    //NSLog(@"This is where we save the application data during a exception");
}

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

    //Facebook
    // Initialize Facebook
    facebook = [[Facebook alloc] initWithAppId:kAppId andDelegate:self];
    
    // Initialize user permissions
    userPermissions = [[NSMutableDictionary alloc] initWithCapacity:1];
    
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
    
    /*
    //Flurry API - Beging the Flurry session with Key
    [FlurryAnalytics startSession:@"XCHIX4BBSVNWK861PWPC"];
    
    //Check if the first run value exists
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"firstLaunch"] == nil ){
    
        //Set the First Launch to YES for Default Value 
        [[NSUserDefaults standardUserDefaults] registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],@"firstLaunch",nil]];
    }

    //Detect if it is the FIRST Launch
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){
        //Report to Flurry which iOS version this app install is. 
        [FlurryAnalytics logEvent:@"iOS V:%@",[[UIDevice currentDevice] systemVersion]];
    }else {
        //Do Nothing
    }
    
    //Set First Launch to no - 
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
     
    //Crittercism API - Begin Crittercism Session with API Key
    [Crittercism initWithAppID:@"4ec82c723f5b316f9a00004f" andKey:@"4ec82c723f5b316f9a00004flwax7sls" andSecret:@"if9cgs1z3bhu8gncwufsolmenpjeqvtq" andMainViewController:self.navigationController ];
    [Crittercism sharedInstance].delegate = self;
     
    
    //Check the current version with the version in the store. Alert the user if the current version is out of date to upgrade to the next version
    [iVersion sharedInstance].appStoreID = 455881163;
	[iVersion sharedInstance].remoteVersionsPlistURL = @"http://cjdesch.com/CoachTools/versions.plist";
	[iVersion sharedInstance].localVersionsPlistPath = @"versions.plist";
    
    */
    
    //Facebook Testing Checkes //TODO: REMOVE BEFORE RELEASE
    // Check App ID:
    // This is really a warning for the developer, this should not
    // happen in a completed app
    if (!kAppId) {
        UIAlertView *alertView = [[UIAlertView alloc] 
                                  initWithTitle:@"Setup Error" 
                                  message:@"Missing app ID. You cannot run the app until you provide this in the code." 
                                  delegate:self 
                                  cancelButtonTitle:@"OK" 
                                  otherButtonTitles:nil, 
                                  nil];
        [alertView show];
        [alertView release];
    } else {
        // Now check that the URL scheme fb[app_id]://authorize is in the .plist and can
        // be opened, doing a simple check without local app id factored in here
        NSString *url = [NSString stringWithFormat:@"fb%@://authorize",kAppId];
        BOOL bSchemeInPlist = NO; // find out if the sceme is in the plist file.
        NSArray* aBundleURLTypes = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleURLTypes"];
        if ([aBundleURLTypes isKindOfClass:[NSArray class]] && 
            ([aBundleURLTypes count] > 0)) {
            NSDictionary* aBundleURLTypes0 = [aBundleURLTypes objectAtIndex:0];
            if ([aBundleURLTypes0 isKindOfClass:[NSDictionary class]]) {
                NSArray* aBundleURLSchemes = [aBundleURLTypes0 objectForKey:@"CFBundleURLSchemes"];
                if ([aBundleURLSchemes isKindOfClass:[NSArray class]] &&
                    ([aBundleURLSchemes count] > 0)) {
                    NSString *scheme = [aBundleURLSchemes objectAtIndex:0];
                    if ([scheme isKindOfClass:[NSString class]] && 
                        [url hasPrefix:scheme]) {
                        bSchemeInPlist = YES;
                    }
                }
            }
        }
        // Check if the authorization callback will work
        BOOL bCanOpenUrl = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString: url]];
        if (!bSchemeInPlist || !bCanOpenUrl) {
            UIAlertView *alertView = [[UIAlertView alloc] 
                                      initWithTitle:@"Setup Error" 
                                      message:@"Invalid or missing URL scheme. You cannot run the app until you set up a valid URL scheme in your .plist." 
                                      delegate:self 
                                      cancelButtonTitle:@"OK" 
                                      otherButtonTitles:nil, 
                                      nil];
            [alertView show];
            [alertView release];
        }
    }

    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    


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
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    
  //  [[CCDirector sharedDirector] startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application
{

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


#pragma mark - Facebook Delegates

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [facebook handleOpenURL:url]; 
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [self.facebook handleOpenURL:url];
}

- (void)fbDidLogin {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    
}

@end
