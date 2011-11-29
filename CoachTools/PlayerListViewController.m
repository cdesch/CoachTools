//
//  PlayerListViewController.m
//  CoachTools
//
//  Created by cj on 5/8/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import "PlayerListViewController.h"
#import "RootViewController.h"
#import "PlayerSummaryViewController.h"
#import "PlayerListViewCell.h"
#import "AddPlayerViewController.h"
#import "Person.h"
#import "UIColor-MoreColors.h"


#import <IBAForms/IBAForms.h>
#import "ItemFormController.h"
#import "ShowcaseModel.h"
#import "PlayerFormDataSource.h"
#import "EventManager.h"

#import "FlurryAnalytics.h"
#import "HelpManagement.h"

@implementation PlayerListViewController

@synthesize playerModel;
@synthesize playerArray;
@synthesize item;
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

- (void)dealloc
{
    //[team release]; //Double Check I dont think I need to release this since it was not alloc

    
    [playerArray release];
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    //self.navigationItem.leftBarButtonItem = self.editButtonItem;
    //Title of the Root View Controller
    self.title = @"Players";
    //[self.navigationController setToolbarHidden:NO];
    // Set up the Team Selection button.
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Add Player" style:UIBarButtonItemStylePlain target:self action:@selector(insertPlayerButton:)];
    
    self.navigationItem.rightBarButtonItem = addButton;
    UIBarButtonItem *sortAscendingButton = [[UIBarButtonItem alloc] initWithTitle:@"Sort" style:UIBarButtonItemStyleBordered target:self action:@selector(sortButton:)];
    
    UIBarButtonItem *flexibleBarButtItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    [self setToolbarItems:[NSArray arrayWithObjects:self.editButtonItem,flexibleBarButtItem,sortAscendingButton,nil]];
    
    [flexibleBarButtItem release];
    [sortAscendingButton release];


    [addButton release];
    


}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;

}

- (void)viewWillAppear:(BOOL)animated
{ 
    [super viewWillAppear:animated];

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
	
	NSMutableArray *sortedPlayers = [[NSMutableArray alloc] initWithArray:[team.players allObjects]];
	[sortedPlayers sortUsingDescriptors:sortDescriptors];
	self.playerArray = sortedPlayers;
    
	[sortDescriptor release];
	[sortDescriptors release];
	[sortedPlayers release];
	
	// Update recipe type and ingredients on return.
    [self.tableView reloadData]; 
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


#pragma mark 
#pragma mark - Actions

//Sort Button is pressed
- (void)sortButton:(id)sender{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Sort by"
                                                             delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Name", @"Number", @"Goals", @"Starts", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    //actionSheet.destructiveButtonIndex = 4; // make the second button red (destructive)
    
    //[actionSheet showInView:self.view]; // show from our table view (pops up in the middle of the table)
    [actionSheet showFromBarButtonItem:sender animated:YES];
    [actionSheet release];
    
}

//Action Sheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (actionSheet.tag == 1) {
        
        if(buttonIndex == 0){
            [self sortList:@"lastName" ascendingOrder:YES];
        }else if (buttonIndex == 1){
            NSSortDescriptor *sortDescriptor =  [[NSSortDescriptor alloc] initWithKey:@"playerNumber" ascending:YES selector:@selector(localizedStandardCompare:)] ;
            NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
            [playerArray sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptors] ];
            [sortDescriptor release];
            [sortDescriptors release];
            
            [self.tableView reloadData];    
            
            
        }else if (buttonIndex == 2){
            [self sortList:@"cGoals" ascendingOrder:NO];
            
        }else if (buttonIndex == 3){
            [self sortList:@"cStarts" ascendingOrder:NO];
        }
    }else if (actionSheet.tag == 2) {
        if(buttonIndex == 0){
            [self itemImport];
            
        }else if (buttonIndex == 1){
            
            [self itemNewIntergrated];
        }
        else if (buttonIndex == 2){
            [self itemForm];
        }
    }
    
}

