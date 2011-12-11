//
//  AddressBookViewController.m
//  CoachTools
//
//  Created by Chris Desch on 12/5/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import "AddressBookViewController.h"
#import "Team.h"
@implementation AddressBookViewController

@synthesize delegate;
@synthesize labels;
@synthesize item;

- (id)initWithStyle:(UITableViewStyle)style{
    
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style player:(Person*)player{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        item = player;
        
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
    if (item !=nil){
        if ([item.contactIdentifier intValue] == (-1)){
            self.labels = [NSArray arrayWithObjects:@"Existing Contact", @"New Contact",@"Migrate Existing Contact", nil];
        }else{
            self.labels = [NSArray arrayWithObjects:@"Existing Contact", @"New Contact",nil];
        }     
    }else{
           self.labels = [NSArray arrayWithObjects:@"Existing Contact", @"New Contact",nil];
    }
    
    
   
    
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
        [self migrateItem];
    }
}

@end
