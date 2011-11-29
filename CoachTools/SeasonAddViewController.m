

#import "SeasonAddViewController.h"
#import "RootViewController.h"
#import "Season.h"
#import "PlistStringUtil.h"

@implementation SeasonAddViewController

@synthesize season;
@synthesize nameTextField;
@synthesize delegate;
@synthesize team;


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

- (void)viewDidLoad {
    
    // Configure the navigation bar
    self.navigationItem.title = @"Add Season";
    
    UIBarButtonItem *cancelButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = cancelButtonItem;
    [cancelButtonItem release];
    
    UIBarButtonItem *saveButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = saveButtonItem;
    [saveButtonItem release];
	
	[nameTextField becomeFirstResponder];
}


- (void)viewDidUnload {
	self.nameTextField = nil;
	[super viewDidUnload];
}
	
	
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Support all orientations except upside-down
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if (textField == nameTextField) {
		[nameTextField resignFirstResponder];
		[self save];
	}
	return YES;
}

- (void)save {
    

    self.season.name = nameTextField.text;
    self.season.team = team;
    
    //Check before saving

    if([self validateSeason]){
        
        //MOC BITCH!
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
                   [self.delegate seasonAddViewController:self didAddSeason:season];
    }

}

- (void)cancel {

    RootViewController *ac = [RootViewController sharedAppController];
    NSManagedObjectContext *managedObjectContext = [ac managedObjectContext];
    
	[managedObjectContext deleteObject:season];

	NSError *error = nil;
	if (![managedObjectContext save:&error]) {

		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}		

    [self.delegate seasonAddViewController:self didAddSeason:nil];
    
}

- (BOOL)validateSeason{
    
      
    //Season validators
    if ([self.season.name isEqualToString:@""]) {
        //Check if empty
        NSMutableArray *msgParams = [[[NSMutableArray alloc] init] autorelease];
        [msgParams addObject:@"Season Name"];
        
        UIAlertView *someError = [[UIAlertView alloc] initWithTitle:[PlistStringUtil retrieveErrorText:@"requiredField.title" withParams:msgParams] message:[PlistStringUtil retrieveErrorText:@"requiredField.msg" withParams:msgParams] delegate: self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [someError show];
        [someError release];
        
        return FALSE;
    }
    return TRUE;
    
}


- (void)dealloc {
    [season release];    
    [nameTextField release];    
    [super dealloc];
}

@end
