//
//  EmergencyContactViewController.m
//  CoachTools
//
//  Created by Chris Desch on 12/9/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import "EmergencyContactViewController.h"
#import "RootViewController.h"
#import "FlurryAnalytics.h"

NSInteger INSERT_TAG = 99;
NSInteger REGULAR_TAG = 98;
@implementation EmergencyContactViewController

@synthesize item;
@synthesize itemsArray;
@synthesize eContact;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        itemsArray = [[NSMutableArray alloc] init];
    }
    return self;
}


- (id)initWithStyle:(UITableViewStyle)style player:(Person*)player
{
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
    self.title = @"Emergency Contacts";
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButton:)];
    
    self.navigationItem.leftBarButtonItem = doneButton;
    [doneButton release];
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.allowsSelectionDuringEditing = YES;
    
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
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"contactIdentifier" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
    
    NSMutableArray *sortedPlayers = [[NSMutableArray alloc] initWithArray:[item.emergencyContact  allObjects]];
    [sortedPlayers sortUsingDescriptors:sortDescriptors];
    self.itemsArray = sortedPlayers;
    
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

- (void)dealloc{
    
    [itemsArray release];
    
    [super dealloc];
}

#pragma makr - Button Controls

- (void)doneButton:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
    
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{

    [super setEditing:editing animated:animated];    
    [self.tableView beginUpdates];
    
    NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:[self.itemsArray count] inSection:0]];

    if (editing)
    {
        [[self tableView] insertRowsAtIndexPaths:paths 
                                withRowAnimation:UITableViewRowAnimationLeft];      
    }
    else {
        [[self tableView] deleteRowsAtIndexPaths:paths 
                                withRowAnimation:UITableViewRowAnimationLeft];
        
    }
    [self.tableView endUpdates];
    
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section
    
    /*
    if(self.editing)
        return [itemsArray count] +1;
    else
        return [itemsArray count];
     
     */
    
    NSInteger rows = 0;
    
    /*
     The number of rows depends on the section.
     In the case of ingredients, if editing, add a row in editing mode to present an "Add Ingredient" cell.
	 */

    rows = [itemsArray count];
    if (self.editing) {
       rows++;
    }
    
    return rows;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
    EmergencyContact *selectedItem = [self.itemsArray objectAtIndex:indexPath.row];
    
    ABAddressBookRef addressBook = ABAddressBookCreate();
    // Search for the person named "Appleseed" in the address book
    ABRecordID recordID = (ABRecordID) [selectedItem.contactIdentifier intValue];
    ABRecordRef person = ABAddressBookGetPersonWithRecordID(addressBook, recordID);
    // Display "Appleseed" information if found in the address book 
    if (person != nil)
    {
        NSString* firstName        = (NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
        NSString* lastName         = (NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else 
    {
        [FlurryAnalytics logError:@"Unresolve Exception: Search" message:@"Could not find person in Contacts" error:nil];
        // Show an alert if "Appleseed" is not in Contacts
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" 
                                                        message:@"Could not find person in the Contacts application" 
                                                       delegate:nil 
                                              cancelButtonTitle:@"Cancel" 
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
    //[people release];
    CFRelease(addressBook);

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = nil;

    NSUInteger itemsCount = [self.itemsArray count];
    
    if (indexPath.row < itemsCount) {
        static NSString *CellIdentifier = @"Cell";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            // Create a cell to display an ingredient.
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        [self configureCell:cell atIndexPath:indexPath];
    
    }else{
        static NSString *CellIdentifier = @"AddCell";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            // Create a cell to display an ingredient.
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        cell.textLabel.text = @"Add Emergency Contact";
    }
    
    return cell;

}


#pragma mark -
#pragma mark Editing rows
/*
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSIndexPath *rowToSelect = indexPath;
    NSInteger section = indexPath.section;
    BOOL isEditing = self.editing;
    
    // If editing, don't allow instructions to be selected
    // Not editing: Only allow instructions to be selected
    if ((isEditing && section == INSTRUCTIONS_SECTION) || (!isEditing && section != INSTRUCTIONS_SECTION)) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        rowToSelect = nil;    
    }
    
	return rowToSelect;
}
*/


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
  

/*
    if (self.editing && (indexPath.row == [itemsArray count]) ) {
    //    NSLog(@"Editing INSERT!");
        return UITableViewCellEditingStyleInsert;
        
    }
      //      NSLog(@"Editing DELETE!");
    return UITableViewCellEditingStyleDelete;
  */
    
    UITableViewCellEditingStyle style = UITableViewCellEditingStyleNone;
    if (indexPath.row == [self.itemsArray count]) {
       style = UITableViewCellEditingStyleInsert;
    }
    else {
       style = UITableViewCellEditingStyleDelete;
    }

    
    return style;

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
        if(self.editing){
            [self setEditing:NO animated:YES];
        }
        
        // Delete the row from the data source
        RootViewController *ac = [RootViewController sharedAppController];
        NSManagedObjectContext *managedObjectContext = [ac managedObjectContext];
        
        EmergencyContact* selectedItem = [self.itemsArray objectAtIndex:indexPath.row];

        // Delete the managed object for the given index path
        [itemsArray removeObject:selectedItem];
        
        [managedObjectContext deleteObject:selectedItem];
        
        // Delete the managed object for the given index path in the table view
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
		
        // Save the context
		NSError *error;
		if (![managedObjectContext save:&error]) {
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            [FlurryAnalytics logError:@"Unresolved Error Deleting" message:[selectedItem debugDescription] error:error];
			abort();
		}        
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        
        if(eContact != nil){
            eContact =nil;
        }
        
        RootViewController *sharedController = [RootViewController sharedAppController];
        NSManagedObjectContext *managedObjectContext = [sharedController managedObjectContext];
        eContact = [NSEntityDescription insertNewObjectForEntityForName:@"EmergencyContact" inManagedObjectContext:managedObjectContext];

        //Edit the link
        AddressBookViewController *detailViewController = [[AddressBookViewController alloc] initWithStyle:UITableViewStyleGrouped];
        detailViewController.delegate = self;
        [self.navigationController pushViewController:detailViewController animated:YES];
        [detailViewController release];
        
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

#pragma mark Addressbook Delegat

- (void)doneAddressBook:(AddressBookViewController *)doneAddressBook contactIdentifier:(ABRecordRef)person{

    NSNumber *recordId      = [NSNumber numberWithInteger:ABRecordGetRecordID(person)];
    eContact.contactIdentifier  = [recordId stringValue];
    eContact.player = item;
    
    //Save the Data.
    RootViewController *ac = [RootViewController sharedAppController];
    NSManagedObjectContext *managedObjectContext = [ac managedObjectContext];
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        [FlurryAnalytics logError:@"Unresolved Error Inserting" message:[item debugDescription] error:error];
        abort();
    }		
    
    if(self.editing){
        [self setEditing:NO animated:YES];
    }
    
    [self.navigationController popViewControllerAnimated:YES];

}
- (void)cancelledAddressBook:(AddressBookViewController *)cancelledAddressBook{
    
     if ([eContact.contactIdentifier intValue] == (-2)){
         
         RootViewController *ac = [RootViewController sharedAppController];
         NSManagedObjectContext *managedObjectContext = [ac managedObjectContext];
         
         [managedObjectContext deleteObject:eContact];
         
         NSError *error = nil;
         if (![managedObjectContext save:&error]) {
             
             NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
             [FlurryAnalytics logError:@"Unresolved Error Saving" message:[item debugDescription] error:error];
             
             abort();
         }		
     }
    
    //Do Nothing
    [self.navigationController popViewControllerAnimated:YES];
    
    if([item.emergencyContact count] == 0){
        [self dismissModalViewControllerAnimated:YES];
    }
}

#pragma mark ABdelegate
- (BOOL)personViewController:(ABPersonViewController *)personViewController shouldPerformDefaultActionForPerson:(ABRecordRef)person 
					property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifierForValue
{
	return NO;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.editing) {
        if(indexPath.row == [self.itemsArray count]){
            
            if(eContact != nil){
                eContact =nil;
            }
            
            RootViewController *sharedController = [RootViewController sharedAppController];
            NSManagedObjectContext *managedObjectContext = [sharedController managedObjectContext];
            eContact = [NSEntityDescription insertNewObjectForEntityForName:@"EmergencyContact" inManagedObjectContext:managedObjectContext];
            
            //Edit the link
            AddressBookViewController *detailViewController = [[AddressBookViewController alloc] initWithStyle:UITableViewStyleGrouped];
            detailViewController.delegate = self;
            [self.navigationController pushViewController:detailViewController animated:YES];
            [detailViewController release];

        }else{
            //Edit the link
            AddressBookViewController *detailViewController = [[AddressBookViewController alloc] initWithStyle:UITableViewStyleGrouped];
            eContact = [self.itemsArray objectAtIndex:indexPath.row];
            detailViewController.delegate = self;
            [self.navigationController pushViewController:detailViewController animated:YES];
            [detailViewController release];

        }
    }else{
        
        EmergencyContact *selectedItem = [self.itemsArray objectAtIndex:indexPath.row];
        
        ABAddressBookRef addressBook = ABAddressBookCreate();
        // Search for the person named "Appleseed" in the address book
        ABRecordID recordID = (ABRecordID) [selectedItem.contactIdentifier intValue];
        ABRecordRef person = ABAddressBookGetPersonWithRecordID(addressBook, recordID);
        // Display "Appleseed" information if found in the address book 
        if (person != nil)
        {

            ABPersonViewController *picker = [[[ABPersonViewController alloc] init] autorelease];
            picker.personViewDelegate = self;
            picker.displayedPerson = person;
            // Allow users to edit the person’s information
            picker.allowsEditing = YES;
            [self.navigationController pushViewController:picker animated:YES];
        }
        else 
        {
            
            // Show an alert if "Appleseed" is not in Contacts
            [FlurryAnalytics logError:@"Unresolve Exception: Search" message:@"Could not find person in Contacts" error:nil];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" 
                                                            message:@"Could not find person in the Contacts application" 
                                                           delegate:nil 
                                                  cancelButtonTitle:@"Cancel" 
                                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        
        CFRelease(addressBook);
    }

}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{

}

@end
