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



@implementation TeamSummaryViewController

@synthesize popoverController=_myPopoverController;
@synthesize team;

@synthesize nameTextField;


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
      
}

- (void)viewDidUnload

{   
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.nameTextField = nil;
    
    [super viewDidUnload];

}

- (void)viewWillAppear:(BOOL)animated{
    
    //Assign the Team to the View Controller

    nameTextField.text = team.name;
    
}


- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    [super setEditing:editing animated:animated];
    
    //Set Editing and Hide backbutton
    nameTextField.enabled = editing;
	[self.navigationItem setHidesBackButton:editing animated:YES];
    
    if (!editing) {
        //Reset the forms
        nameTextField.borderStyle = UITextBorderStyleNone;
        
        //Check if the data is validated
        if ([self validateTeam]){
                  
            //form data to the object
            team.name = nameTextField.text;
            
            //Save it to the DB
            NSManagedObjectContext *context = team.managedObjectContext;
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
            nameTextField.text = team.name;
        }
        
     }else{
         //Show Form Boxes
         nameTextField.borderStyle = UITextBorderStyleRoundedRect;
     }
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

@end
