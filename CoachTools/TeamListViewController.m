//
//  TeamListViewController.m
//  CoachTools
//
//  Created by cj on 5/7/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import "TeamListViewController.h"
#import "RootViewController.h"
#import "TeamSummaryViewController.h"
#import "AddTeamViewController.h"
#import "Team.h"
#import "TeamListViewCell.h"
#import <IBAForms/IBAForms.h>
#import "ItemFormController.h"
#import "ShowcaseModel.h"
#import "TeamFormDataSource.h"
#import "HelpManagement.h"
#import "FlurryAnalytics.h"
#import "PopulateTeam.h"

@implementation TeamListViewController

@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize tableSortDescriptor;

@synthesize item;
@synthesize itemModel;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        // Default Sort
        tableSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
        
    }
    return self;
}


- (void)dealloc
{
    self.fetchedResultsController.delegate = nil;
    self.fetchedResultsController = nil;
    
    [tableSortDescriptor release];
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
   // navController = [[UINavigationController alloc] init];
    
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;
    //Title of the Root View Controller
    self.title = @"Teams";
    [self.navigationController setToolbarHidden:NO];
    // Set up the Team Selection button.
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Add Team" style:UIBarButtonItemStylePlain target:self action:@selector(insertItemButton:)];
    
    self.navigationItem.rightBarButtonItem = addButton;
    [addButton release];
    
    
    UIBarButtonItem *sortAscendingButton = [[UIBarButtonItem alloc] initWithTitle:@"Sort" style:UIBarButtonItemStyleBordered target:self action:@selector(sortButton:)];
    UIBarButtonItem *flexibleBarButtItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

    [self setToolbarItems:[NSArray arrayWithObjects:self.editButtonItem,flexibleBarButtItem,sortAscendingButton,nil]];
    
    [flexibleBarButtItem release];
    [sortAscendingButton release];
    
    

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.fetchedResultsController = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
		// Update to handle the error appropriately.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        [FlurryAnalytics logError:@"Unresolved Error Fetching" message:@"TeamList FetchedResultsController" error:error];
		abort();  // Fail
	}

    
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
#pragma mark - Buttons 
//Insert Team Button -- Bring up an action sheet with some choices
- (void)insertItemButton:(id)sender{
    
    //Turn off editting if its on
    [self.tableView setEditing:FALSE animated:YES];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"New Team"
                                                             delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil
                                                    otherButtonTitles:@"New Team", @"Sample Team", nil];
    actionSheet.tag = 1;
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    //actionSheet.destructiveButtonIndex = 4; // make the second button red (destructive)    
    //[actionSheet showInView:self.view]; // show from our table view (pops up in the middle of the table)
    [actionSheet showFromBarButtonItem:sender animated:YES];
    [actionSheet release];
    
}

//Sort Button is pressed
- (void)sortButton:(id)sender{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Sort by"
                                                             delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Name", @"Wins", @"Losses",@"Draws", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    //actionSheet.destructiveButtonIndex = 4; // make the second button red (destructive)

    actionSheet.tag = 0;
    //[actionSheet showInView:self.view]; // show from our table view (pops up in the middle of the table)
    [actionSheet showFromBarButtonItem:sender animated:YES];
    [actionSheet release];
    
}

//Action Sheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (actionSheet.tag == 0) {
        
        if(buttonIndex == 0){
            [self sortList:@"name" ascendingOrder:YES];
        }else if (buttonIndex == 1){
            [self sortList:@"cWins" ascendingOrder:NO];            
        }else if (buttonIndex == 2){
            [self sortList:@"cLosses" ascendingOrder:NO];
        }else if (buttonIndex == 3){
            [self sortList:@"cDraws" ascendingOrder:NO];
        }
    }else if (actionSheet.tag == 1){
        if(buttonIndex == 0){
            [self newItemForm];
        }else if (buttonIndex == 1){
            //Populate Team        
            [self generateItem];
        }
    }

}

#pragma mark - implementation of buttons

- (void)sortList:(NSString *)key ascendingOrder:(BOOL)order{

    //Sort using key as sort parameter
    if(tableSortDescriptor != nil){
        [tableSortDescriptor release];
        tableSortDescriptor = nil;
    }

    tableSortDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:order];

    if(_fetchedResultsController != nil){
        
        [_fetchedResultsController release];
        _fetchedResultsController =nil;
    }

    NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
		// Update to handle the error appropriately.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        [FlurryAnalytics logError:@"Unresolved Error Fetching" message:[tableSortDescriptor debugDescription] error:error];
		abort();  // Fail
	}
    
    [self.tableView reloadData];                                                                      
        
}

//Populate a new sample team
- (void)generateItem{
    PopulateTeam* pop = [PopulateTeam alloc];
    [pop populate];
    [pop release];
    
    //
    [self.tableView reloadData];
}

