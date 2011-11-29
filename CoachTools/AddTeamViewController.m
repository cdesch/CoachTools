//
//  AddTeamViewController.m
//  CoachTools
//
//  Created by cj on 5/8/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import "AddTeamViewController.h"
#import "Team.h"
#import "RootViewController.h"
#import "PlistStringUtil.h"

@implementation AddTeamViewController

@synthesize delegate;
@synthesize nameTextField;
@synthesize uniformColorTextField;
@synthesize locationTextField;
@synthesize team;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [uniformColorTextField release];
    [locationTextField release];
    [nameTextField release];
    [team release];
    
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
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveButton:)];
    
    self.navigationItem.rightBarButtonItem = addButton;
    [addButton release];
    
    UIBarButtonItem *cancelButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelButton:)];
    self.navigationItem.leftBarButtonItem = cancelButtonItem;
    [cancelButtonItem release];

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

- (void)saveButton:(id)sender{

    
    self.team.name = nameTextField.text;
    
    if ([self validateTeam]){
        RootViewController *ac = [RootViewController sharedAppController];
        NSManagedObjectContext *managedObjectContext = [ac managedObjectContext];
        
        NSError *error = nil;
        if (![managedObjectContext save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }		
        
        [self.delegate addTeamViewController:self didAddTeam:team];
        
    }

}

- (void)cancelButton:(id)sender{
    
    RootViewController *ac = [RootViewController sharedAppController];
    NSManagedObjectContext *managedObjectContext = [ac managedObjectContext];
    
	[managedObjectContext deleteObject:team];
    
	NSError *error = nil;
	if (![managedObjectContext save:&error]) {
        
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}		
    
    [self.delegate addTeamViewController:self didAddTeam:nil];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    NSLog(@"return");
    if(textField == nameTextField) {
        [locationTextField becomeFirstResponder];
    } else if(textField == locationTextField) {
        [uniformColorTextField becomeFirstResponder];
    } else if(textField == uniformColorTextField){
        [self saveButton:self];
    }
    
    
    return NO;
}

-(BOOL)validateTeam{
    
    //Team validators
    if ([self.team.name isEqualToString:@""]) {
        //Check if empty
        NSMutableArray *msgParams = [[[NSMutableArray alloc] init] autorelease];
        [msgParams addObject:@"Team Name"];
        
        UIAlertView *someError = [[UIAlertView alloc] initWithTitle:[PlistStringUtil retrieveErrorText:@"requiredField.title" withParams:msgParams] message:[PlistStringUtil retrieveErrorText:@"requiredField.msg" withParams:msgParams] delegate: self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [someError show];
        [someError release];
        
        return FALSE;
    }
    
    return TRUE;
}


@end