- (void)sortList:(NSString *)key ascendingOrder:(BOOL)order{
    
    
    //Sort using key as sort parameter
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:order];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
    [playerArray sortUsingDescriptors:sortDescriptors ];
    
    [sortDescriptor release];
	[sortDescriptors release];
    
    [self.tableView reloadData];                                                                     
    
}




- (void)insertItemButton:(id)sender{

    /*
    AddPlayerViewController *addController = [[AddPlayerViewController alloc] initWithNibName:@"AddPlayerViewController" bundle:nil teamSelected:team];
    
    addController.delegate = self;
    
    RootViewController *sharedController = [RootViewController sharedAppController];
    NSManagedObjectContext *managedObjectContext = [sharedController managedObjectContext];    Person* newObject = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:managedObjectContext];
	addController.person = newObject;  
    
    //Turn off editting if its on
    [self.tableView setEditing:FALSE animated:YES];
    
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:addController];
    navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    navigationController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentModalViewController:navigationController animated:YES];
    
    [navigationController release];
    
    [addController release];
     
     */
    /*
    playerModel = [[NSMutableDictionary alloc] init];
    
    
    RootViewController *sharedController = [RootViewController sharedAppController];
    NSManagedObjectContext *managedObjectContext = [sharedController managedObjectContext];
    item = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:managedObjectContext];
    
    
    //NSLog(@"%@",[newItem description]);
    
    
    //NSDictionary *attributesByName = [[newItem entity] attributesByName];
    //trainingModel = [[newItem dictionaryWithValuesForKeys:[attributesByName allKeys]] mutableCopy];
    //NSLog(@"%@",[newItem description]);
    //NSLog(@"%@",[trainingModel description]);
    
    
    //
    
    
    //ShowcaseModel *showcaseModel = [self model];
    ShowcaseModel *showcaseModel = [[[ShowcaseModel alloc] init] autorelease];
    showcaseModel.shouldAutoRotate = YES;
    showcaseModel.tableViewStyleGrouped = YES;
    showcaseModel.displayNavigationToolbar = YES;
    
    //
    showcaseModel.modalPresentation = YES;
    showcaseModel.modalPresentationStyle = UIModalPresentationFormSheet;
	
	//NSMutableDictionary *sampleFormModel = [[[NSMutableDictionary alloc] init] autorelease];
    
	// Values set on the model will be reflected in the form fields.
	//[sampleFormModel setObject:@"A value contained in the model" forKey:@"readOnlyText"];
    [playerModel setObject:[NSString stringWithFormat:@"%d",[self.playerArray count] +1] forKey:@"playerNumber"];
    
	PlayerFormDataSource *sampleFormDataSource = [[[PlayerFormDataSource alloc] initWithModel:playerModel] autorelease];
	ItemFormController *sampleFormController = [[[ItemFormController alloc] initWithNibName:nil bundle:nil formDataSource:sampleFormDataSource] autorelease];
	sampleFormController.title = @"Add Player Form";
	sampleFormController.shouldAutoRotate = showcaseModel.shouldAutoRotate;
	sampleFormController.tableViewStyle = showcaseModel.tableViewStyleGrouped ? UITableViewStyleGrouped : UITableViewStylePlain;
    
	
    [[IBAInputManager sharedIBAInputManager] setInputNavigationToolbarEnabled:showcaseModel.displayNavigationToolbar];
    
	UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
	if (showcaseModel.modalPresentation) {
		UIBarButtonItem *doneButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
																					 target:self 
																					 action:@selector(completeSampleForm)] autorelease];
        UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel 
                                                                                       target:self 
                                                                                       action:@selector(cancelForm)] autorelease];
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


     */
    [self.tableView setEditing:FALSE animated:YES];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"New Player"
                                                             delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Import from Contact List",@"New to Contact List",  @"New to App Only", nil];
    actionSheet.tag = 2;
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    //actionSheet.destructiveButtonIndex = 4; // make the second button red (destructive)
    
    //[actionSheet showInView:self.view]; // show from our table view (pops up in the middle of the table)
    [actionSheet showFromBarButtonItem:sender animated:YES];
    [actionSheet release];
    
}

