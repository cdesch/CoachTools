//
//  GameListViewController.m
//  CoachTools
//
//  Created by cj on 5/4/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import "GameListViewController.h"
#import "RootViewController.h"
#import "GameSummaryViewController.h"
#import "AddGameViewController.h"
#import "Game.h"
#import "GameListViewCell.h"
#import "UIColor-MoreColors.h"

#import <IBAForms/IBAForms.h>
#import "ItemFormController.h"
#import "ShowcaseModel.h"
#import "GameFormDataSource.h"
#import "EventManager.h"

#import "HelpManagement.h"
#import "FlurryAnalytics.h"

@implementation GameListViewController

@synthesize itemModel;
@synthesize itemArray;
@synthesize item;
//@synthesize team;
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
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;
    //Title of the Root View Controller
    self.title = @"Games";
    
    // Set up the game Selection button.
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Add Game" style:UIBarButtonItemStylePlain target:self action:@selector(insertGameButton)];
    
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
        
    // Sort and Reload
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"gameNumber" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
	
	NSMutableArray *sortedGames = [[NSMutableArray alloc] initWithArray:[season.games allObjects]];
	[sortedGames sortUsingDescriptors:sortDescriptors];
	self.itemArray = sortedGames;
    
	[sortDescriptor release];
	[sortDescriptors release];
	[sortedGames release];

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
                                                    otherButtonTitles:@"Game Number", @"Opponent", @"Location", @"Date" , nil]; // @"Opponent Goals",@"Team Goals",
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    //actionSheet.destructiveButtonIndex = 4; // make the second button red (destructive)
    
    //[actionSheet showInView:self.view]; // show from our table view (pops up in the middle of the table)
    [actionSheet showFromBarButtonItem:sender animated:YES];
    [actionSheet release];
    
}

//Action Sheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (actionSheet) {
        
        if(buttonIndex == 0){

            NSSortDescriptor *sortDescriptor =  [[NSSortDescriptor alloc] initWithKey:@"gameNumber" ascending:YES selector:@selector(localizedStandardCompare:)] ;
            NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
            
            NSMutableArray *sortedGames = [[NSMutableArray alloc] initWithArray:[season.games allObjects]];
            [sortedGames sortUsingDescriptors:sortDescriptors];
            self.itemArray = sortedGames;
            
            [sortDescriptor release];
            [sortDescriptors release];
            [sortedGames release];

            [self.tableView reloadData]; 
            
        }else if (buttonIndex == 1){
            [self sortList:@"opponent" ascendingOrder:YES];
        }else if (buttonIndex == 2){
            [self sortList:@"location" ascendingOrder:YES];
        }else if (buttonIndex == 3){
            [self sortList:@"date" ascendingOrder:YES];
        }
        else if (buttonIndex == 4){
            [self sortList:@"opponentScore" ascendingOrder:NO];
        }
    }
    
}

- (void)sortList:(NSString *)key ascendingOrder:(BOOL)order{
    
    //Sort using key as sort parameter
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:order];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
    
    NSMutableArray *sortedGames = [[NSMutableArray alloc] initWithArray:[season.games allObjects]];
    [sortedGames sortUsingDescriptors:sortDescriptors];
    self.itemArray = sortedGames;
    
    [sortDescriptor release];
    [sortDescriptors release];
    [sortedGames release];
    
    [self.tableView reloadData];                                                                     
    
}


