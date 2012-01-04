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
#import "FlurryAnalytics.h"

@implementation PlayerEditViewController

@synthesize labels;
@synthesize placeholders;
@synthesize delegate;
@synthesize item;

@synthesize playerModel;

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
    
    self.labels = [NSArray arrayWithObjects:@"Number", 
                   @"Last Name", 
                   @"Email", 
                   @"Phone Number", 
                   nil];
	
	self.placeholders = [NSArray arrayWithObjects:@"Player Number", 
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

- (void)dealloc{
    [labels release];
    [placeholders release];
    labels = nil;
    placeholders = nil;
    
    [super dealloc];
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
            cell.textLabel.text = [NSString stringWithFormat:@"None Assigned"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if([item.contactIdentifier intValue] == (-3) ){
            cell.textLabel.text = [NSString stringWithFormat:@"Internal: %@ %@", item.firstName, item.lastName];            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else{
            cell.textLabel.text = [NSString stringWithFormat:@"Address Book: %@ %@", item.firstName, item.lastName];            
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
    
    NSLog(@"%@",item.playerNumber);
    
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    //Game Number validators
    if ([item.playerNumber isEqualToString:@""]) {
        //Check if empty
       [HelpManagement errorMessage:@"Player Number" error:@"requiredFieldEdit"];
        return FALSE;
    }else if ( [f numberFromString:item.playerNumber] == nil){
        //Check if number is a number
        [HelpManagement errorMessage:@"Player Number" error:@"numOnlyField"];
        [f release];
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
    [f release];
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

#pragma mark PlayerFormDataSource




#pragma mark Addressbook Delegat

- (void)doneAddressBook:(AddressBookViewController *)doneAddressBook contactIdentifier:(ABRecordRef)person{
    
    item.firstName          = (NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    item.lastName           = (NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);	
    NSNumber *recordId      = [NSNumber numberWithInteger:ABRecordGetRecordID(person)];
    item.contactIdentifier  = [recordId stringValue];
    if (item.firstName == nil) {
        item.firstName = @"";
    }
    if (item.lastName == nil) {
        item.lastName = @"";
    }
    
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"Address Book: %@ %@", item.firstName, item.lastName];
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)cancelledAddressBook:(AddressBookViewController *)cancelledAddressBook{
    //Do Nothing
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Optional Addressbook delegates
- (void) doneForm:(AddressBookViewController *)doneForm{
    
    NSNumber *recordId        = [NSNumber numberWithInteger:(-1)];
    item.contactIdentifier    = [recordId stringValue];	
    
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"Internal: %@ %@", item.firstName, item.lastName];
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)cancelForm:(AddressBookViewController *)cancelForm{
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
                AddressBookViewController *detailViewController = [[AddressBookViewController alloc] initWithStyle:UITableViewStyleGrouped player:item withInternal:YES];
                detailViewController.delegate = self;

                [self.navigationController pushViewController:detailViewController animated:YES];
                [detailViewController release];
            }else{
                ABAddressBookRef addressBook = ABAddressBookCreate();
                // Search for the person named in the address book
                ABRecordID recordID = (ABRecordID) [item.contactIdentifier intValue];
                ABRecordRef person = ABAddressBookGetPersonWithRecordID(addressBook, recordID);
                // Display information if found in the address book 
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
                   
                    [FlurryAnalytics logError:@"Unresolve Exception: Search" message:@"Could not find person in Contacts" error:nil];
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
            if([item.contactIdentifier intValue] == (-1)){
                
                [self showItemForm];
                      
            }else{
                //Edit the link with the address book
                AddressBookViewController *detailViewController = [[AddressBookViewController alloc] initWithStyle:UITableViewStyleGrouped player:item withInternal:YES];
                detailViewController.delegate = self;
                [self.navigationController pushViewController:detailViewController animated:YES];
                [detailViewController release];
            }

        }
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
	sampleFormController.title = @"Edit Player";
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
        item.email = [self.playerModel valueForKey:@"email"];
        item.phoneNumber = [self.playerModel valueForKey:@"phoneNumber"]; 
        
        //Date
        
        NSCalendar *dateCal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *dateComponent = [dateCal components:( NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekCalendarUnit | NSWeekdayCalendarUnit |NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:[self.playerModel valueForKey:@"birthdate"]];
        
        item.birthdate =  [[dateCal dateFromComponents:dateComponent] copy];
        
        [playerModel release];
        [self dismissModalViewControllerAnimated:YES];

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

BOOL isNumeric(NSString *s)
{
    NSScanner *sc = [NSScanner scannerWithString: s];
    if ( [sc scanFloat:NULL] )
    {
        return [sc isAtEnd];
    }
    return NO;
}

@end