- (void)itemImport{
    
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
	// Display only a person's phone, email, and birthdate
	NSArray *displayedItems = [NSArray arrayWithObjects:[NSNumber numberWithInt:kABPersonPhoneProperty], 
                               [NSNumber numberWithInt:kABPersonEmailProperty],
                               [NSNumber numberWithInt:kABPersonBirthdayProperty], nil];
	
	picker.displayedProperties = displayedItems;
	// Show the picker 
	[self presentModalViewController:picker animated:YES];
    [picker release];	
}


- (void)itemNewIntergrated{
    ABNewPersonViewController *picker = [[ABNewPersonViewController alloc] init];
	picker.newPersonViewDelegate = self;
	
	UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:picker];
	[self presentModalViewController:navigation animated:YES];
	
	[picker release];
	[navigation release];	
}

- (void)itemForm{
    
    playerModel = [[NSMutableDictionary alloc] init];
    
    RootViewController *sharedController = [RootViewController sharedAppController];
    NSManagedObjectContext *managedObjectContext = [sharedController managedObjectContext];
    item = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:managedObjectContext];
    
    
    //NSLog(@"%@",[newItem description]);
    
    
    //NSDictionary *attributesByName = [[newItem entity] attributesByName];
    //trainingModel = [[newItem dictionaryWithValuesForKeys:[attributesByName allKeys]] mutableCopy];
    //NSLog(@"%@",[newItem description]);
    //NSLog(@"%@",[trainingModel description]);
    
    
    //
    
    
    //ShowcaseModel *showcaseModel = [self model];
    ShowcaseModel *showcaseModel = [[[ShowcaseModel alloc] init] autorelease];
    showcaseModel.shouldAutoRotate = YES;
    showcaseModel.tableViewStyleGrouped = YES;
    showcaseModel.displayNavigationToolbar = YES;
    
    //
    showcaseModel.modalPresentation = YES;
    showcaseModel.modalPresentationStyle = UIModalPresentationFormSheet;
	
	//NSMutableDictionary *sampleFormModel = [[[NSMutableDictionary alloc] init] autorelease];
    
	// Values set on the model will be reflected in the form fields.
	//[sampleFormModel setObject:@"A value contained in the model" forKey:@"readOnlyText"];
    [playerModel setObject:[NSString stringWithFormat:@"%d",[self.playerArray count] +1] forKey:@"playerNumber"];
    
	PlayerFormDataSource *sampleFormDataSource = [[[PlayerFormDataSource alloc] initWithModel:playerModel] autorelease];
	ItemFormController *sampleFormController = [[[ItemFormController alloc] initWithNibName:nil bundle:nil formDataSource:sampleFormDataSource] autorelease];
	sampleFormController.title = @"Add Player Form";
	sampleFormController.shouldAutoRotate = showcaseModel.shouldAutoRotate;
	sampleFormController.tableViewStyle = showcaseModel.tableViewStyleGrouped ? UITableViewStyleGrouped : UITableViewStylePlain;
    
	
    [[IBAInputManager sharedIBAInputManager] setInputNavigationToolbarEnabled:showcaseModel.displayNavigationToolbar];
    
	UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
	if (showcaseModel.modalPresentation) {
		UIBarButtonItem *doneButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
																					 target:self 
																					 action:@selector(completeSampleForm)] autorelease];
        UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel 
                                                                                       target:self 
                                                                                       action:@selector(cancelForm)] autorelease];
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


