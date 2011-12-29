//
//  AddressBookViewController.m
//  CoachTools
//
//  Created by Chris Desch on 12/5/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import "AddressBookViewController.h"
#import "Team.h"

#import "PlayerFormDataSource.h"
#import "ShowcaseModel.h"
#import <IBAForms/IBAForms.h>
#import "ItemFormController.h"

#import "HelpManagement.h"

#import "FlurryAnalytics.h"

@implementation AddressBookViewController

@synthesize delegate;
@synthesize labels;
@synthesize item;

@synthesize playerModel;

- (id)initWithStyle:(UITableViewStyle)style{
    
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.labels = [NSArray arrayWithObjects:@"Address Book: Existing Contact",@"Address Book: New Contact", nil];    
        
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style player:(Person*)player withInternal:(BOOL)internal{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        item = player;
        
        if (internal){
            self.labels = [NSArray arrayWithObjects:@"Address Book: Existing Contact",@"Address Book: New Contact",@"Internal Contact", nil];    
        }else{
            self.labels = [NSArray arrayWithObjects:@"Address Book: Existing Contact",@"Address Book: New Contact", nil];    
        }
        
    }
    return self;
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
    
    self.title = @"Select Contact Type";
    



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
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (item !=nil){
        if([item.contactIdentifier intValue] == (-1)){
            [self showMigrationAlert];
        }
    }
     
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

- (void)dealloc{
    [labels release];

    labels = nil;
    
    [super dealloc];
}


//Migration Alert
- (void)showMigrationAlert
{
	UIAlertView *alert = [[UIAlertView alloc] init];
	[alert setTitle:@"Migration"];
	[alert setMessage:@"CoachTools has detected that this Player is from a earlier version. Would you like to use the Migration Assistant to create a new Contact in your address book based off of the Player's information?"];
	[alert setDelegate:self];
	[alert addButtonWithTitle:@"Yes"];
	[alert addButtonWithTitle:@"No"];
	[alert show];
	[alert release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 0)
	{
		// Yes, do something
        [self migrateItem];
	}
	else if (buttonIndex == 1)
	{
		// No Dimiss
	}
}


#pragma mark playerFormDataSource Delgates

- (void)showItemForm{
    
    playerModel = [[NSMutableDictionary alloc] init];

    ShowcaseModel *showcaseModel = [[[ShowcaseModel alloc] init] autorelease];
    showcaseModel.shouldAutoRotate = YES;
    showcaseModel.tableViewStyleGrouped = YES;
    showcaseModel.displayNavigationToolbar = YES;
    showcaseModel.modalPresentation = YES;
    showcaseModel.modalPresentationStyle = UIModalPresentationFormSheet;

    if (item.lastName != nil){
        [playerModel setObject:item.lastName forKey:@"lastName"];
    }
    
    if (item.firstName != nil) {
        [playerModel setObject:item.firstName forKey:@"firstName"];
    }
    if (item.phoneNumber != nil) {
        [playerModel setObject:item.phoneNumber forKey:@"phoneNumber"];
    }



    if (item.birthdate != nil){
        [playerModel setObject:item.birthdate forKey:@"birthDate"];    
    }
    
    if (item.email != nil){
        [playerModel setObject:item.email forKey:@"email"];    
    }
    
    
	PlayerFormDataSource *sampleFormDataSource = [[[PlayerFormDataSource alloc] initWithModel:playerModel] autorelease];
	ItemFormController *sampleFormController = [[[ItemFormController alloc] initWithNibName:nil bundle:nil formDataSource:sampleFormDataSource] autorelease];
	sampleFormController.title = @"Add Form";
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
		[self presentModalViewController:formNavigationController animated:YES];
	} else {
        if ([rootViewController isKindOfClass:[UINavigationController class]]) {
			[(UINavigationController *)rootViewController pushViewController:sampleFormController animated:YES];
		}
	}
    
    
}


- (void)completeSampleForm{
    
    //Deactivate the input requestor if it was currenlty editing
    [[IBAInputManager sharedIBAInputManager] deactivateActiveInputRequestor];
    
    //Validate
    
    if ([self.playerModel valueForKey:@"lastName"] == nil || [[self.playerModel valueForKey:@"lastName"] isEqualToString:@""]){
        //Check if empty
        [HelpManagement errorMessage:@"Last Name" error:@"requiredFieldEdit"];
        
    } else if ([self.playerModel valueForKey:@"firstName"] == nil || [[self.playerModel valueForKey:@"firstName"] isEqualToString:@""]){
        //Check if empty
        [HelpManagement errorMessage:@"First Name" error:@"requiredFieldEdit"];
        
    }else if (!([self.playerModel valueForKey:@"email"] == nil || [[self.playerModel valueForKey:@"email"] isEqualToString:@""]) && ![self validateEmail:[self.playerModel valueForKey:@"email"]]){
        
        [HelpManagement errorMessage:[self.playerModel valueForKey:@"email"]  error:@"emailInvalid"];
        
    }else{
        
        //item.playerNumber = [self.playerModel valueForKey:@"playerNumber"];
        item.firstName = [self.playerModel valueForKey:@"firstName"];
        item.lastName = [self.playerModel valueForKey:@"lastName"];
        item.phoneNumber = [self.playerModel valueForKey:@"phoneNumber"]; 
        item.email = [self.playerModel valueForKey:@"email"];
        
        //Date
        
        NSCalendar *dateCal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *dateComponent = [dateCal components:( NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekCalendarUnit | NSWeekdayCalendarUnit |NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:[self.playerModel valueForKey:@"birthdate"]];
        
        item.birthdate =  [[dateCal dateFromComponents:dateComponent] copy];
        
        [playerModel release];
        [self dismissModalViewControllerAnimated:YES];
        [self.delegate doneForm:self];
    }
    
}

- (void)cancelForm{
    [playerModel release];
    [self dismissModalViewControllerAnimated:YES];
}

- (BOOL)validateEmail:(NSString *)candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
    
    return [emailTest evaluateWithObject:candidate];
}


