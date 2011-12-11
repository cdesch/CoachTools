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

#import "TeamListViewCell.h"
#import "FlurryAnalytics.h"
#import "SeasonFormDataSource.h"
#import <IBAForms/IBAForms.h>
#import "ItemFormController.h"
#import "ShowcaseModel.h"
#import "HelpManagement.h"

@implementation SeasonListViewController

@synthesize itemArray;
@synthesize team;
@synthesize item;
@synthesize itemModel;


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
    [itemArray release];
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
	self.itemArray = sortedSeasons;
    
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
    RootViewController *sharedController = [RootViewController sharedAppController];
    NSManagedObjectContext *managedObjectContext = [sharedController managedObjectContext];
    item = [NSEntityDescription insertNewObjectForEntityForName:@"Season" inManagedObjectContext:managedObjectContext];
    
    itemModel = [[NSMutableDictionary alloc] init];
    
    ShowcaseModel *showcaseModel = [[[ShowcaseModel alloc] init] autorelease];
    showcaseModel.shouldAutoRotate = YES;
    showcaseModel.tableViewStyleGrouped = YES;
    showcaseModel.displayNavigationToolbar = YES;
    showcaseModel.modalPresentation = YES;
    showcaseModel.modalPresentationStyle = UIModalPresentationFormSheet;
    
	SeasonFormDataSource *sampleFormDataSource = [[[SeasonFormDataSource alloc] initWithModel:itemModel] autorelease];
	ItemFormController *sampleFormController = [[[ItemFormController alloc] initWithNibName:nil bundle:nil formDataSource:sampleFormDataSource] autorelease];
	sampleFormController.title = @"Add Season";
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
    
    //Deactivate the input requestor if it was currenlty editing
    [[IBAInputManager sharedIBAInputManager] deactivateActiveInputRequestor];
    
    //Team validators
    if  ([self.itemModel valueForKey:@"name"] == nil ||  [[self.itemModel valueForKey:@"name"] isEqualToString:@""]){
        //Check if empty
        [HelpManagement errorMessage:@"Season Name" error:@"requiredField"];
        
    }else {
        item.name = [self.itemModel valueForKey:@"name"];
        item.team = team;
        //Save the Data.
        RootViewController *ac = [RootViewController sharedAppController];
        NSManagedObjectContext *managedObjectContext = [ac managedObjectContext];
        
        NSError *error = nil;
        if (![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            [FlurryAnalytics logError:@"Unresolved Error Inserting" message:[item debugDescription] error:error];
            abort();
        }		
        
        [itemModel release];
        [self showSeason:item animated:YES];
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
    [itemModel release];
    [self dismissModalViewControllerAnimated:YES];
}


//Push the new Season after it has been added
- (void)seasonAddViewController:(SeasonAddViewController *)seasonAddViewController didAddSeason:(Season *)aSeason {

    if(aSeason){
        //Show the season
        [self showSeason:aSeason animated:NO];
    }

    [self dismissModalViewControllerAnimated:YES];
}


- (void)showSeason:(Season *)season animated:(BOOL)animated {
    
    // Create a detail view controller, set the recipe, then push it.
    SeasonSummaryViewController *detailViewController = [[SeasonSummaryViewController alloc] initWithNibName:@"SeasonSummaryViewController" bundle:nil seasonSelected:season];
    
    [self.navigationController pushViewController:detailViewController animated:animated];
    [detailViewController release];
}

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Team Name                 Win   Loss   Draw  Scheduled";
}

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
     Team *selectedTeam = [self.teamArray objectAtIndex:indexPath.row];
     cell.textLabel.text = [selectedTeam.name description];
     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
     */
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    
    Season *itemSelected = [self.itemArray objectAtIndex:indexPath.row];   
    cell.teamNameLabel.text = [itemSelected.name description];
    NSArray *objectStats = [self fetchObjectStats:itemSelected];
    cell.winLabel.text = [[objectStats objectAtIndex:0] description];
    cell.lossLabel.text = [[objectStats objectAtIndex:1] description];
    cell.drawLabel.text = [[objectStats objectAtIndex:2] description];
    cell.notPlayedLabel.text = [[objectStats objectAtIndex:3] description];
    
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
        
        Person *selectedPlayer = [self.itemArray objectAtIndex:indexPath.row];
        [managedObjectContext deleteObject:selectedPlayer];
        
        // Delete the managed object for the given index path
        [itemArray removeObject:selectedPlayer];
        
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        // Save the context.
		NSError *error;
		if (![managedObjectContext save:&error]) {
            [FlurryAnalytics logError:@"Unresolved Error Deleting" message:[selectedPlayer debugDescription] error:error];
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}

    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}


//Get the stats of the team
- (NSArray*)fetchObjectStats:(Season*)objectName{    
    
    int wins = 0; 
    int losses = 0;
    int draw = 0;
    int notPlayed = 0;

    for(Game* game in objectName.games){
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // Navigation logic may go here. Create and push another view controller.
    SeasonSummaryViewController *detailViewController = [[SeasonSummaryViewController alloc] initWithNibName:@"SeasonSummaryViewController" bundle:nil seasonSelected:[self.itemArray objectAtIndex:indexPath.row]];

    [self.navigationController pushViewController:detailViewController animated:YES];
    
    [detailViewController release];
   
    
}
/*
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    

    
}*/

@end


