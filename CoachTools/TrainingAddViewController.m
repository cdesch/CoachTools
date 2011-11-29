//
//  TrainingAddViewController.m
//  CoachTools
//
//  Created by Chris Desch on 10/3/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//




#import "TrainingAddViewController.h"
#import "Training.h"
#import "RootViewController.h"
#import "Season.h"
#import "Team.h"
#import "PlistStringUtil.h"
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>

@implementation TrainingAddViewController


@synthesize delegate;

@synthesize training;
@synthesize season;
@synthesize trainingNumberTextField;
@synthesize locationTextField;
@synthesize dateTextField;
@synthesize tempDate;
@synthesize intergrateCalendarSwitch;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil seasonSelected:(Season *)aSeason
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //NSLog(@"%s", __PRETTY_FUNCTION__);
        //NSLog(@"ViewController: %@", nibNameOrNil);
        //Initialize
        season = aSeason;
        
        
    }
    return self;
}

- (void)dealloc
{
    [tempDate release];
    [training release];
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
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(saveButton:)];
    
    self.navigationItem.rightBarButtonItem = addButton;
    [addButton release];
    
    UIBarButtonItem *cancelButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelButton:)];
    self.navigationItem.leftBarButtonItem = cancelButtonItem;
    [cancelButtonItem release];
    
    self.trainingNumberTextField.text = [NSString stringWithFormat:@"%d", [season.training count]+1 ];
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

#pragma mark -
#pragma mark User Actions

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

#pragma mark -
#pragma mark Button Actions

- (void)saveButton:(id)sender{
    
    self.training.trainingNumber = [NSNumber numberWithInt:[trainingNumberTextField.text intValue]];
    self.training.season = season;
    self.training.trainingLocation = locationTextField.text;
    self.training.date = tempDate;
    
    
    //Check Number of active players
    if([self validateItem])
    {
        //Add to Calendar
        
        if(intergrateCalendarSwitch.on){
            
            
            EKEventStore *eventDB = [[EKEventStore alloc] init];
            EKEvent *myEvent  = [EKEvent eventWithEventStore:eventDB];
            
            myEvent.title     = [NSString stringWithFormat:@"%@ - Training: %@", season.team.name, self.trainingNumberTextField.text];
            myEvent.startDate = tempDate; 
            
            myEvent.endDate   = [tempDate dateByAddingTimeInterval:7200];
            
            //myEvent.allDay = YES;
            [myEvent setCalendar:[eventDB defaultCalendarForNewEvents]];
            
            
            
            
            NSError *err;
            [eventDB saveEvent:myEvent span:EKSpanThisEvent error:&err];
            
            if (err != noErr) {
                
                
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle:@"Error saving Entry to calendar"
                                      message:@"Not saved!"
                                      delegate:nil
                                      cancelButtonTitle:@"Okay"
                                      otherButtonTitles:nil];
                [alert show];
                [alert release];
                
                
            }
            
            self.training.eventIdentifier = myEvent.eventIdentifier;
            
            [eventDB release];
        }
        
        RootViewController *ac = [RootViewController sharedAppController];
        NSManagedObjectContext *managedObjectContext = [ac managedObjectContext];
        
        NSError *error = nil;
        if (![managedObjectContext save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.  
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }		
        
        [self.delegate addTrainingViewController:self didAddTraining:training];
    }    
    
    // Do nothing
    
}

- (void)cancelButton:(id)sender{
    
    RootViewController *ac = [RootViewController sharedAppController];
    NSManagedObjectContext *managedObjectContext = [ac managedObjectContext];
    
	[managedObjectContext deleteObject:training];
    
	NSError *error = nil;
	if (![managedObjectContext save:&error]) {
        
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}		
    
    [self.delegate addTrainingViewController:self didAddTraining:nil];
    
}

- (IBAction)intergrateCalendarSwitchChanged:(id)sender{
    
    //add to calendar if its on
    
}

- (BOOL)validateItem{

    
    return TRUE;
    
}


@end
