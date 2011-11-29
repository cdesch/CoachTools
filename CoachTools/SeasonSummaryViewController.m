//
//  SeasonSummaryViewController.m
//  CoachTools
//
//  Created by Chris Desch on 8/30/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import "SeasonSummaryViewController.h"
#import "Season.h"
#import "iToast.h"
#import "PlistStringUtil.h"
#import "GameListViewController.h"
#import "TrainingListViewController.h"

@implementation SeasonSummaryViewController

@synthesize season;
@synthesize seasonNameTextField;

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
    
    self.seasonNameTextField.text = season.name;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark - Actions

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    [super setEditing:editing animated:animated];
    
    //Set Editing and Hide backbutton
    seasonNameTextField.enabled = editing;

    
	[self.navigationItem setHidesBackButton:editing animated:YES];
    
    if (!editing) {
        
        //Reset the forms
        seasonNameTextField.borderStyle = UITextBorderStyleNone;

        //Check if the data is validated
        if ([self validateSeason]){
            
            //form data to the object
            season.name = seasonNameTextField.text;
                        
            //Save it to the DB
            NSManagedObjectContext *context = season.managedObjectContext;
            NSError *error = nil;
            if (![context save:&error]) {
                
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort();
            }else{
                //Confirm the Save to the user
                [[iToast makeText:NSLocalizedString(@"Data Saved", @"")] show];
                
            }
            
        }else{
            //Since the data did not validate, reset the form
            
            seasonNameTextField.text = season.name;

        }
        
    }else{
        //Show Form Boxes
        seasonNameTextField.borderStyle = UITextBorderStyleRoundedRect;

    }
}


- (IBAction)gamesButton:(id)sender{
    
    // Navigation logic may go here. Create and push another view controller.
    GameListViewController *detailViewController = [[GameListViewController alloc] initWithNibName:@"GameListViewController" bundle:nil seasonSelected:season];
    // ...
    // Pass the selected object to the new view controller.
    //Team *selectedTeam = [self.teamArray objectAtIndex:indexPath.row];
    
    //((TeamSummaryViewController *)detailViewController).team = selectedTeam;
    [self.navigationController pushViewController:detailViewController animated:YES];
    
    [detailViewController release];

}

- (IBAction)trainingButton:(id)sender{
    
    // Navigation logic may go here. Create and push another view controller.
    TrainingListViewController *detailViewController = [[TrainingListViewController alloc] initWithNibName:@"TrainingListViewController" bundle:nil seasonSelected:season];
    // ...
    // Pass the selected object to the new view controller.
    //Team *selectedTeam = [self.teamArray objectAtIndex:indexPath.row];
    
    //((TeamSummaryViewController *)detailViewController).team = selectedTeam;
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
