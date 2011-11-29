//
//  SeasonListViewController.m
//  CoachTools
//
//  Created by cj on 8/1/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import "SeasonListViewController.h"
#import "Season.h"
#import "GameListViewController.h"
#import "RootViewController.h"
#import "SeasonSummaryViewController.h"

@implementation SeasonListViewController

@synthesize seasonArray;
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
    [seasonArray release];
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
    
    self.title = @"Seasons";
    //[self.navigationController setToolbarHidden:NO];
    // Set up the Team Selection button.
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Add Season" style:UIBarButtonItemStylePlain target:self action:@selector(add:)];
    
    self.navigationItem.rightBarButtonItem = addButton;
    [self setToolbarItems:[NSArray arrayWithObject:self.editButtonItem]];
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
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
	
	NSMutableArray *sortedSeasons = [[NSMutableArray alloc] initWithArray:[team.seasons allObjects]];
	[sortedSeasons sortUsingDescriptors:sortDescriptors];
	self.seasonArray = sortedSeasons;
    
	[sortDescriptor release];
	[sortDescriptors release];
	[sortedSeasons release];
	
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
#pragma mark Season support


- (void)add:(id)sender {
    // To add a new recipe, create a RecipeAddViewController.  Present it as a modal view so that the user's focus is on the task of adding the recipe; wrap the controller in a navigation controller to provide a navigation bar for the Done and Save buttons (added by the RecipeAddViewController in its viewDidLoad method).
    SeasonAddViewController *addController = [[SeasonAddViewController alloc] initWithNibName:@"SeasonAddViewController" bundle:nil teamSelected:team];
    addController.delegate = self;
	
    RootViewController *sharedController = [RootViewController sharedAppController];
    NSManagedObjectContext *managedObjectContext = [sharedController managedObjectContext];
	Season* newSeason = [NSEntityDescription insertNewObjectForEntityForName:@"Season" inManagedObjectContext:managedObjectContext];
	addController.season = newSeason;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:addController];
    navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    navigationController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentModalViewController:navigationController animated:YES];
    
    [navigationController release];
    [addController release];
}

- (void)seasonAddViewController:(SeasonAddViewController *)seasonAddViewController didAddSeason:(Season *)aSeason {

    if(aSeason){
        //Show the season
        
        
        [self showSeason:aSeason animated:NO];
    }
    
    // Dismiss the modal add recipe view controller
    NSLog(@"here");
    [self dismissModalViewControllerAnimated:YES];
}


- (void)showSeason:(Season *)season animated:(BOOL)animated {
    
    // Create a detail view controller, set the recipe, then push it.
    SeasonSummaryViewController *detailViewController = [[SeasonSummaryViewController alloc] initWithNibName:@"SeasonSummaryViewController" bundle:nil seasonSelected:season];
    
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
    return [self.seasonArray count];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    /*
     Team *selectedTeam = [self.teamArray objectAtIndex:indexPath.row];
     cell.textLabel.text = [selectedTeam.name description];
     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
    Season *selectedSeason = [self.seasonArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [selectedSeason.name description];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
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
        
        RootViewController *ac = [RootViewController sharedAppController];
        NSManagedObjectContext *managedObjectContext = [ac managedObjectContext];
        
        Person *selectedPlayer = [self.seasonArray objectAtIndex:indexPath.row];
        [managedObjectContext deleteObject:selectedPlayer];
        
        // Delete the managed object for the given index path
        [seasonArray removeObject:selectedPlayer];
        
        
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
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
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // Navigation logic may go here. Create and push another view controller.
    SeasonSummaryViewController *detailViewController = [[SeasonSummaryViewController alloc] initWithNibName:@"SeasonSummaryViewController" bundle:nil seasonSelected:[self.seasonArray objectAtIndex:indexPath.row]];
    // ...
    // Pass the selected object to the new view controller.
    //Team *selectedTeam = [self.teamArray objectAtIndex:indexPath.row];
    
    //((TeamSummaryViewController *)detailViewController).team = selectedTeam;
    [self.navigationController pushViewController:detailViewController animated:YES];
    
    [detailViewController release];
   
    
}
/*
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    

    
}*/

@end