//New Item from a form.
- (void)newItemForm{

    RootViewController *sharedController = [RootViewController sharedAppController];
    NSManagedObjectContext *managedObjectContext = [sharedController managedObjectContext];
    item = [NSEntityDescription insertNewObjectForEntityForName:@"Team" inManagedObjectContext:managedObjectContext];
    
    itemModel = [[NSMutableDictionary alloc] init];
    
    ShowcaseModel *showcaseModel = [[[ShowcaseModel alloc] init] autorelease];
    showcaseModel.shouldAutoRotate = YES;
    showcaseModel.tableViewStyleGrouped = YES;
    showcaseModel.displayNavigationToolbar = YES;
    showcaseModel.modalPresentation = YES;
    showcaseModel.modalPresentationStyle = UIModalPresentationFormSheet;
    
	TeamFormDataSource *sampleFormDataSource = [[[TeamFormDataSource alloc] initWithModel:itemModel] autorelease];
	ItemFormController *sampleFormController = [[[ItemFormController alloc] initWithNibName:nil bundle:nil formDataSource:sampleFormDataSource] autorelease];
	sampleFormController.title = @"Add Team";
	sampleFormController.shouldAutoRotate = showcaseModel.shouldAutoRotate;
	sampleFormController.tableViewStyle = showcaseModel.tableViewStyleGrouped ? UITableViewStyleGrouped : UITableViewStylePlain;
    
    [[IBAInputManager sharedIBAInputManager] setInputNavigationToolbarEnabled:showcaseModel.displayNavigationToolbar];
    
	UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
	if (showcaseModel.modalPresentation) {
		UIBarButtonItem *doneButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
																					 target:self 
																					 action:@selector(completeForm)] autorelease];
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


- (void)completeForm{
    //Team validators
    if  ([self.itemModel valueForKey:@"name"] == nil ||  [[self.itemModel valueForKey:@"name"] isEqualToString:@""]){
        //Check if empty
        [HelpManagement errorMessage:@"Team Name" error:@"requiredField"];
        
    }else {
        item.name = [self.itemModel valueForKey:@"name"];
        item.homeLocation = [self.itemModel valueForKey:@"homeLocation"];
        item.uniformColor = [self.itemModel valueForKey:@"uniformColor"];
        
        //Save the Data.
        RootViewController *ac = [RootViewController sharedAppController];
        NSManagedObjectContext *managedObjectContext = [ac managedObjectContext];
        
        NSError *error = nil;
        if (![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            [FlurryAnalytics logError:@"Unresolved Error Inserting" message:[item debugDescription] error:error];
            abort();
        }		
        
        [self showTeam:item animated:YES];
        [self dismissModalViewControllerAnimated:YES];
    
    }
    
}

- (void)cancelForm{
    
    RootViewController *ac = [RootViewController sharedAppController];
    NSManagedObjectContext *managedObjectContext = [ac managedObjectContext];
    
	[managedObjectContext deleteObject:item];
    
	NSError *error = nil;
	if (![managedObjectContext save:&error]) {
        
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        [FlurryAnalytics logError:@"Unresolved Error Deleting" message:[item debugDescription] error:error];
		abort();
	}		

    [self dismissModalViewControllerAnimated:YES];
}

- (void)addTeamViewController:(AddTeamViewController *)addTeamViewController didAddTeam:(Team *)team{
    if(team){
              
        [self showTeam:team animated:YES];
    }
    
    // Dismiss the modal add recipe view controller
    [self dismissModalViewControllerAnimated:YES];
}

- (void)showTeam:(Team *)team animated:(BOOL)animated {
    
    // Create a detail view controller, set the team, then push it.
    TeamSummaryViewController *detailViewController = [[TeamSummaryViewController alloc] initWithNibName:@"TeamSummaryViewController" bundle:nil teamSelected:team];
    
    [self.tableView setEditing:FALSE animated:NO];
    
    [self.navigationController pushViewController:detailViewController animated:animated];
    [detailViewController release];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    // Return the number of rows in the section.
    //return [teamArray count] ;
    id <NSFetchedResultsSectionInfo> sectionInfo = 
    [[_fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];

}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    /*
    Team *selectedTeam = [self.teamArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [selectedTeam.name description];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
     */
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Team Name                 Win   Loss   Draw  Scheduled";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }*/
    
    
    static NSString *kCustomCellID = @"TeamListViewCell";
	
    TeamListViewCell *cell = (TeamListViewCell *)[tableView dequeueReusableCellWithIdentifier:kCustomCellID];
	if (cell == nil)
	{
        NSArray *topLevelObjects =[[NSBundle mainBundle] loadNibNamed:@"TeamListViewCell" owner:nil options:nil];
        
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[UITableViewCell class]]){
                cell = (TeamListViewCell *) currentObject;
            }
        }

	}
     
    //Team *selectedTeam = [self.teamArray objectAtIndex:indexPath.row];
    Team *selectedTeam = [_fetchedResultsController objectAtIndexPath:indexPath];
    //cell.textLabel.text = [selectedTeam.name description];

    cell.teamNameLabel.text = [selectedTeam.name description];
    NSArray *objectStats = [self fetchObjectStats:selectedTeam.name];
    cell.winLabel.text = [[objectStats objectAtIndex:0] description];
    cell.lossLabel.text = [[objectStats objectAtIndex:1] description];
    cell.drawLabel.text = [[objectStats objectAtIndex:2] description];
    cell.notPlayedLabel.text = [[objectStats objectAtIndex:3] description];
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
        
        //Team *selectedTeam = [self.teamArray objectAtIndex:indexPath.row];
        Team *selectedTeam =  [_fetchedResultsController objectAtIndexPath:indexPath];
        [managedObjectContext deleteObject:selectedTeam];
        
        // Delete the managed object for the given index path
        //[teamArray removeObject:selectedTeam];
        
        // Delete the managed object for the given index path in the table view
        //[tableView deleteRowsAtIndexPaths:[NSArray    arrayWithObject:indexPath]   withRowAnimation:UITableViewRowAnimationFade];
		
        // Save the context.
		NSError *error;
		if (![managedObjectContext save:&error]) {

			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            [FlurryAnalytics logError:@"Unresolved Error Deleting" message:[selectedTeam debugDescription] error:error];
			abort();
        }   
        else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            NSLog(@"Insert");
        }   
    }
}