- (void)completeSampleForm{
    //Validate
    
    if ([self.playerModel valueForKey:@"playerNumber"] == nil || [[self.playerModel valueForKey:@"playerNumber"] isEqualToString:@""]) {
        //Check if empty
        [HelpManagement errorMessage:@"Player Number" error:@"requiredFieldEdit"];
        
    }else if ([self.playerModel valueForKey:@"lastName"] == nil || [[self.playerModel valueForKey:@"lastName"] isEqualToString:@""]){
        //Check if empty
        [HelpManagement errorMessage:@"Last Name" error:@"requiredFieldEdit"];
        
    } else if ([self.playerModel valueForKey:@"firstName"] == nil || [[self.playerModel valueForKey:@"firstName"] isEqualToString:@""]){
        //Check if empty
        [HelpManagement errorMessage:@"First Name" error:@"requiredFieldEdit"];
        
    }else if ([self.playerModel valueForKey:@"email"] == nil || [[self.playerModel valueForKey:@"email"] isEqualToString:@""] || ![self validateEmail:[self.playerModel valueForKey:@"email"]]){
        
        [HelpManagement errorMessage:[self.playerModel valueForKey:@"email"]  error:@"emailInvalid"];

    }else{
        
        item.playerNumber = [self.playerModel valueForKey:@"playerNumber"];
        item.firstName = [self.playerModel valueForKey:@"firstName"];
        item.lastName = [self.playerModel valueForKey:@"lastName"];
        item.email = [self.playerModel valueForKey:@"email"];
        item.team = team;
        
        //Date

        NSCalendar *dateCal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *dateComponent = [dateCal components:( NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekCalendarUnit | NSWeekdayCalendarUnit |NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:[self.playerModel valueForKey:@"birthdate"]];
              
        item.birthdate =  [[dateCal dateFromComponents:dateComponent] copy];

        
        //Save the Data.
        RootViewController *ac = [RootViewController sharedAppController];
        NSManagedObjectContext *managedObjectContext = [ac managedObjectContext];
        
        NSError *error = nil;
        if (![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }		
        
        
        
        [self dismissModalViewControllerAnimated:YES];
        //NSLog(@"Dismissed");
        //NSLog(@"%@", [self.trainingModel description]);
    }
    
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"playerNumber" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
	
	NSMutableArray *sortedItems = [[NSMutableArray alloc] initWithArray:[team.players allObjects]];
	[sortedItems sortUsingDescriptors:sortDescriptors];
	self.playerArray = sortedItems;
    
	[sortDescriptor release];
	[sortDescriptors release];
	[sortedItems release];
	
	// Update recipe type and ingredients on return.
    [self.tableView reloadData]; 
    
    //Show Training
    
}

- (void)cancelForm{
    
    RootViewController *ac = [RootViewController sharedAppController];
    NSManagedObjectContext *managedObjectContext = [ac managedObjectContext];
    
	[managedObjectContext deleteObject:item];
    
	NSError *error = nil;
	if (![managedObjectContext save:&error]) {
        
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}		
    
    
    [self dismissModalViewControllerAnimated:YES];
}

- (BOOL)validateEmail:(NSString *)candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
    
    return [emailTest evaluateWithObject:candidate];
}


- (void)addPlayerViewController:(AddPlayerViewController *)addPlayerViewController didAddPerson:(Person *)player{
    if (player) {        

        [self showPlayer:player animated:YES];

    }
    
    // Dismiss the modal add recipe view controller
    [self dismissModalViewControllerAnimated:YES];
}


- (void)showPlayer:(Person *)person animated:(BOOL)animated {
    
    // Create a detail view controller, set the recipe, then push it.
    PlayerSummaryViewController *detailViewController = [[PlayerSummaryViewController alloc] initWithNibName:@"PlayerSummaryViewController" bundle:nil playerSelected:person];
    
    [self.tableView setEditing:FALSE animated:YES];
    
    [self.navigationController pushViewController:detailViewController animated:animated];
    [detailViewController release];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [playerArray count];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    
    Person *selectedPlayer = [self.playerArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [selectedPlayer.lastName description];
    
    //Check if first name exists
    if ([[selectedPlayer.firstName description] length] != 0)
    {
        cell.textLabel.text = [cell.textLabel.text stringByAppendingString:@", "];
        cell.textLabel.text = [cell.textLabel.text stringByAppendingString:[selectedPlayer.firstName description]];
    }
    

    
    //cell.detailTextLabel.text = [selectedPlayer.playerNumber description];
        //cell.accessoryType = UIButtonTypeRoundedRect;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section

{
    return @"No. | Name                         | Starts | Goals   ";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
     */
    static NSString *kCustomCellID = @"PlayerListViewCell";
	
    PlayerListViewCell *cell = (PlayerListViewCell *)[tableView dequeueReusableCellWithIdentifier:kCustomCellID];
	if (cell == nil)
	{
        NSArray *topLevelObjects =[[NSBundle mainBundle] loadNibNamed:@"PlayerListViewCell" owner:nil options:nil];
        
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[UITableViewCell class]]){
                cell = (PlayerListViewCell *) currentObject;
            }
        }
        
	}
    
    //Person *selectedPlayer = [self.playerArray objectAtIndex:indexPath.row];
    Person *selectedPlayer = [self.playerArray objectAtIndex:indexPath.row];
    cell.playerNumberLabel.text = [selectedPlayer.playerNumber description];
    
    //Check if player is active
    if([selectedPlayer.active boolValue] == TRUE){
        //Player is Active
        cell.badgeView.badgeText = @"Active";
        //cell.badgeView.badgeColor = [UIColor greenColor];
        //cell.badgeView.badgeColor = [UIColor greenColor] = [UIColor colorWithRed:0.85 green:0.6 blue:0.738 alpha:1.];
        cell.badgeView.badgeColor = [UIColor greenWeb];
    }else{
        cell.badgeView.badgeText = @"Not Active";
        cell.badgeView.badgeColor = [UIColor tomato];
        
    }
    

    cell.badgeView.isSelected = FALSE;
    cell.badgeView.badgeTextColor = [UIColor whiteColor];
    
    //Check if first name exists
    
    if ([[selectedPlayer.firstName description] length] != 0)
    {
        cell.playerNameLabel.text = [NSString stringWithFormat:@"%@, %@", [selectedPlayer.lastName description], [selectedPlayer.firstName description]];
    }else{
        cell.playerNameLabel.text = [selectedPlayer.lastName description];
    }
    
    cell.startStatLabel.text = [selectedPlayer.cStarts description];
    cell.goalsStatLabel.text = [selectedPlayer.cGoals description];
    
    
    
    // Configure the cell...
    //[self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        // Delete the managed object for the given index path
        RootViewController *ac = [RootViewController sharedAppController];
        NSManagedObjectContext *managedObjectContext = [ac managedObjectContext];

        Person *selectedPlayer = [self.playerArray objectAtIndex:indexPath.row];
        [managedObjectContext deleteObject:selectedPlayer];
        
        // Delete the managed object for the given index path
        [playerArray removeObject:selectedPlayer];
        
        // Delete the managed object for the given index path in the table view
        [tableView deleteRowsAtIndexPaths:[NSArray
                                           arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
		
        // Save the context.
		NSError *error;
		if (![managedObjectContext save:&error]) {
			/*
			 Replace this implementation with code to handle the error appropriately.
			 
			 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
			 */
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view


    }   
}



/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    // Navigation logic may go here. Create and push another view controller.
    
    PlayerSummaryViewController *detailViewController = [[PlayerSummaryViewController alloc] initWithNibName:@"PlayerSummaryViewController" bundle:nil playerSelected:[self.playerArray objectAtIndex:indexPath.row]];
    // ...
    // Pass the selected object to the new view controller.
    //Person *selectedPlayer = [self.playerArray objectAtIndex:indexPath.row];
    
    //((PlayerSummaryViewController *)detailViewController).player = selectedPlayer;
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
     
}


@end
