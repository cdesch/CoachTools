//
//  AddPlayerViewController.m
//  CoachTools
//
//  Created by cj on 5/4/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import "AddPlayerViewController.h"
#import "Person.h"
#import "RootViewController.h"
#import "PlistStringUtil.h"

@implementation AddPlayerViewController

@synthesize delegate;

@synthesize playerNumberTextField;
@synthesize lastNameTextField;
@synthesize firstNameTextField;
@synthesize emailTextField;

@synthesize person;
@synthesize team;
@synthesize detailViewPopover;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil teamSelected:(Team *)aTeam
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //NSLog(@"ViewController: %@", nibNameOrNil);
        
        //Initialize
        team = aTeam;
    }
    return self;
}

- (void)dealloc
{
    [playerNumberTextField release];
    [lastNameTextField release];
    [firstNameTextField release];
    [emailTextField release];
    [person release];
    [detailViewPopover release];
    
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
    
    self.title = @"Add Player";
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(saveButton:)];
    
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
    self.person = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}


- (void)saveButton:(id)sender{
  

    self.person.lastName = lastNameTextField.text;
    self.person.firstName = firstNameTextField.text;
    self.person.email = emailTextField.text;
    self.person.playerNumber = playerNumberTextField.text;
    self.person.team = team;
    
    //Check before saving

    if([self validatePerson]){
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
        
        [self.delegate addPlayerViewController:self didAddPerson:person];
    }


}

- (void)cancelButton:(id)sender{

    RootViewController *ac = [RootViewController sharedAppController];
    NSManagedObjectContext *managedObjectContext = [ac managedObjectContext];
    
	[managedObjectContext deleteObject:person];
    
	NSError *error = nil;
	if (![managedObjectContext save:&error]) {
        
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}		
    
    [self.delegate addPlayerViewController:self didAddPerson:nil];
}



- (BOOL)validatePerson{
    
    int maxVal = 99;
    int minVal = 0;
    
    //Game Number validators
    if ([self.person.playerNumber isEqualToString:@""]) {
        //Check if empty
        NSMutableArray *msgParams = [[[NSMutableArray alloc] init] autorelease];
        [msgParams addObject:@"Player Number"];
        
        UIAlertView *someError = [[UIAlertView alloc] initWithTitle:[PlistStringUtil retrieveErrorText:@"requiredField.title" withParams:msgParams] message:[PlistStringUtil retrieveErrorText:@"requiredField.msg" withParams:msgParams] delegate: self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [someError show];
        [someError release];
        
        return FALSE;
    }else if (![self.person.playerNumber intValue]){
        //Check if number is a number
        
        NSMutableArray *msgParams = [[[NSMutableArray alloc] init] autorelease];
        [msgParams addObject:@"Player Number"];
        
        UIAlertView *someError = [[UIAlertView alloc] initWithTitle:[PlistStringUtil retrieveErrorText:@"numOnlyField.title" withParams:msgParams] message:[PlistStringUtil retrieveErrorText:@"numOnlyField.msg" withParams:msgParams] delegate: self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [someError show];
        [someError release];
        
        return FALSE;
    }
    
    else if (([self.person.playerNumber intValue] > maxVal) || ([self.person.playerNumber intValue] < minVal)){
        //Check if number within the range        
        NSMutableArray *msgParams = [[[NSMutableArray alloc] init] autorelease];
        [msgParams addObject:@"Player Number"];
        [msgParams addObject:[NSString stringWithFormat:@"%d", minVal]];
        [msgParams addObject:[NSString stringWithFormat:@"%d", maxVal]];
        
        UIAlertView *someError = [[UIAlertView alloc] initWithTitle:[PlistStringUtil retrieveErrorText:@"numRange.title" withParams:msgParams] message:[PlistStringUtil retrieveErrorText:@"numRange.msg" withParams:msgParams] delegate: self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [someError show];
        [someError release];
        
        return FALSE;
    }else if ([self.person.lastName isEqualToString:@""]){
        
        //Check if empty
        NSMutableArray *msgParams = [[[NSMutableArray alloc] init] autorelease];
        [msgParams addObject:@"Last Name"];
        
        UIAlertView *someError = [[UIAlertView alloc] initWithTitle:[PlistStringUtil retrieveErrorText:@"requiredField.title" withParams:msgParams] message:[PlistStringUtil retrieveErrorText:@"requiredField.msg" withParams:msgParams] delegate: self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [someError show];
        [someError release];
        
        return FALSE;
        
    }else if ([self.person.firstName isEqualToString:@""]){
        
        //Check if empty
        NSMutableArray *msgParams = [[[NSMutableArray alloc] init] autorelease];
        [msgParams addObject:@"First Name"];
        
        UIAlertView *someError = [[UIAlertView alloc] initWithTitle:[PlistStringUtil retrieveErrorText:@"requiredField.title" withParams:msgParams] message:[PlistStringUtil retrieveErrorText:@"requiredField.msg" withParams:msgParams] delegate: self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [someError show];
        [someError release];
        
        return FALSE;
    }else if (![self.person.email isEqualToString:@""] && ![self validateEmail:self.person.email]){
        
        NSMutableArray *msgParams = [[[NSMutableArray alloc] init] autorelease];
        [msgParams addObject:self.person.email];
        
        UIAlertView *someError = [[UIAlertView alloc] initWithTitle:[PlistStringUtil retrieveErrorText:@"emailInvalid.title" withParams:msgParams] message:[PlistStringUtil retrieveErrorText:@"emailInvalid.msg" withParams:msgParams] delegate: self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [someError show];
        [someError release];
        
        return FALSE;
    }
  
    
    return TRUE;
    
    
}

#pragma mark - Validations
-(BOOL)validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
    
    return [emailTest evaluateWithObject:candidate];
}
              
              



@end