//Get the stats of the team
- (NSArray*)fetchObjectStats:(NSString*)objectName{    

    int wins = 0; 
    int losses = 0;
    int draw = 0;
    int notPlayed = 0;
    
    RootViewController *appController = [RootViewController sharedAppController];

    NSManagedObjectContext *moc = [appController managedObjectContext];
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
    [request setEntity:[NSEntityDescription entityForName:@"Game" inManagedObjectContext:moc]];
    [request setPredicate:[NSPredicate predicateWithFormat:@"ANY season.team.name like %@", objectName]];
    NSArray *singleEmployeeDepartments = [moc executeFetchRequest:request error:NULL];
    
    for(Game* game in singleEmployeeDepartments){
        if([game.played boolValue] == FALSE){
            notPlayed ++;
        }else{
            if([game.homeScore intValue] == [game.opponentScore intValue]){
                //NSLog(@"Draw");
                draw ++;
            }else if([game.homeScore intValue] > [game.opponentScore intValue]){
                //NSLog(@"Win");
                wins ++;
            }else{
                //NSLog(@"Loss");        
                losses++;
            }
        }
    }
    
    //Wins - Loss - Draw - Not Played
    return [[[NSArray alloc] initWithObjects:[NSNumber numberWithInt:wins],[NSNumber numberWithInt:losses],[NSNumber numberWithInt:draw],[NSNumber numberWithInt:notPlayed], nil] autorelease];
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


- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            // Reloading the section inserts a new row and ensures that titles are updated appropriately.
            [tableView reloadSections:[NSIndexSet indexSetWithIndex:newIndexPath.section] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableView endUpdates];
}


- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{

    // Navigation logic may go here. Create and push another view controller.
    TeamSummaryViewController *detailViewController = [[TeamSummaryViewController alloc] initWithNibName:@"TeamSummaryViewController" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    //Team *selectedTeam = [self.teamArray objectAtIndex:indexPath.row];
    
    //((TeamSummaryViewController *)detailViewController).team = selectedTeam;
    [self.navigationController pushViewController:detailViewController animated:YES];
    
    [detailViewController release];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // Navigation logic may go here. Create and push another view controller.
        //TeamSummaryViewController *detailViewController = [[TeamSummaryViewController alloc] initWithNibName:@"TeamSummaryViewController" bundle:nil teamSelected:[self.teamArray objectAtIndex:indexPath.row]];

        TeamSummaryViewController *detailViewController = [[TeamSummaryViewController alloc] initWithNibName:@"TeamSummaryViewController" bundle:nil teamSelected:[_fetchedResultsController objectAtIndexPath:indexPath]];

        // ...
    // Pass the selected object to the new view controller.
    //Team *selectedTeam = [self.teamArray objectAtIndex:indexPath.row];
    
    //((TeamSummaryViewController *)detailViewController).team = selectedTeam;
    [self.navigationController pushViewController:detailViewController animated:YES];
        
    [detailViewController release];
    
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
    [HUD release];
	HUD = nil;
}

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    RootViewController *ac = [RootViewController sharedAppController];
    NSManagedObjectContext *moc = [ac managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription 
                                   entityForName:@"Team" inManagedObjectContext:moc ];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:tableSortDescriptor]];
    
    [fetchRequest setFetchBatchSize:20];
    
    NSFetchedResultsController *theFetchedResultsController = 
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest 
                                        managedObjectContext:moc sectionNameKeyPath:nil 
                                                   cacheName:@"Root"];
    self.fetchedResultsController = theFetchedResultsController;
    _fetchedResultsController.delegate = self;
    
    [sort release];
    [fetchRequest release];
    [theFetchedResultsController release];
    
    return _fetchedResultsController;        
}

@end
