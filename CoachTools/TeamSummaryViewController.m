//
//  TeamSummaryViewController.m
//  CoachTools
//
//  Created by cj on 5/7/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import "TeamSummaryViewController.h"
#import "RootViewController.h"
#import "Team.h"
#import "PlayerListViewController.h"
#import "PlistStringUtil.h"
#import "SeasonListViewController.h"
#import "iToast.h"

#import <IBAForms/IBAForms.h>
#import "ItemFormController.h"
#import "ShowcaseModel.h"
#import "TeamFormDataSource.h"
#import "HelpManagement.h"
#import "FlurryAnalytics.h"

//#import "AdWhirlView.h"

//#import "InAppRageIAPHelper.h"

#define kAdWhirlViewWidth 320
#define kAdWhirlViewHeight 50

@implementation TeamSummaryViewController

@synthesize popoverController=_myPopoverController;

@synthesize team;
@synthesize itemModel;
@synthesize nameTextField;
@synthesize uniformColorTextField;

//@synthesize adView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil teamSelected:(Team *)aTeam
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //NSLog(@"ViewController: %@", nibNameOrNil);
        
        //Initialize with a Team
        team = aTeam;
    }
    
    return self;
}

- (void)dealloc
{

    [nameTextField release];
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
    UINavigationItem *navigationItem = self.navigationItem;
    navigationItem.title = @"Team Summary";
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //[self setToolbarItems:[NSArray arrayWithObject:self.editButtonItem]];
    /*
    if([[InAppRageIAPHelper sharedHelper].purchasedProducts containsObject:@"com.cdesch.CoachTools.AdFree"]){
    
    }else{
        adView = [AdWhirlView requestAdWhirlViewWithDelegate:self];
        adView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
        CGSize adSize = [adView actualAdSize];
        CGSize screenSize;
        screenSize.width = 1024;
        screenSize.height = 728;
        adView.frame = CGRectMake((screenSize.width/2)-(adSize.width/2),screenSize.height-adSize.height - 107,adSize.width,adSize.height);
        adView.clipsToBounds = YES;    
        [self.view addSubview:adView];
        [self.view bringSubviewToFront:adView];
        

    }
    */

}

- (void)viewDidUnload

{   
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.nameTextField = nil;
    
    [super viewDidUnload];

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //Assign the Team to the View Controller

    nameTextField.text = team.name;
    uniformColorTextField.text = team.uniformColor;

    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}


- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    //[super setEditing:editing animated:animated];
    
    itemModel = [[NSMutableDictionary alloc] init];
    ShowcaseModel *showcaseModel = [[[ShowcaseModel alloc] init] autorelease];
    showcaseModel.shouldAutoRotate = YES;
    showcaseModel.tableViewStyleGrouped = YES;
    showcaseModel.displayNavigationToolbar = YES;
    showcaseModel.modalPresentation = YES;
    showcaseModel.modalPresentationStyle = UIModalPresentationFormSheet;
    
	// Values set on the model will be reflected in the form fields.
	//[sampleFormModel setObject:@"A value contained in the model" forKey:@"readOnlyText"];
    [itemModel setObject:team.name forKey:@"name"];
    
    if (team.uniformColor != nil) {
        [itemModel setObject:team.uniformColor forKey:@"uniformColor"];
    }
    
	TeamFormDataSource *sampleFormDataSource = [[[TeamFormDataSource alloc] initWithModel:itemModel] autorelease];
	ItemFormController *sampleFormController = [[[ItemFormController alloc] initWithNibName:nil bundle:nil formDataSource:sampleFormDataSource] autorelease];
	sampleFormController.title = @"Edit Team";
	sampleFormController.shouldAutoRotate = showcaseModel.shouldAutoRotate;
	sampleFormController.tableViewStyle = showcaseModel.tableViewStyleGrouped ? UITableViewStyleGrouped : UITableViewStylePlain;

    [[IBAInputManager sharedIBAInputManager] setInputNavigationToolbarEnabled:showcaseModel.displayNavigationToolbar];

    
	UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
	if (showcaseModel.modalPresentation) {
		UIBarButtonItem *doneButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
                                                                                     target:self 
                                                                                     action:@selector(completeEditForm:)] autorelease];
        
        UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel 
                                                                                       target:self 
                                                                                       action:@selector(cancelEditForm:)] autorelease];
		sampleFormController.navigationItem.rightBarButtonItem = doneButton;
        sampleFormController.navigationItem.leftBarButtonItem = cancelButton;
		UINavigationController *formNavigationController = [[[UINavigationController alloc] initWithRootViewController:sampleFormController] autorelease];
		formNavigationController.modalPresentationStyle = showcaseModel.modalPresentationStyle;
		[rootViewController presentModalViewController:formNavigationController animated:YES];
	} else {
        if ([rootViewController isKindOfClass:[UINavigationController class]]) {
			[(UINavigationController *)rootViewController pushViewController:sampleFormController animated:YES];
		}
	}
    
}

