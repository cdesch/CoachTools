//
//  TrainingSummaryViewController.m
//  CoachTools
//
//  Created by Chris Desch on 10/10/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import "TrainingSummaryViewController.h"
#import "RootViewController.h"
#import "Training.h"
#import "Season.h"
#import "Team.h"
#import "ListSelectionViewController.h"
#import "Person.h"

@implementation TrainingSummaryViewController

@synthesize training;
@synthesize trainingNumberTextField;
@synthesize locationTextField;
@synthesize dateTextField;
@synthesize tempDate;
@synthesize intergrateCalendarSwitch;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil trainingSelected:(Training *)aTraining
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //NSLog(@"ViewController: %@", nibNameOrNil);
        
        //Initialize
        training = aTraining;
        
        
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
    [tempDate release];
    [locationTextField release];
    [dateTextField release];
    [trainingNumberTextField release];
    [super dealloc];
    
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UINavigationItem *navigationItem = self.navigationItem;
    navigationItem.title = @"Game Summary";
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.leftBarButtonItem = nil;
    //self.navigationItem.backBarButtonItem = self.backButtonItem;
    trainingNumberTextField.text = [training.trainingNumber stringValue];
    locationTextField.text = training.trainingLocation;
    
    //
    if(training.eventIdentifier == nil){
        
        intergrateCalendarSwitch.on = FALSE;
        
    }else{
        
        intergrateCalendarSwitch.on = TRUE;
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd 'at' HH:mm"];
    
    dateTextField.text = [dateFormatter stringFromDate:training.date];
    [dateFormatter release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}


- (IBAction)dateTextFieldClicked:(id)sender {
	DateTimeSelectionViewController *dateSelection = [[DateTimeSelectionViewController alloc] initWithNibName:@"DateTimeSelectionViewController" bundle:nil];
    dateSelection.delegate = self;
    dateSelection.modalPresentationStyle = UIModalPresentationFormSheet;
    dateSelection.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:dateSelection animated:YES];
    
    [dateSelection release];
}


#pragma mark -
#pragma mark Date Picker Delegate

- (void)datePickerSetDate:(DateTimeSelectionViewController*)viewController {
    
    //Retrieve Components of the date
    NSCalendar *dateCal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComponent = [dateCal components:( NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekCalendarUnit | NSWeekdayCalendarUnit |NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:viewController.datePicker.date];
    
    NSCalendar *timeCal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *timeComponent = [timeCal components:( NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:viewController.timePicker.date];
    
    // adjust them for first day of previous week (Monday)
    [dateComponent setHour:[timeComponent hour]];
    [dateComponent setMinute:[timeComponent minute]];
    
    //Format Date for display
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    
    // construct new date and return
    dateTextField.text = [dateFormatter stringFromDate:[dateCal dateFromComponents:dateComponent]];
	//self.game.date = [dateCal dateFromComponents:dateComponent];
    tempDate =  [[dateCal dateFromComponents:dateComponent] copy];
    
    [timeCal release];
    [dateCal release];
    [dateFormatter release];
    
    [self dismissModalViewControllerAnimated:YES];
    
}

- (void)datePickerClearDate:(DateTimeSelectionViewController*)viewController {
	
    dateTextField.text = nil;
	
    [self dismissModalViewControllerAnimated:YES];
}

- (void)datePickerCancel:(DateTimeSelectionViewController*)viewController {
    
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)intergrateCalendarSwitchChanged:(id)sender{
    
}

- (BOOL)validateItem{
    
    return TRUE;
}


- (IBAction)attendanceButton:(id)sender{
    
    ListSelectionViewController *listController = [[ListSelectionViewController alloc] initWithNibName:@"ListSelectionViewController" bundle:nil];
    listController.delegate = self;
	
    
    Team* team = self.training.season.team;
    listController.listArray = [[team.players allObjects] copy];
    
    if (training.playersAttendedSet.count > 0) {
        NSLog(@"assign Existing array");
        listController.selectedArray = [[training.playersAttended allObjects] mutableCopy];
        //listController.selectedArray = [training.playersAttended allObjects];
        
    }
    
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:listController];
    navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    navigationController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentModalViewController:navigationController animated:YES];
    
    [navigationController release];
    [listController release];
    
}

- (void)selectList:(ListSelectionViewController *)viewController list:(NSArray*)listSelected;
{


    //List of players selected
    NSLog(@"Selected Player");
    
    Team* team = self.training.season.team;
    //NSArray* teamPlayers = [team.players allObjects];
    //Remove all players from that training sessino
    for(Person *player in [team.players allObjects] ){
    
        NSMutableSet* playerTraining = player.trainingSet;
        if([playerTraining containsObject:training]){
            [playerTraining removeObject:training];
        }
    }
    
    //Add the training to the player
    for (Person *player in listSelected){
        NSMutableSet* playerTraining = player.trainingSet;
        [playerTraining addObject:training];
        player.training = playerTraining;
        //Create a new entry for them 
    }
    
    training.playersAttended = [NSSet setWithArray:listSelected];
    
    //Save the changes
    NSManagedObjectContext *managedObjectContext = training.managedObjectContext;
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }		
    
    [listSelected release];
    
    [self dismissModalViewControllerAnimated:YES];

    
}

- (void)selectObject:(ListSelectionViewController *)viewController{
    //DO NOTHING
}



@end
