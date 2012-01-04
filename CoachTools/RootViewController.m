//
//  RootViewController.m
//  CoachTools
//
//  Created by cj on 4/10/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import "RootViewController.h"

#import "CoachToolsAppDelegate.h"

#import "GameManagementViewController.h"
#import "ChalkTalkViewController.h"
#import "TeamListViewController.h"
#import "Person.h"
#import "GameTimerDisplay.h"
#import "GameTimerButton.h"
#import "PlistStringUtil.h"

#import "IAPManagerViewController.h"

#import <EventKitUI/EventKitUI.h>

#import "ShowcaseModel.h"
#import "ShowcaseFormDataSource.h"
#import "ShowcaseController.h"

#import "Crittercism.h"
#import "FlurryAnalytics.h"
#import "TestFlight.h"

#import "FBConnect.h"
#import "APICallsViewController.h"


static RootViewController *sharedInstance;

@implementation RootViewController
		
@synthesize permissions;
@synthesize nameLabel;
@synthesize profilePhotoImageView;
@synthesize fetchedResultsController;
@synthesize managedObjectContext;

@synthesize gameTimer;
@synthesize gameManagementViewController;

@synthesize background;
@synthesize titleLabel;

// Shared Instance - enables the MOC (Managed Object Context) to be passed by reference to viewControllers
+ (RootViewController *)sharedAppController {	
    return sharedInstance;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //NSLog(@"ViewController: %@", nibNameOrNil);
    }
    return self;
}

- (void)dealloc
{
    [permissions release];
    [fetchedResultsController release];
    [managedObjectContext release];
    [gameTimer release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    gameTimer = [[GameTimer alloc] init];
    //gameManagementViewController = [[GameManagementViewController alloc] initWithNibName:@"GameManagementViewController" bundle:nil];
    sharedInstance = self;
    
    NSError *error = nil;
    if (![[self fetchedResultsController] performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        [FlurryAnalytics logError:@"Unresolved Error Fetching" message:@"RootViewController FetchedResultsController" error:error];
        abort();
    }
    
    self.title = @"CoachTools";    
    
    // Initialize permissions
    permissions = [[NSArray alloc] initWithObjects:@"offline_access", nil];
    
    //CoachToolsAppDelegate *delegate = (CoachToolsAppDelegate *)[[UIApplication sharedApplication] delegate];

    // Login Button
    //loginButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    //CGFloat xLoginButtonOffset = self.view.center.x - (318/2);
    //CGFloat yLoginButtonOffset = self.view.bounds.size.height - (58 + 13);
    //loginButton.frame = CGRectMake(xLoginButtonOffset,yLoginButtonOffset,318,58);
    [loginButton addTarget:self
                    action:@selector(login)
          forControlEvents:UIControlEventTouchUpInside];
    [loginButton setImage:
     [UIImage imageNamed:@"FBConnect.bundle/images/LoginWithFacebookNormal.png"]
                 forState:UIControlStateNormal];
    [loginButton setImage:
     [UIImage imageNamed:@"FBConnect.bundle/images/LoginWithFacebookPressed.png"]
                 forState:UIControlStateHighlighted];
    [loginButton sizeToFit];
    //[self.view addSubview:loginButton];
    
    pendingApiCallsController = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    //[self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    
    CoachToolsAppDelegate *delegate = (CoachToolsAppDelegate *)[[UIApplication sharedApplication] delegate];
    // Check and retrieve authorization information
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"]
        && [defaults objectForKey:@"FBExpirationDateKey"]) {
        [delegate facebook].accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        [delegate facebook].expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }
    if (![[delegate facebook] isSessionValid]) {
        [self showLoggedOut];
    } else {
        [self showLoggedIn];
    }
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    /*
 	if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
	   interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        
        background.image = [UIImage imageNamed: @"Grid.png"];    
        titleLabel.textColor = [UIColor blackColor];
        
    }else{
        background.image = [UIImage imageNamed: @"GridV.png"];   
        titleLabel.textColor = [UIColor whiteColor];
    }*/
    
    
    // Return YES for supported orientations
	return YES;
}

#pragma mark
#pragma mark - Actions

- (IBAction)pushThis:(id)sender{
    
    TeamListViewController *pushTable = [[TeamListViewController alloc] init];
    [self.navigationController pushViewController:pushTable animated:YES];
    [pushTable release];
        
}

- (IBAction)notAvailable:(id)sender{
    
    NSMutableArray *msgParams = [[[NSMutableArray alloc] init] autorelease];
    [msgParams addObject:@"Season Name"];
    
    UIAlertView *someError = [[UIAlertView alloc] initWithTitle:[PlistStringUtil retrieveErrorText:@"comingSoon.title" withParams:msgParams] message:[PlistStringUtil retrieveErrorText:@"comingSoon.msg" withParams:msgParams] delegate: self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    [someError show];
    [someError release];
    
}


- (IBAction)chalkTalk:(id)sender{
    ChalkTalkViewController *cocoGameViewController = [[ChalkTalkViewController alloc] initWithNibName:@"ChalkTalkViewController" bundle:nil];

    cocoGameViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentModalViewController:cocoGameViewController animated:YES];
    [cocoGameViewController release];
}


- (IBAction)IAPManagerButton:(id)sender{
    IAPManagerViewController *addController = [[IAPManagerViewController alloc] init];
    addController.delegate = self;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:addController];
    navigationController.modalPresentationStyle = UIModalPresentationFullScreen;
    navigationController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentModalViewController:navigationController animated:YES];
    
    [navigationController release];
    [addController release];
    
}

