//
//  TrainingListViewController.m
//  CoachTools
//
//  Created by Chris Desch on 9/20/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import "TrainingListViewController.h"
#import "Training.h"
#import "RootViewController.h"
#import "TrainingAddViewController.h"
#import "TrainingSummaryViewController.h"
#import "PlistStringUtil.h"

#import <IBAForms/IBAForms.h>
#import "ItemFormController.h"
#import "ShowcaseModel.h"
#import "TrainingFormDataSource.h"
#import "EventManager.h"

@implementation TrainingListViewController

@synthesize trainingModel;
@synthesize item;
@synthesize itemArray;
@synthesize season;

@synthesize tempDate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil seasonSelected:(Season *)aSeason{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //NSLog(@"ViewController: %@", nibNameOrNil);
        
        //Initialize 
        season = aSeason;
        
    }
    return self;
    
}


- (void)dealloc
{
    
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
    
    self.title = @"Training Sessions";
    
    // Set up the game Selection button.
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Add Training" style:UIBarButtonItemStylePlain target:self action:@selector(insertItemButton:)];
    
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
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"trainingNumber" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
	
	NSMutableArray *sortedItems = [[NSMutableArray alloc] initWithArray:[season.training allObjects]];
	[sortedItems sortUsingDescriptors:sortDescriptors];
	self.itemArray = sortedItems;
    
	[sortDescriptor release];
	[sortDescriptors release];
	[sortedItems release];
	
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

- (void)insertItemButton:(id)sender{
    
    
    trainingModel = [[NSMutableDictionary alloc] init];
    
    
    RootViewController *sharedController = [RootViewController sharedAppController];
    NSManagedObjectContext *managedObjectContext = [sharedController managedObjectContext];
    item = [NSEntityDescription insertNewObjectForEntityForName:@"Training" inManagedObjectContext:managedObjectContext];
       

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
    [trainingModel setObject:[NSString stringWithFormat:@"%d",[self.itemArray count] +1] forKey:@"trainingNumber"];
    
	TrainingFormDataSource *sampleFormDataSource = [[[TrainingFormDataSource alloc] initWithModel:trainingModel] autorelease];
	ItemFormController *sampleFormController = [[[ItemFormController alloc] initWithNibName:nil bundle:nil formDataSource:sampleFormDataSource] autorelease];
	sampleFormController.title = @"Add Training Form";
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

- (void)completeSampleForm {
    //Validate

    if ([self.trainingModel valueForKey:@"trainingNumber"] == nil || [[self.trainingModel valueForKey:@"trainingNumber"] isEqualToString:@""]) {
        //Check if empty
        NSMutableArray *msgParams = [[[NSMutableArray alloc] init] autorelease];
        [msgParams addObject:@"Traning Number"];
        
        UIAlertView *someError = [[UIAlertView alloc] initWithTitle:[PlistStringUtil retrieveErrorText:@"requiredFieldEdit.title" withParams:msgParams] message:[PlistStringUtil retrieveErrorText:@"requiredFieldEdit.msg" withParams:msgParams] delegate: self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [someError show];
        [someError release];
        
    }else if (![[self.trainingModel valueForKey:@"trainingNumber"] intValue]){
        //Check if number is a number
        
        NSMutableArray *msgParams = [[[NSMutableArray alloc] init] autorelease];
        [msgParams addObject:@"Training Number"];
        
        UIAlertView *someError = [[UIAlertView alloc] initWithTitle:[PlistStringUtil retrieveErrorText:@"numOnlyField.title" withParams:msgParams] message:[PlistStringUtil retrieveErrorText:@"numOnlyField.msg" withParams:msgParams] delegate: self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [someError show];
        [someError release];
        
    }
    else if ([self.trainingModel valueForKey:@"date"] == nil){
        NSMutableArray *msgParams = [[[NSMutableArray alloc] init] autorelease];
        [msgParams addObject:@"Date"];
        
        UIAlertView *someError = [[UIAlertView alloc] initWithTitle:[PlistStringUtil retrieveErrorText:@"requiredFieldEdit.title" withParams:msgParams] message:[PlistStringUtil retrieveErrorText:@"requiredFieldEdit.msg" withParams:msgParams] delegate: self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [someError show];
        [someError release];
        
    }else if ([self.trainingModel valueForKey:@"time"] == nil){
        NSMutableArray *msgParams = [[[NSMutableArray alloc] init] autorelease];
        [msgParams addObject:@"Time"];
        
        UIAlertView *someError = [[UIAlertView alloc] initWithTitle:[PlistStringUtil retrieveErrorText:@"requiredFieldEdit.title" withParams:msgParams] message:[PlistStringUtil retrieveErrorText:@"requiredFieldEdit.msg" withParams:msgParams] delegate: self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [someError show];
        [someError release];
    }
    else{
        
        item.trainingNumber = [NSNumber numberWithInt:[[self.trainingModel valueForKey:@"trainingNumber"] intValue]];
        item.trainingLocation = [self.trainingModel valueForKey:@"trainingLocation"];
        item.trainingDescription = [self.trainingModel valueForKey:@"trainingDescription"];
        item.season = season;
                
        //Date
        //Retrieve Components of the date
        NSCalendar *dateCal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *dateComponent = [dateCal components:( NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekCalendarUnit | NSWeekdayCalendarUnit |NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:[self.trainingModel valueForKey:@"date"]];
        
        NSCalendar *timeCal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *timeComponent = [timeCal components:( NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:[self.trainingModel valueForKey:@"time"]];
        
        // adjust them for first day of previous week (Monday)
        [dateComponent setHour:[timeComponent hour]];
        [dateComponent setMinute:[timeComponent minute]];
        
        //Format Date for display
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
        
        // construct new date and return
        //dateTextField.text = [dateFormatter stringFromDate:[dateCal dateFromComponents:dateComponent]];
        //self.game.date = [dateCal dateFromComponents:dateComponent];
        tempDate =  [[dateCal dateFromComponents:dateComponent] copy];
        
        [timeCal release];
        [dateCal release];
        [dateFormatter release];

        item.date = tempDate;
        
        //NSLog(@"combined date: %@",tempDate);
        
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
    
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"trainingNumber" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
	
	NSMutableArray *sortedItems = [[NSMutableArray alloc] initWithArray:[season.training allObjects]];
	[sortedItems sortUsingDescriptors:sortDescriptors];
	self.itemArray = sortedItems;
    
	[sortDescriptor release];
	[sortDescriptors release];
	[sortedItems release];
	
	// Update recipe type and ingredients on return.
    [self.tableView reloadData]; 

    //Show Training
    
}

- (void) cancelForm{
    
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

- (void)validateForm{
    
}

- (void)buildModel{
    
}


-(void)addTrainingViewController:(TrainingAddViewController *)trainingAddViewController didAddTraining:(Training *)training{

    if(training){
        //Show the season
        [self showTraining:training animated:YES];
    }
    
    // Dismiss the modal add recipe view controller
    [self dismissModalViewControllerAnimated:YES];
    //[self.navigationController popViewControllerAnimated:YES];
}

- (void)showTraining:(Training *)training animated:(BOOL)animated {
    
    // Create a detail view controller, set the recipe, then push it.
    TrainingSummaryViewController *detailViewController = [[TrainingSummaryViewController alloc] initWithNibName:@"TrainingSummaryViewController" bundle:nil trainingSelected:training];
    
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
    return [self.itemArray count];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    /*
     Game *selectedGame = [self.gameArray objectAtIndex:indexPath.row];
     cell.textLabel.text = [selectedGame.gameNumber description];
     */
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    Training *itemSelected =  [self.itemArray objectAtIndex:indexPath.row];

    [self validateDates:itemSelected];
        
    cell.textLabel.text =  [itemSelected.trainingNumber stringValue];
    
    return cell;
}

//Validate the Dates for Training
- (void)validateDates:(Training*)itemSelected{
    
    if(itemSelected.eventIdentifier != nil){
        
        //Check if Date has been removed
        if(![EventManager checkCalendarEntryExists:itemSelected.eventIdentifier]){
            //Does Not Exist
            itemSelected.date = nil;
            
            //Save
            
            //Save the Data.
            
            NSManagedObjectContext *managedObjectContext = itemSelected.managedObjectContext;
            NSError *error = nil;
            if (![managedObjectContext save:&error]) {
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort();
            }		
            
        }
        //Check if Date has been changed
        else if (![EventManager checkCalendarDateIsEqaul:itemSelected.eventIdentifier startDate:itemSelected.date]){
            itemSelected.date = [EventManager getCurrentCalendarDate:itemSelected.eventIdentifier];
            
            //Save
            NSManagedObjectContext *managedObjectContext = itemSelected.managedObjectContext;
            NSError *error = nil;
            if (![managedObjectContext save:&error]) {
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort();
            }		
            
        }
        
    }
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
        
        RootViewController *ac = [RootViewController sharedAppController];
        NSManagedObjectContext *managedObjectContext = [ac managedObjectContext];
        
        Training *selectedItem = [self.itemArray objectAtIndex:indexPath.row];
        [managedObjectContext deleteObject:selectedItem];
        
        // Delete the managed object for the given index path
        [itemArray removeObject:selectedItem];

        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        // Save the context.
		NSError *error;
		if (![managedObjectContext save:&error]) {

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
- (BOOL)tableView:(UITableView *)tableView canTrainingAddViewControllerMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    //Create and push another view controller.
    TrainingSummaryViewController *viewController = [[TrainingSummaryViewController alloc] initWithNibName:@"TrainingSummaryViewController" bundle:nil trainingSelected:[self.itemArray objectAtIndex:indexPath.row]];
    
    [self.navigationController pushViewController:viewController animated:YES];
    [viewController release];
}

@end
