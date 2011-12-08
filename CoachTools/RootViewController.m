//
//  RootViewController.m
//  CoachTools
//
//  Created by cj on 4/10/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import "RootViewController.h"

#import "GameManagementViewController.h"
#import "ChalkTalkViewController.h"
#import "TeamListViewController.h"
#import "Person.h"
#import "GameTimerDisplay.h"
#import "GameTimerButton.h"
#import "PlistStringUtil.h"

#import "IAPManagerViewController.h"
#import "IADManagerViewController.h"
#import <EventKitUI/EventKitUI.h>

#import "ShowcaseModel.h"
#import "ShowcaseFormDataSource.h"
#import "ShowcaseController.h"

#import "Crittercism.h"
#import "FlurryAnalytics.h"

//#import "SampleFormController.h"

static RootViewController *sharedInstance;

@implementation RootViewController
		
@synthesize fetchedResultsController;
@synthesize managedObjectContext;
@synthesize menuSectionsArray;
@synthesize menuOptionsArray;

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
    IAPManagerViewController *addController = [[IAPManagerViewController alloc] initWithNibName:@"IAPManagerViewController" bundle:nil];
    //addController.delegate = self;
	
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:addController];
    navigationController.modalPresentationStyle = UIModalPresentationFullScreen;
    navigationController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentModalViewController:navigationController animated:YES];
    
    [navigationController release];
    [addController release];
    
}

- (IBAction)IADManagerButton:(id)sender{
    IADManagerViewController *addController = [[IADManagerViewController alloc] initWithNibName:@"IADManagerViewController" bundle:nil];
    //addController.delegate = self;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:addController];
    navigationController.modalPresentationStyle = UIModalPresentationFullScreen;
    navigationController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentModalViewController:navigationController animated:YES];
    
    [navigationController release];
    [addController release];
    
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


@end