- (void)doneInAppPurchases:(IAPManagerViewController *)doneInAppPurchases{
    [self dismissModalViewControllerAnimated:YES];
}


- (void)eventEditViewController:(EKEventEditViewController *)controller didCompleteWithAction:(EKEventEditViewAction)action {
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - Crittercism

- (IBAction)crittercismPressed:(id)sender {
    
    [Crittercism showCrittercism];
}

#pragma mark - AboutViewController

- (IBAction)infoButton:(id)sender{
    AboutViewController *addController = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
    addController.delegate = self;
	
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:addController];
    navigationController.modalPresentationStyle = UIModalPresentationFullScreen;
    navigationController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentModalViewController:navigationController animated:YES];
    
    [navigationController release];
    [addController release];
    
}

- (void)returnView:(AboutViewController *)viewController{
    
    [self dismissModalViewControllerAnimated:YES];
}




#pragma mark
#pragma mark - Data Management

//Get the instance of all the objects
- (NSArray *)allInstancesOf:(NSString *)entityName orderedBy:(NSString *)attName
{
    
    NSManagedObjectContext *moc = [fetchedResultsController managedObjectContext];
    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:moc];
    [fetch setEntity:entity];
    
    if (attName) {
        NSSortDescriptor *sd = [[NSSortDescriptor alloc] initWithKey:attName ascending:YES];
        
        NSArray *sortDescriptors = [NSArray arrayWithObject:sd];
        [sd release];
        
        [fetch setSortDescriptors:sortDescriptors];
    }
    
    NSError *error;
    NSArray *result = [moc executeFetchRequest:fetch
                                         error:&error];
    [fetch release];
    
    if (!result) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Fetch Failed" message:[error localizedDescription]  delegate:nil cancelButtonTitle:@"OK"   otherButtonTitles:nil];
        
        [alertView autorelease];
        [alertView show];
        return nil;
    }
    return result;
    
}


//Get the instance of all the objects
- (NSArray *)allInstancesOf:(NSString *)entityName orderedBy:(NSString *)attName parentEntity:(NSString *)parentName
{
    
    NSManagedObjectContext *moc = [fetchedResultsController managedObjectContext];
    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:moc];
    [fetch setEntity:entity];
    
    if (attName) {
        NSSortDescriptor *sd = [[NSSortDescriptor alloc] initWithKey:attName ascending:YES];
        
        NSArray *sortDescriptors = [NSArray arrayWithObject:sd];
        [sd release];
        
        [fetch setSortDescriptors:sortDescriptors];
    }
    
    NSError *error;
    NSArray *result = [moc executeFetchRequest:fetch
                                         error:&error];
    [fetch release];
    
    if (!result) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Fetch Failed" message:[error localizedDescription]  delegate:nil cancelButtonTitle:@"OK"   otherButtonTitles:nil];
        
        [alertView autorelease];
        [alertView show];
        return nil;
    }
    return result;
    
}