- (void)completeEditForm:(id)sender{
    
    //Deactivate the input requestor if it was currenlty editing
    [[IBAInputManager sharedIBAInputManager] deactivateActiveInputRequestor];
    
    //Validate
    if ([self.itemModel valueForKey:@"name"] == nil ) {
        //Check if empty
        [HelpManagement errorMessage:@"Team Name" error:@"requiredFieldEdit"];
        
    }else{
        
        //item.gameNumber = [NSNumber numberWithInt:[[self.itemModel valueForKey:@"gameNumber"] intValue]];
        team.name = [self.itemModel valueForKey:@"name"];
        team.uniformColor = [self.itemModel valueForKey:@"uniformColor"];
        
          //Save the Data.
        RootViewController *ac = [RootViewController sharedAppController];
        NSManagedObjectContext *managedObjectContext = [ac managedObjectContext];
        
        NSError *error = nil;
        if (![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            [FlurryAnalytics logError:@"Unresolved Error Updating" message:[team debugDescription] error:error];
            abort();
        }
        [itemModel release];
        [self viewWillAppear:YES];
        [self dismissModalViewControllerAnimated:YES];
    }
    
}
- (void)cancelEditForm:(id)sender{
    
    [self dismissModalViewControllerAnimated:YES];
    
    [itemModel release];
}

- (BOOL)validateTeam{
    
    //Team validators
    if ([self.nameTextField.text isEqualToString:@""]) {
        //Check if empty
        NSMutableArray *msgParams = [[[NSMutableArray alloc] init] autorelease];
        [msgParams addObject:@"Team Name"];
        
        UIAlertView *someError = [[UIAlertView alloc] initWithTitle:[PlistStringUtil retrieveErrorText:@"requiredFieldEdit.title" withParams:msgParams] message:[PlistStringUtil retrieveErrorText:@"requiredFieldEdit.msg" withParams:msgParams] delegate: self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [someError show];
        [someError release];
        
        return FALSE;
    }
    
    return TRUE;
}

- (IBAction)managePlayersButton{
    
    // Navigation logic may go here. Create and push another view controller.
    PlayerListViewController *listViewController = [[PlayerListViewController alloc] initWithNibName:@"PlayerListViewController" bundle:nil teamSelected:team];

    [self.navigationController pushViewController:listViewController animated:YES];
    [listViewController release];
}

- (IBAction)manageSeasonButton{
    
    // Navigation logic may go here. Create and push another view controller.
    SeasonListViewController *listViewController = [[SeasonListViewController alloc] initWithNibName:@"SeasonListViewController" bundle:nil teamSelected:team];
    
    [self.navigationController pushViewController:listViewController animated:YES];
    [listViewController release];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}


#pragma mark - Adwhirl functions
/*
- (NSString *)adWhirlApplicationKey {
    //Here you have to enter your AdWhirl SDK key
    NSString *key = [NSString stringWithFormat:@"ab943d0fd0af4b3684a5f3839733cf54"];

	return key ;
}




- (NSString *)admobPublisherID
{
    NSString *admobID = [NSString stringWithFormat:@"a14ec830778d4e5"];
    

    
    return admobID;
}


- (UIViewController *)viewControllerForPresentingModalView {
    return self;
}

- (void)adWhirlDidReceiveAd:(AdWhirlView *)adWhirlView {
    
    [UIView beginAnimations:@"AdWhirlDelegate.adWhirlDidReceiveAd:"
                    context:nil];
    
    [UIView setAnimationDuration:0.7];
    
    CGSize adSize = [adView actualAdSize];
    CGRect newFrame = adView.frame;
    
    newFrame.size = adSize;
    newFrame.origin.x = (self.view.bounds.size.width - adSize.width)/ 2;
    
    adView.frame = newFrame;
    
    [UIView commitAnimations];
}

- (void)adWhirlDidFailToReceiveAd:(AdWhirlView *)adWhirlView usingBackup:(BOOL)yesOrNo{

    [FlurryAnalytics logEvent:@"Failed to Recieve Ad Whirl Ad"];
}



*/
@end
