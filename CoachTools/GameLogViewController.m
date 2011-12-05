//
//  GameLogViewController.m
//  CoachTools
//
//  Created by Chris Desch on 8/22/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import "GameLogViewController.h"
#import "Game.h"
#import "GameStart.h"
#import "GameSub.h"
#import "GameScore.h"
#import "Person.h"
#import "GameSubViewCell.h"
#import "GameStartViewCell.h"
#import "GameScoreViewCell.h"
#import "RootViewController.h"
#import "CocoaHelper.h"

@implementation GameLogViewController

@synthesize game;

@synthesize subsArray;
@synthesize scoresArray;
@synthesize startsArray;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil gameSelected:(Game *)aGame
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //NSLog(@"ViewController: %@", nibNameOrNil);
        
        //Initialize
        game = aGame;
        isGameRunning = FALSE;
    }
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil gameSelected:(Game *)aGame gameRunning:(BOOL)running
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //NSLog(@"ViewController: %@", nibNameOrNil);
        
        //Initialize
        game = aGame;

        if (running){

            isGameRunning = running;
            
            
            //self.navigationController.view.frame = CGRectMake(0, 0, 1024, 771);
            //self.view.frame = CGRectMake(0, 0, 1024, 771);
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

- (void)dealloc
{
    //DO NOT RELEASE GAME OBJECT
    [subsArray release];
    [scoresArray release];
    [startsArray release];
    [super dealloc];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Entering %s", __PRETTY_FUNCTION__);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    //NSLog(@"%d", [startsArray count]);
    //NSLog(@"Exiting %s", __PRETTY_FUNCTION__);
    
    if(isGameRunning){
        
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(closeButton:)];
        
        self.navigationItem.leftBarButtonItem = addButton;
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
        [addButton release];
    }else{
        [self setToolbarItems:[NSArray arrayWithObjects:self.editButtonItem,nil]];
    }
    
    subsArray  = [[NSMutableArray alloc] initWithArray:[game.gameSub allObjects]];
    scoresArray =  [[NSMutableArray alloc] initWithArray:[game.gameScore allObjects]];
    startsArray =  [[NSMutableArray alloc] initWithArray:[game.gameStart allObjects]];

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
    NSLog(@"Entering %s", __PRETTY_FUNCTION__);
    /*
    NSArray *itemsArray;
    itemsArray = [game.gameSub allObjects];
    subsArray = [itemsArray mutableCopy];
    itemsArray = [game.gameScore allObjects];
    scoresArray = [itemsArray mutableCopy];
    itemsArray = [game.gameStart allObjects];
    startsArray = [itemsArray mutableCopy];
     */
    /*
    subsArray  = [[NSMutableArray alloc] initWithArray:[game.gameSub allObjects]];
    scoresArray =  [[NSMutableArray alloc] initWithArray:[game.gameScore allObjects]];
    startsArray =  [[NSMutableArray alloc] initWithArray:[game.gameStart allObjects]];
*/
    //NSLog(@"Exiting %s", __PRETTY_FUNCTION__);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //NSLog(@"Exiting %s", __PRETTY_FUNCTION__);
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
    
    if (isGameRunning){
        if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
           interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
            
            return YES;
            
        }else{
            return NO;
        }
    }
 	
	return YES;
}

#pragma mark - Actions
//only when game is runnign!!!!!!!
- (void)closeButton:(id)sender{
    [self.delegate hideViewController:self];
    
    //[CocoaHelper hideUIViewController];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

//Table Section Header
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    //NSLog(@"Entering %s", __PRETTY_FUNCTION__);
    //NSLog(@"secton %d", section);
    
    NSString *title = @"";
    
    if(section == 0){
        title = @"Goals";
    }
    else if (section == 1){
        title =  @"Subs";
    }
    else if(section == 2){
        title = @"Starts";
    }
    
    //NSLog(@"title: %@", title);
    return title;
  
}