- (void)insertGameButton{
   
    itemModel = [[NSMutableDictionary alloc] init]; 
    
    RootViewController *sharedController = [RootViewController sharedAppController];
    NSManagedObjectContext *managedObjectContext = [sharedController managedObjectContext];
    item = [NSEntityDescription insertNewObjectForEntityForName:@"Game" inManagedObjectContext:managedObjectContext];

    ShowcaseModel *showcaseModel = [[[ShowcaseModel alloc] init] autorelease];
    showcaseModel.shouldAutoRotate = YES;
    showcaseModel.tableViewStyleGrouped = YES;
    showcaseModel.displayNavigationToolbar = YES;
    showcaseModel.modalPresentation = YES;
    showcaseModel.modalPresentationStyle = UIModalPresentationFormSheet;

	// Values set on the model will be reflected in the form fields.
	//[sampleFormModel setObject:@"A value contained in the model" forKey:@"readOnlyText"];
    [itemModel setObject:[NSString stringWithFormat:@"%d",[self.itemArray count] +1] forKey:@"gameNumber"];
    
	GameFormDataSource *sampleFormDataSource = [[[GameFormDataSource alloc] initWithModel:itemModel] autorelease];
	ItemFormController *sampleFormController = [[[ItemFormController alloc] initWithNibName:nil bundle:nil formDataSource:sampleFormDataSource] autorelease];
	sampleFormController.title = @"Add Game Form";
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
    
    //Deactivate the input requestor if it was currenlty editing
    [[IBAInputManager sharedIBAInputManager] deactivateActiveInputRequestor];
    
    //Validate
    if ([self.itemModel valueForKey:@"gameNumber"] == nil || [[self.itemModel valueForKey:@"gameNumber"] isEqualToString:@""]) {
        //Check if empty
        [HelpManagement errorMessage:@"Game Number" error:@"requiredFieldEdit"];
        
    }else if (![[self.itemModel valueForKey:@"gameNumber"] intValue]){
        //Check if number is a number
        [HelpManagement errorMessage:@"Game Number" error:@"numOnlyField"];
        
    }
    else if ([self.itemModel valueForKey:@"date"] == nil){
        //Required field
        [HelpManagement errorMessage:@"Date" error:@"requiredFieldEdit"];
        
    }else if ([self.itemModel valueForKey:@"time"] == nil){
        //Required field
        [HelpManagement errorMessage:@"Time" error:@"requiredFieldEdit"];
        
    }
    else{
        
        //item.gameNumber = [NSNumber numberWithInt:[[self.itemModel valueForKey:@"gameNumber"] intValue]];
        item.gameNumber = [self.itemModel valueForKey:@"gameNumber"];
        item.location = [self.itemModel valueForKey:@"location"];
        item.opponent = [self.itemModel valueForKey:@"opponent"];
        item.season = season;
        
        
        
        //Date
        //Retrieve Components of the date
        NSCalendar *dateCal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *dateComponent = [dateCal components:( NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekCalendarUnit | NSWeekdayCalendarUnit |NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:[self.itemModel valueForKey:@"date"]];
        
        NSCalendar *timeCal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *timeComponent = [timeCal components:( NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:[self.itemModel valueForKey:@"time"]];
        
        // adjust them for first day of previous week (Monday)
        [dateComponent setHour:[timeComponent hour]];
        [dateComponent setMinute:[timeComponent minute]];
        
        //Format Date for display
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
        
        // construct new date and return
        tempDate =  [[dateCal dateFromComponents:dateComponent] copy];
        
        [timeCal release];
        [dateCal release];
        [dateFormatter release];
        
        item.date = tempDate;
        
        if( [[self.itemModel valueForKey:@"linkCalendar"] intValue] == 1){

            item.eventIdentifier= [EventManager setCalendarEntry:item.date title:[NSString stringWithFormat:@"%@ - Game: %@", season.team.name, item.gameNumber ]];
        }
        
        //Save the Data.
        RootViewController *ac = [RootViewController sharedAppController];
        NSManagedObjectContext *managedObjectContext = [ac managedObjectContext];
        
        NSError *error = nil;
        if (![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            [FlurryAnalytics logError:@"Unresolved Error Inserting" message:[item debugDescription] error:error];
            abort();
        }		
        
        [self dismissModalViewControllerAnimated:YES];
    }
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"gameNumber" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
	
	NSMutableArray *sortedItems = [[NSMutableArray alloc] initWithArray:[season.games allObjects]];
	[sortedItems sortUsingDescriptors:sortDescriptors];
	self.itemArray = sortedItems;
    
	[sortDescriptor release];
	[sortDescriptors release];
	[sortedItems release];
	
	// Update recipe type and ingredients on return.
    [self.tableView reloadData]; 
    
    //Show Training
    [itemModel release];
    
}

- (void)cancelForm{
    
    RootViewController *ac = [RootViewController sharedAppController];
    NSManagedObjectContext *managedObjectContext = [ac managedObjectContext];
    
	[managedObjectContext deleteObject:item];
    
	NSError *error = nil;
	if (![managedObjectContext save:&error]) {

		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        [FlurryAnalytics logError:@"Unresolved Error Saving" message:[item debugDescription] error:error];
        
		abort();
	}		

    [itemModel release];
    [self dismissModalViewControllerAnimated:YES];
}

- (void)validateForm{
    
}



- (void)addGameViewController:(AddGameViewController *)addGameViewController didAddGame:(Game*)game{
    if(game){
        //Show the season
        [self showGame:game animated:YES];
    }
    
    // Dismiss the modal add recipe view controller
    [self dismissModalViewControllerAnimated:YES];
    //[self.navigationController popViewControllerAnimated:YES];
}


//Deprecated
- (void)showGame:(Game *)game animated:(BOOL)animated {
    
    // Create a detail view controller, set the recipe, then push it.
    GameSummaryViewController *detailViewController = [[GameSummaryViewController alloc] initWithNibName:@"GameSummaryViewController" bundle:nil gameSelected:game];
    
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

    static NSString *kCustomCellID = @"PlayerListViewCell";
	
    GameListViewCell *cell = (GameListViewCell *)[tableView dequeueReusableCellWithIdentifier:kCustomCellID];
	if (cell == nil)
	{
        NSArray *topLevelObjects =[[NSBundle mainBundle] loadNibNamed:@"GameListViewCell" owner:nil options:nil];
        
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[UITableViewCell class]]){
                cell = (GameListViewCell *) currentObject;
            }
        }
        
	}
    
    Game *selectedGame =  [self.itemArray objectAtIndex:indexPath.row];

    
    //If there is a calendar entry, check to make sure its accuracte
    if(selectedGame.eventIdentifier != nil){
        [self checkCalendarDates:selectedGame];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    cell.gameNumberLabel.text = selectedGame.gameNumber;
    cell.opponentLabel.text = selectedGame.opponent;
    cell.dateLabel.text = [dateFormatter stringFromDate:selectedGame.date];
    [dateFormatter release];
    
    cell.locationLabel.text = selectedGame.location;
    
    if([selectedGame.played boolValue] == FALSE){
        cell.badgeView.badgeText = @"Scheduled";
        cell.badgeView.badgeColor = [UIColor grayColor];
    }else{
        if([selectedGame.homeScore intValue] == [selectedGame.opponentScore intValue]){
            cell.badgeView.badgeText = [NSString stringWithFormat:@"%@ %@-%@", @"Draw",selectedGame.homeScore, selectedGame.opponentScore];
            cell.badgeView.badgeColor = [UIColor orangeColor];
        }else if([selectedGame.homeScore intValue] > [selectedGame.opponentScore intValue]){
            cell.badgeView.badgeText = [NSString stringWithFormat:@"%@ %@-%@", @"Win",selectedGame.homeScore, selectedGame.opponentScore];
            cell.badgeView.badgeColor = [UIColor greenWeb];
        }else{
            
            cell.badgeView.badgeText = [NSString stringWithFormat:@"%@ %@-%@", @"Loss",selectedGame.homeScore, selectedGame.opponentScore];
            cell.badgeView.badgeColor = [UIColor tomato];
        }
    }
    
    cell.badgeView.isSelected = FALSE;
    cell.badgeView.badgeTextColor = [UIColor whiteColor];
    
    //cell.penaltyStatLabel.text =[NSString stringWithFormat:@"%d", [selectedGame.gamePenalty count]]; 
    
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
        
        Game *selectedGame = [self.itemArray objectAtIndex:indexPath.row];
        [managedObjectContext deleteObject:selectedGame];
        
        // Delete the managed object for the given index path
        [itemArray removeObject:selectedGame];
        
        // Delete the managed object for the given index path in the table view
        [tableView deleteRowsAtIndexPaths:[NSArray                                          arrayWithObject:indexPath]                        withRowAnimation:UITableViewRowAnimationFade];
		
        // Save the context.
		NSError *error;
		if (![managedObjectContext save:&error]) {

			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            [FlurryAnalytics logError:@"Unresolved Error Deleting" message:[selectedGame debugDescription] error:error];
			abort();
		}
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
    
}

//Check if the date on the game is different from the date on the calendar
- (void)checkCalendarDates:(Game*)aGame{
    //
    EKEventStore *eventDB = [[EKEventStore alloc] init];
    EKEvent *myEvent;
    //eventDB 
    
    //Check if the eventidentifier actually exists
    if((myEvent  = [eventDB eventWithIdentifier:aGame.eventIdentifier])){
        //Event Does Exist
        //NSLog(@"Does Exist");
        //Update the Event Date if it has changed. 
        if([aGame.date isEqualToDate:myEvent.startDate]){
            //Do nothing // Date is equl
            
        }else{

            
            aGame.date = myEvent.startDate;
            
            NSManagedObjectContext *managedObjectContext = aGame.managedObjectContext;          
            NSError *error = nil;
            if (![managedObjectContext save:&error]) {
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                [FlurryAnalytics logError:@"Unresolved Error Updating" message:[aGame debugDescription] error:error];
                abort();
            }		
            
        }
        
    }else {

  
        aGame.date = nil;
        
        NSManagedObjectContext *managedObjectContext = aGame.managedObjectContext;
        
        NSError *error = nil;
        if (![managedObjectContext save:&error]) {

            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            [FlurryAnalytics logError:@"Unresolved Error Updating" message:[aGame debugDescription] error:error];
            abort();
        }		

    }
    
    [eventDB release];
    
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
    //NSLog(@"Enter %s", __PRETTY_FUNCTION__);
    //Create and push another view controller.
    GameSummaryViewController *gameSummaryViewController = [[GameSummaryViewController alloc] initWithNibName:@"GameSummaryViewController" bundle:nil gameSelected:[self.itemArray objectAtIndex:indexPath.row]];

    [self.navigationController pushViewController:gameSummaryViewController animated:YES];
    [gameSummaryViewController release];
    //NSLog(@"Exit %s", __PRETTY_FUNCTION__);
}

@end