#pragma mark Addressbook delegate


//Import an Existing Item for the contacts
- (void)itemImport{
    
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
	// Display only a person's phone, email, and birthdate
	NSArray *displayedItems = [NSArray arrayWithObjects:[NSNumber numberWithInt:kABPersonPhoneProperty], 
                               [NSNumber numberWithInt:kABPersonEmailProperty],
                               [NSNumber numberWithInt:kABPersonBirthdayProperty], nil];
	picker.modalPresentationStyle = UIModalPresentationFormSheet;
	picker.displayedProperties = displayedItems;
	// Show the picker 
	[self presentModalViewController:picker animated:YES];
    [picker release];
}

//Present a new Item for the Contacts
- (void)newItem{
    
    ABNewPersonViewController *picker = [[ABNewPersonViewController alloc] init];
	picker.newPersonViewDelegate = self;
    
	UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:picker];
    navigation.modalPresentationStyle = UIModalPresentationFormSheet;
	[self presentModalViewController:navigation animated:YES];
	
	[picker release];
	[navigation release];	
    
}

- (void)migrateItem{
    
	ABRecordRef aContact = ABPersonCreate();
	CFErrorRef anError = NULL;
    ABMultiValueRef email = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    bool didAdd = FALSE;

    if(item.email != nil){
        
        didAdd = ABMultiValueAddValueAndLabel(email, item.email, kABOtherLabel, NULL);
    }
    
    if (didAdd == YES)
	{
		ABRecordSetValue(aContact, kABPersonEmailProperty, email, &anError);
    }

    if (item.lastName != nil) {
        ABRecordSetValue(aContact, kABPersonLastNameProperty, item.lastName , &anError);
    }
    
    if (item.firstName != nil) {
        ABRecordSetValue(aContact, kABPersonFirstNameProperty, item.firstName , &anError);
    }
    
    if (item.birthdate != nil){
        ABRecordSetValue(aContact, kABPersonBirthdayProperty, item.birthdate , &anError);
    }

    if (anError == NULL)
	{

		ABUnknownPersonViewController *picker = [[ABUnknownPersonViewController alloc] init];
		picker.unknownPersonViewDelegate = self;
		picker.displayedPerson = aContact;
		picker.allowsAddingToAddressBook = YES;
		picker.allowsActions = YES;
        picker.alternateName = [NSString stringWithFormat:@"%@ %@", item.firstName, item.lastName ];
		picker.title = @"Player";
		picker.message =[NSString stringWithFormat:@"%@ Team Member", item.team.name];
		
		[self.navigationController pushViewController:picker animated:YES];
		[picker release];
	}
	else 
	{
  
        
        [FlurryAnalytics logError:@"Unresolve Exception: Insert" message:@"Could not add person to contacts" error:nil];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" 
														message:@"Could not create unknown user" 
													   delegate:nil 
											  cancelButtonTitle:@"Cancel"
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
		
	CFRelease(email);
	CFRelease(aContact);
}





#pragma mark Delegates

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person{
    
    [self dismissModalViewControllerAnimated:YES];
    [self.delegate doneAddressBook:self contactIdentifier:person];    
    
	return NO;
}

// Does not allow users to perform default actions such as dialing a phone number, when they select a person property.
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person 
								property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
	return YES;
}

// Dismisses the people picker and shows the application when users tap Cancel. 
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker;
{
	[self dismissModalViewControllerAnimated:YES];
    [self.delegate cancelledAddressBook:self];
}

- (void)newPersonViewController:(ABNewPersonViewController *)newPersonView didCompleteWithNewPerson:(ABRecordRef)person{

    if (person != nil) {
              
        [self dismissModalViewControllerAnimated:YES];
        [self.delegate doneAddressBook:self contactIdentifier:person]; 
    }else{

        [self dismissModalViewControllerAnimated:YES];
        [self.delegate cancelledAddressBook:self];
    }
}


#pragma mark ABUnknownPersonViewControllerDelegate methods
// Dismisses the picker when users are done creating a contact or adding the displayed person properties to an existing contact. 
- (void)unknownPersonViewController:(ABUnknownPersonViewController *)unknownPersonView didResolveToPerson:(ABRecordRef)person
{
    
    if (person != nil) {
        [self.navigationController popViewControllerAnimated:NO];
        [self dismissModalViewControllerAnimated:YES];
        [self.delegate doneAddressBook:self contactIdentifier:person];    
    }else{
        [self.navigationController popViewControllerAnimated:NO];        
        [self dismissModalViewControllerAnimated:YES];
        [self.delegate cancelledAddressBook:self];
    }
    
}

// Does not allow users to perform default actions such as emailing a contact, when they select a contact property.
- (BOOL)unknownPersonViewController:(ABUnknownPersonViewController *)personViewController shouldPerformDefaultActionForPerson:(ABRecordRef)person 
						   property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
	return NO;
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
    return [labels count];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
    cell.textLabel.text = [self.labels objectAtIndex:indexPath.row];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if(indexPath.row == 0){
        //Existing Contact
        [self itemImport];
    }else if (indexPath.row == 1){
        //New Contact
        [self newItem];
    }else if (indexPath.row == 2){
        [self showItemForm];
    }
}

@end