//Number of Rows in Section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"Entering %s", __PRETTY_FUNCTION__);
    //NSLog(@"secton %d", section);
    // Return the number of rows in the section.
    
    int num = 0;
    
    if (section == 0){
        num =  [scoresArray count]; 
        
    }else if (section == 1){
        num = [subsArray count];     
    }else if (section == 2){
        num = [startsArray count];

    }
    //NSLog(@"num %d", num);
    //NSLog(@"Exiting %s", __PRETTY_FUNCTION__);
    return num;
}


//Table Cell for configuration
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
/*
    if(indexPath.section == 0)
    {
        CellIdentifier  = @"GameScoreViewCell";
    }else if (indexPath.section == 1){
        CellIdentifier  = @"GameSubViewCell";
    }else if (indexPath.section == 2){
        CellIdentifier  = @"GameStartViewCell";
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
  */  
    // Configure the cell...

    NSArray *selectedArray;
    
    if(indexPath.section == 0)
    {
        CellIdentifier  = @"GameScoreViewCell";
        
        GameScoreViewCell *cell = (GameScoreViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil)
        {
            NSArray *topLevelObjects =[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:nil options:nil];
            
            for(id currentObject in topLevelObjects)
            {
                if([currentObject isKindOfClass:[UITableViewCell class]]){
                    cell = (GameScoreViewCell *) currentObject;
                }
            }
            
        }
        
        selectedArray = scoresArray;
        GameScore *item = [selectedArray objectAtIndex:indexPath.row];
        cell.scoringPlayerNameLabel.text = item.player.lastName;
        cell.positionLabel.text = item.scoringPosition;
        cell.assistingPlayerNameLabel.text = item.assistingPlayer.lastName ;
        
        return cell;

        
    }else if (indexPath.section == 1){
        
        CellIdentifier  = @"GameSubViewCell";
        
        GameSubViewCell *cell = (GameSubViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil)
        {
            NSArray *topLevelObjects =[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:nil options:nil];
            
            for(id currentObject in topLevelObjects)
            {
                if([currentObject isKindOfClass:[UITableViewCell class]]){
                    cell = (GameSubViewCell *) currentObject;
                }
            }
            
        }
        
        selectedArray = subsArray;
        GameSub *item = [selectedArray objectAtIndex:indexPath.row];
        cell.playerNameLabel.text = item.player.lastName;
        cell.positionLabel.text = item.positionName;
        cell.timeLabel.text = [NSString stringWithFormat:@"%d", [item.endTime intValue] - [item.startTime intValue]];
        
        return cell;
        
    }else if (indexPath.section == 2){
        
        
        CellIdentifier  = @"GameStartViewCell";
        
        GameStartViewCell *cell = (GameStartViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        if (cell == nil)
        {
            NSArray *topLevelObjects =[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:nil options:nil];
            
            for(id currentObject in topLevelObjects)
            {
                if([currentObject isKindOfClass:[UITableViewCell class]]){
                    cell = (GameStartViewCell *) currentObject;
                }
            }
            
        }
        
        selectedArray = startsArray;
        GameStart *item = [selectedArray objectAtIndex:indexPath.row];
        cell.playerNameLabel.text = item.player.lastName; 
        cell.positionLabel.text = item.positionName;
        
        return cell;
        
    }else {
        
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = @"Empty";

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

    
        if(indexPath.section == 0)
        {
            GameScore *item = [self.scoresArray objectAtIndex:indexPath.row];
            //NSManagedObjectContext *context = item.managedObjectContext;
            [managedObjectContext deleteObject:item];
            [self.scoresArray removeObject:item];
        }else if (indexPath.section == 1){
            GameSub *item = [self.subsArray objectAtIndex:indexPath.row];
            [managedObjectContext deleteObject:item];
            [self.subsArray removeObject:item];
        }else if(indexPath.section == 2){
            GameStart *item = [self.startsArray objectAtIndex:indexPath.row];
            [managedObjectContext deleteObject:item];
            [self.startsArray removeObject:item];
        }
        
        // Delete the row from the data source
        //
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}


@end