//Get the instance of all the objects
- (NSArray *)numberOfItemTeam:(NSString *)entityName attribute:(NSString *)attribute parentEntity:(NSString *)parentName
{
    
    NSManagedObjectContext *moc = [fetchedResultsController managedObjectContext];
    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:moc];
    [fetch setEntity:entity];
    
    if (attribute) {
        NSSortDescriptor *sd = [[NSSortDescriptor alloc] initWithKey:attribute ascending:YES];
        
        NSArray *sortDescriptors = [NSArray arrayWithObject:sd];
        [sd release];
        
        [fetch setSortDescriptors:sortDescriptors];
    }
    
    NSError *error;
    NSArray *result = [moc executeFetchRequest:fetch
                                         error:&error];
    [fetch release];
    
    if (!result) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Fetch Failed" message:[error localizedDescription]  delegate:nil cancelButtonTitle:@"OK"   otherButtonTitles:nil];
        
        [alertView autorelease];
        [alertView show];
        return nil;
    }
    
    return result;
    
}

- (IBAction)testButton:(id)sender{

    
}

- (IBAction)launchFeedback:(id)sender{
    
       [TestFlight openFeedbackView];
}


- (IBAction)shareKitButton:(id)sender{
    
}
 
 
#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
    
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    
    NSEntityDescription *entity = [Person entityInManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    [aFetchedResultsController release];
    [fetchRequest release];
    [sortDescriptor release];
    [sortDescriptors release];
    
    return fetchedResultsController;
}    

#pragma mark - Facebook API Calls
/**
 * Make a Graph API Call to get information about the current logged in user.
 */
- (void)apiFQLIMe {
    // Using the "pic" picture since this currently has a maximum width of 100 pixels
    // and since the minimum profile picture size is 180 pixels wide we should be able
    // to get a 100 pixel wide version of the profile picture
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"SELECT uid, name, pic FROM user WHERE uid=me()", @"query",
                                   nil];
    CoachToolsAppDelegate *delegate = (CoachToolsAppDelegate *)[[UIApplication sharedApplication] delegate];
    [[delegate facebook] requestWithMethodName:@"fql.query"
                                     andParams:params
                                 andHttpMethod:@"POST"
                                   andDelegate:self];
}

- (void)apiGraphUserPermissions {
    CoachToolsAppDelegate *delegate = (CoachToolsAppDelegate *)[[UIApplication sharedApplication] delegate];
    [[delegate facebook] requestWithGraphPath:@"me/permissions" andDelegate:self];
}


#pragma - Private Helper Methods

/**
 * Show the logged in menu
 */

- (void)showLoggedIn {
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    

    loginButton.hidden = YES;
    
    [self apiFQLIMe];
}

/**
 * Show the logged in menu
 */

- (void)showLoggedOut {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    loginButton.hidden = NO;
    
    // Clear personal info
    nameLabel.text = @"";
    // Get the profile image
    [profilePhotoImageView setImage:nil];
    
    [[self navigationController] popToRootViewControllerAnimated:YES];
}

/**
 * Show the authorization dialog.
 */
- (void)login {
    CoachToolsAppDelegate *delegate = (CoachToolsAppDelegate *)[[UIApplication sharedApplication] delegate];
    if (![[delegate facebook] isSessionValid]) {
        [[delegate facebook] authorize:permissions];
    } else {
        [self showLoggedIn];
    }
}

/**
 * Invalidate the access token and clear the cookie.
 */
- (void)logout {
    CoachToolsAppDelegate *delegate = (CoachToolsAppDelegate *)[[UIApplication sharedApplication] delegate];
    [[delegate facebook] logout];
}

