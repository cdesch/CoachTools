//
//  AddGameViewController.m
//  CoachTools
//
//  Created by cj on 5/4/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import "AddGameViewController.h"
#import "Game.h"
#import "RootViewController.h"
#import "Season.h"
#import "Team.h"
#import "PlistStringUtil.h"
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>

@implementation AddGameViewController

@synthesize delegate;

@synthesize game;
@synthesize season;
@synthesize gameNumberTextField;
@synthesize opponentTextField;
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
    [game release];
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
    
    self.gameNumberTextField.text = [NSString stringWithFormat:@"%d", [season.games count]+1 ];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviewsf of the main view.
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
    
    self.game.gameNumber = gameNumberTextField.text;
    self.game.season = season;
    self.game.played = [NSNumber numberWithBool:FALSE];
    self.game.location = locationTextField.text;
    self.game.opponent = opponentTextField.text;
    self.game.date = tempDate;
    //Check Number of active players
    if([self validateGame])
    {
        //Add to Calendar
        
        if(intergrateCalendarSwitch.on){
            
            EKEventStore *eventDB = [[EKEventStore alloc] init];
            EKEvent *myEvent  = [EKEvent eventWithEventStore:eventDB];
            
            myEvent.title     = [NSString stringWithFormat:@"%@ - Game: %@", season.team.name, self.gameNumberTextField.text];
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
            
            self.game.eventIdentifier = myEvent.eventIdentifier;
            
            [eventDB release];
        }
        
        RootViewController *ac = [RootViewController sharedAppController];
        NSManagedObjectContext *managedObjectContext = [ac managedObjectContext];
        
        NSError *error = nil;
        if (![managedObjectContext save:&error]) {

            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }		
        
        [self.delegate addGameViewController:self didAddGame:game];
    }    
    
    // Do nothing
    
}

- (void)cancelButton:(id)sender{
    
    RootViewController *ac = [RootViewController sharedAppController];
    NSManagedObjectContext *managedObjectContext = [ac managedObjectContext];
    
	[managedObjectContext deleteObject:game];
    
	NSError *error = nil;
	if (![managedObjectContext save:&error]) {
        
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}		
    
    [self.delegate addGameViewController:self didAddGame:nil];
    
}

- (IBAction)intergrateCalendarSwitchChanged:(id)sender{
    
    //add to calendar if its on
    
}


- (BOOL)validateGame{
    
    int maxVal = 99;
    int minVal = 0;
    
    //Game Number validators
    if ([self.game.gameNumber isEqualToString:@""]) {
        //Check if empty
        NSMutableArray *msgParams = [[[NSMutableArray alloc] init] autorelease];
        [msgParams addObject:@"Game Number"];
        
        UIAlertView *someError = [[UIAlertView alloc] initWithTitle:[PlistStringUtil retrieveErrorText:@"requiredField.title" withParams:msgParams] message:[PlistStringUtil retrieveErrorText:@"requiredField.msg" withParams:msgParams] delegate: self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [someError show];
        [someError release];
        
        return FALSE;
    }else if (![self.game.gameNumber intValue]){
        //Check if number is a number

        NSMutableArray *msgParams = [[[NSMutableArray alloc] init] autorelease];
        [msgParams addObject:@"Game Number"];
        
        UIAlertView *someError = [[UIAlertView alloc] initWithTitle:[PlistStringUtil retrieveErrorText:@"numOnlyField.title" withParams:msgParams] message:[PlistStringUtil retrieveErrorText:@"numOnlyField.msg" withParams:msgParams] delegate: self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [someError show];
        [someError release];
        
        return FALSE;
    }
    
    else if (([self.game.gameNumber intValue] > maxVal) || ([self.game.gameNumber intValue] < minVal)){
        //Check if number within the range        
        NSMutableArray *msgParams = [[[NSMutableArray alloc] init] autorelease];
        [msgParams addObject:@"Game Number"];
        [msgParams addObject:[NSString stringWithFormat:@"%d", minVal]];
        [msgParams addObject:[NSString stringWithFormat:@"%d", maxVal]];
        
        UIAlertView *someError = [[UIAlertView alloc] initWithTitle:[PlistStringUtil retrieveErrorText:@"numRange.title" withParams:msgParams] message:[PlistStringUtil retrieveErrorText:@"numRange.msg" withParams:msgParams] delegate: self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [someError show];
        [someError release];
        
        return FALSE;
    }else if ([self.game.opponent isEqualToString:@""]){
        //Check if empty
        NSMutableArray *msgParams = [[[NSMutableArray alloc] init] autorelease];
        [msgParams addObject:@"Game Opponent"];
        
        UIAlertView *someError = [[UIAlertView alloc] initWithTitle:[PlistStringUtil retrieveErrorText:@"requiredField.title" withParams:msgParams] message:[PlistStringUtil retrieveErrorText:@"requiredField.msg" withParams:msgParams] delegate: self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [someError show];
        [someError release];
        
        return FALSE;
        
    }else if (self.game.date == nil){
        
        //Check if empty
        NSMutableArray *msgParams = [[[NSMutableArray alloc] init] autorelease];
        [msgParams addObject:@"Game Date"];
        
        UIAlertView *someError = [[UIAlertView alloc] initWithTitle:[PlistStringUtil retrieveErrorText:@"requiredField.title" withParams:msgParams] message:[PlistStringUtil retrieveErrorText:@"requiredField.msg" withParams:msgParams] delegate: self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [someError show];
        [someError release];
        
        return FALSE;
        
    }
    
    return TRUE;
    
    
}

@end
