//
//  PlayerEditViewController.m
//  CoachTools
//
//  Created by Chris Desch on 12/5/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import "PlayerEditViewController.h"
#import "AddressBookViewController.h"
#import "HelpManagement.h"

@implementation PlayerEditViewController

@synthesize labels;
@synthesize placeholders;
@synthesize delegate;
@synthesize item;

- (id)initWithStyle:(UITableViewStyle)style
{
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

    self.title = @"Player Form";
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(saveButton:)];
    
    self.navigationItem.rightBarButtonItem = addButton;
    [addButton release];
    
    UIBarButtonItem *cancelButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelButton:)];
    self.navigationItem.leftBarButtonItem = cancelButtonItem;
    [cancelButtonItem release];
    
    self.labels = [NSArray arrayWithObjects:@"Player Number", 
                   @"Last Name", 
                   @"Email", 
                   @"Phone Number", 
                   nil];
	
	self.placeholders = [NSArray arrayWithObjects:@"Enter Player Number", 
                         @"Enter Last Name", 
                         @"Enter Email", 
                         @"Phone Number (Optional)", 
                         nil];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 2;
}

//Table Section Header
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

    NSString *title = @"";
    
    if(section == 0){
        title = @"Player Information";
    }
    else if (section == 1){
        title =  @"Contact Information";
    }
    return title;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.

    int num = 0;
    
    if (section == 0){
        num =  1; 
        
    }else if (section == 1){
        num = 1;     
    }
    
    return num;
}


- (void)configureTextFieldCell:(ELCTextfieldCell *)cell atIndexPath:(NSIndexPath *)indexPath {
	    
	cell.leftLabel.text = [self.labels objectAtIndex:indexPath.row];
	cell.rightTextField.placeholder = [self.placeholders objectAtIndex:indexPath.row];
    if(item.playerNumber != nil){
        cell.rightTextField.text = item.playerNumber;
    }
    
	cell.indexPath = indexPath;
	cell.delegate = self;
    //Disables UITableViewCell from accidentally becoming selected.
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
	if(indexPath.row == 3) {
        
		[cell.rightTextField setKeyboardType:UIKeyboardTypeNumberPad];
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell1;
    // Configure the cell...
    if(indexPath.section == 0){
        
        ELCTextfieldCell *cell = (ELCTextfieldCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell = (ELCTextfieldCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[ELCTextfieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        
        [self configureTextFieldCell:cell atIndexPath:indexPath];
        return cell;
        
    }else if (indexPath.section == 1){
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        
        if([item.contactIdentifier intValue] == (-1) || [item.contactIdentifier intValue] == (-2)){
            cell.textLabel.text = [NSString stringWithFormat:@"Contact: None Assigned"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else{
            cell.textLabel.text = [NSString stringWithFormat:@"Contact: %@ %@", item.firstName, item.lastName];            
             cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        }
        
        return cell;
    }

    return cell1;
    
}

#pragma mark ELCTextFieldCellDelegate Methods

- (void)textFieldDidReturnWithIndexPath:(NSIndexPath*)indexPath {
    
	if(indexPath.row < [labels count]-1) {
		NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
		[[(ELCTextfieldCell*)[self.tableView cellForRowAtIndexPath:path] rightTextField] becomeFirstResponder];
		[self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
	}
	
	else {
        
		[[(ELCTextfieldCell*)[self.tableView cellForRowAtIndexPath:indexPath] rightTextField] resignFirstResponder];
	}
}

- (void)updateTextLabelAtIndexPath:(NSIndexPath*)indexPath string:(NSString*)string {
    
	NSLog(@"See input: %@ from section: %d row: %d, should update models appropriately", string, indexPath.section, indexPath.row);
    item.playerNumber = string;
}

#pragma mark Button Actions
- (void)saveButton:(id)sender{
    
    //Check before saving
    if([self validateItem]){
        [self.delegate doneEditingPlayer:self player:item];
    }

}

- (void)cancelButton:(id)sender{

    [self.delegate cancelledEditingPlayer:self];
}

- (BOOL)validateItem{
    int maxVal = 99;
    int minVal = 0;
    
    //Game Number validators
    if ([item.playerNumber isEqualToString:@""]) {
        //Check if empty
       [HelpManagement errorMessage:@"Player Number" error:@"requiredFieldEdit"];
        return FALSE;
    }else if (![item.playerNumber intValue]){
        //Check if number is a number
        [HelpManagement errorMessage:@"Player Number" error:@"numOnlyField"];
        return FALSE;
    }
    
    else if (([item.playerNumber intValue] > maxVal) || ([item.playerNumber intValue] < minVal)){
        //Check if number within the range        
        NSMutableArray *msgParams = [[[NSMutableArray alloc] init] autorelease];
        [msgParams addObject:@"Player Number"];
        [msgParams addObject:[NSString stringWithFormat:@"%d", minVal]];
        [msgParams addObject:[NSString stringWithFormat:@"%d", maxVal]];
        
        [HelpManagement errorMessageWithParams:msgParams error:@"numRange"];
       
        return FALSE;
    }else if (self.item.contactIdentifier == nil ){
        //Check if empty
        [HelpManagement errorMessage:@"Contact Identifier" error:@"requiredFieldEdit"];
                
        return FALSE;
        
    }
    return TRUE;
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

#pragma mark Addressbook Delegat

- (void)doneAddressBook:(AddressBookViewController *)doneAddressBook contactIdentifier:(NSNumber *)contactIdentifier{
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Contact: %@ %@", item.firstName, item.lastName];
    
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)cancelledAddressBook:(AddressBookViewController *)cancelledAddressBook{
    //Do Nothing
    [self.navigationController popViewControllerAnimated:YES];
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
    if(indexPath.section == 1){
        if(indexPath.row == 0){
            //Contact
            
            if([item.contactIdentifier intValue] == (-1)  || [item.contactIdentifier intValue] == (-2)){
                //Edit the Link
                AddressBookViewController *detailViewController = [[AddressBookViewController alloc] initWithStyle:UITableViewStyleGrouped player:item];
                detailViewController.delegate = self;

                [self.navigationController pushViewController:detailViewController animated:YES];
                [detailViewController release];
            }else{
                ABAddressBookRef addressBook = ABAddressBookCreate();
                // Search for the person named "Appleseed" in the address book
                //NSArray *people = (NSArray *)ABAddressBookCopyPeopleWithName(addressBook, CFSTR("Appleseed"));
                ABRecordID recordID = (ABRecordID) [item.contactIdentifier intValue];
                NSLog(@" record %d", recordID);

                //NSArray *people = (NSArray *)ABAddressBookGetPersonWithRecordID(addressBook, recordID);
                ABRecordRef person = ABAddressBookGetPersonWithRecordID(addressBook, recordID);
                // Display "Appleseed" information if found in the address book 
                if (person != nil)
                {
                    //ABRecordRef person = (ABRecordRef)[people objectAtIndex:0];
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
        }else if (indexPath.row == 1){
            //Emergancy Contact
            //TODO: Finish Emergancy Contacts
        }
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1){
        if(indexPath.row == 0){
            //Edit the link
            AddressBookViewController *detailViewController = [[AddressBookViewController alloc] initWithStyle:UITableViewStyleGrouped player:item];
            detailViewController.delegate = self;
            [self.navigationController pushViewController:detailViewController animated:YES];
            [detailViewController release];
        }
    }
}

@end