#pragma mark - FBSessionDelegate Methods
/**
 * Called when the user has logged in successfully.
 */
- (void)fbDidLogin {
    [self showLoggedIn];
    
    CoachToolsAppDelegate *delegate = (CoachToolsAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // Save authorization information
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[[delegate facebook] accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[[delegate facebook] expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    
    [pendingApiCallsController userDidGrantPermission];
}

/**
 * Called when the user canceled the authorization dialog.
 */
-(void)fbDidNotLogin:(BOOL)cancelled {
    [pendingApiCallsController userDidNotGrantPermission];
}

/**
 * Called when the request logout has succeeded.
 */
- (void)fbDidLogout {
    pendingApiCallsController = nil;
    
    // Remove saved authorization information if it exists and it is
    // ok to clear it (logout, session invalid, app unauthorized)
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"FBAccessTokenKey"];
    [defaults removeObjectForKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    
    [self showLoggedOut];
}

/**
 * Called when the session has expired.
 */
- (void)fbSessionInvalidated {   
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Auth Exception" 
                              message:@"Your session has expired." 
                              delegate:nil 
                              cancelButtonTitle:@"OK" 
                              otherButtonTitles:nil, 
                              nil];
    [alertView show];
    [alertView release];
    [self fbDidLogout];
}

#pragma mark - FBRequestDelegate Methods
/**
 * Called when the Facebook API request has returned a response. This callback
 * gives you access to the raw response. It's called before
 * (void)request:(FBRequest *)request didLoad:(id)result,
 * which is passed the parsed response object.
 */
- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response {
    //NSLog(@"received response");
}

/**
 * Called when a request returns and its response has been parsed into
 * an object. The resulting object may be a dictionary, an array, a string,
 * or a number, depending on the format of the API response. If you need access
 * to the raw response, use:
 *
 * (void)request:(FBRequest *)request
 *      didReceiveResponse:(NSURLResponse *)response
 */
- (void)request:(FBRequest *)request didLoad:(id)result {
    if ([result isKindOfClass:[NSArray class]]) {
        result = [result objectAtIndex:0];
    }
    // This callback can be a result of getting the user's basic
    // information or getting the user's permissions.
    if ([result objectForKey:@"name"]) {
        // If basic information callback, set the UI objects to
        // display this.
        nameLabel.text = [result objectForKey:@"name"];
        // Get the profile image
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[result objectForKey:@"pic"]]]];
        
        // Resize, crop the image to make sure it is square and renders
        // well on Retina display
        float ratio;
        float delta;
        float px = 100; // Double the pixels of the UIImageView (to render on Retina)
        CGPoint offset;
        CGSize size = image.size;
        if (size.width > size.height) {
            ratio = px / size.width;
            delta = (ratio*size.width - ratio*size.height);
            offset = CGPointMake(delta/2, 0);
        } else {
            ratio = px / size.height;
            delta = (ratio*size.height - ratio*size.width);
            offset = CGPointMake(0, delta/2);
        }
        CGRect clipRect = CGRectMake(-offset.x, -offset.y,
                                     (ratio * size.width) + delta,
                                     (ratio * size.height) + delta);
        UIGraphicsBeginImageContext(CGSizeMake(px, px));
        UIRectClip(clipRect);
        [image drawInRect:clipRect];
        UIImage *imgThumb =   UIGraphicsGetImageFromCurrentImageContext();
        [imgThumb retain];
        
        [profilePhotoImageView setImage:imgThumb];
        [self apiGraphUserPermissions];
    } else {
        // Processing permissions information
        CoachToolsAppDelegate *delegate = (CoachToolsAppDelegate *)[[UIApplication sharedApplication] delegate];
        [delegate setUserPermissions:[[result objectForKey:@"data"] objectAtIndex:0]];
    }
}

/**
 * Called when an error prevents the Facebook API request from completing
 * successfully.
 */
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"Err message: %@", [[error userInfo] objectForKey:@"error_msg"]);
    NSLog(@"Err code: %d", [error code]);
}




@end
