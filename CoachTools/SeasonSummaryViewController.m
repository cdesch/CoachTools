//
//  SeasonSummaryViewController.m
//  CoachTools
//
//  Created by Chris Desch on 8/30/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import "SeasonSummaryViewController.h"
#import "Season.h"
#import "RootViewController.h"
#import "iToast.h"
#import "PlistStringUtil.h"
#import "GameListViewController.h"
#import "TrainingListViewController.h"

#import "FlurryAnalytics.h"
#import "SeasonFormDataSource.h"
#import <IBAForms/IBAForms.h>
#import "ItemFormController.h"
#import "ShowcaseModel.h"
#import "HelpManagement.h"

@implementation SeasonSummaryViewController

@synthesize season;
@synthesize seasonNameTextField;
@synthesize itemModel; 

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil seasonSelected:(Season *)aSeason

{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        season = aSeason;
    }
    
    return self;
}


- (void)dealloc
{
    [seasonNameTextField release];
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
    UINavigationItem *navigationItem = self.navigationItem;
    navigationItem.title = @"Season Summary";
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload

{   

    [super viewDidUnload];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];

    self.seasonNameTextField.text = season.name;
    
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


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark - Actions

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
    if(season.name != nil){
        [itemModel setObject:season.name  forKey:@"name"];
    }

    
	SeasonFormDataSource *sampleFormDataSource = [[[SeasonFormDataSource alloc] initWithModel:itemModel] autorelease];
	ItemFormController *sampleFormController = [[[ItemFormController alloc] initWithNibName:nil bundle:nil formDataSource:sampleFormDataSource] autorelease];
	sampleFormController.title = @"Edit Season";
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
        [HelpManagement errorMessage:@"Season Name" error:@"requiredFieldEdit"];
        
    }else{
        
        //item.gameNumber = [NSNumber numberWithInt:[[self.itemModel valueForKey:@"gameNumber"] intValue]];
        season.name = [self.itemModel valueForKey:@"name"];

        
        //Save the Data.
        RootViewController *ac = [RootViewController sharedAppController];
        NSManagedObjectContext *managedObjectContext = [ac managedObjectContext];
        
        NSError *error = nil;
        if (![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            [FlurryAnalytics logError:@"Unresolved Error Updating" message:[season debugDescription] error:error];
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


- (IBAction)gamesButton:(id)sender{
    
    // Navigation logic may go here. Create and push another view controller.
    GameListViewController *detailViewController = [[GameListViewController alloc] initWithNibName:@"GameListViewController" bundle:nil seasonSelected:season];

    [self.navigationController pushViewController:detailViewController animated:YES];
    
    [detailViewController release];

}

- (IBAction)trainingButton:(id)sender{
    
    // Navigation logic may go here. Create and push another view controller.
    TrainingListViewController *detailViewController = [[TrainingListViewController alloc] initWithNibName:@"TrainingListViewController" bundle:nil seasonSelected:season];
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}


- (BOOL)validateSeason{
    //Game Number validators
    if ([seasonNameTextField.text isEqualToString:@""]) {
        
        //Check if empty
        NSMutableArray *msgParams = [[[NSMutableArray alloc] init] autorelease];
        [msgParams addObject:@"Season Name"];
        
        UIAlertView *someError = [[UIAlertView alloc] initWithTitle:[PlistStringUtil retrieveErrorText:@"requiredFieldEdit.title" withParams:msgParams] message:[PlistStringUtil retrieveErrorText:@"requiredFieldEdit.msg" withParams:msgParams] delegate: self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [someError show];
        [someError release];
        
        return FALSE;
    }
    return TRUE;
    
}


@end
