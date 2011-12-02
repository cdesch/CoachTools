//
//  GameSummaryViewController.m
//  CoachTools
//
//  Created by cj on 5/17/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import "GameSummaryViewController.h"
#import "RootViewController.h"
#import "Game.h"
#import "GameManagementViewController.h"
#import "iToast.h"
#import "GameLogViewController.h"
#import "Season.h"
#import "Team.h"
#import "PlistStringUtil.h"
#import "FlurryAnalytics.h"
#import "HelpManagement.h"
#import <IBAForms/IBAForms.h>
#import "ItemFormController.h"
#import "ShowcaseModel.h"
#import "GameFormDataSource.h"
#import "GameSummaryFormDataSource.h"

@implementation GameSummaryViewController

@synthesize itemModel;
@synthesize game;
@synthesize gameNumberTextField;
@synthesize locationTextField;
@synthesize opponentTextField;
@synthesize dateTextField;
@synthesize tempDate;
@synthesize startGameButton;
//@synthesize halfLengthControl;
//@synthesize numPlayersControl;
//@synthesize intergrateCalendarSwitch;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil gameSelected:(Game *)aGame
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //NSLog(@"ViewController: %@", nibNameOrNil);
        //NSLog(@"Enter %s", __PRETTY_FUNCTION__);
        //Initialize
        game = aGame;
        
        //numPlayers = 8;
        
    }
    return self;
}

- (void)dealloc
{
    [tempDate release];
    [locationTextField release];
    [opponentTextField release];
    [dateTextField release];
    [gameNumberTextField release];
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

    //NSLog(@"Enter %s", __PRETTY_FUNCTION__);
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UINavigationItem *navigationItem = self.navigationItem;
    navigationItem.title = @"Game Summary";
    self.navigationItem.rightBarButtonItem = self.editButtonItem;

    self.navigationItem.leftBarButtonItem = nil;
    gameNumberTextField.text = game.gameNumber;
    opponentTextField.text = game.opponent;
    locationTextField.text = game.location;
    
    //
    /*
    if(game.eventIdentifier == nil){
        
        intergrateCalendarSwitch.on = FALSE;
    
    }else{
        
        intergrateCalendarSwitch.on = TRUE;
    }
    */
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd 'at' HH:mm"];
    
    dateTextField.text = [dateFormatter stringFromDate:game.date];
    [dateFormatter release];
    
    //Check if the game has been played
    if([game.played boolValue] == FALSE)
    {
        startGameButton.titleLabel.text = @"Start Game";
        
    }else{
        startGameButton.titleLabel.text = @"Game Played";
        startGameButton.userInteractionEnabled = NO;
    }
    
    self.game.gameIntervalTime = [NSNumber numberWithInteger:30]; 
    
}

- (void)viewDidUnload
{
    self.gameNumberTextField = nil;
    self.opponentTextField = nil;
    self.locationTextField = nil;
    self.dateTextField = nil;
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    
}


- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    [super setEditing:editing animated:animated];
    /*
    //Set Editing and Hide backbutton
    gameNumberTextField.enabled = editing;
    opponentTextField.enabled = editing;
    locationTextField.enabled = editing;
    dateTextField.enabled = editing;
    
	[self.navigationItem setHidesBackButton:editing animated:YES];
    
    if (!editing) {
        
        //Reset the forms
        gameNumberTextField.borderStyle = UITextBorderStyleNone;
        opponentTextField.borderStyle = UITextBorderStyleNone;
        locationTextField.borderStyle = UITextBorderStyleNone;
        dateTextField.borderStyle = UITextBorderStyleNone;
        
        //Check if the data is validated
        if ([self validateGame]){
            
            //form data to the object
            game.gameNumber = gameNumberTextField.text;
            game.opponent = opponentTextField.text;
            game.location = locationTextField.text;
            game.date = tempDate;
            
            //Save it to the DB
            NSManagedObjectContext *context = game.managedObjectContext;
            NSError *error = nil;
            if (![context save:&error]) {
                
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                [FlurryAnalytics logError:@"Unresolved Error Update" message:[game debugDescription] error:error];
                abort();
            }else{
                //Confirm the Save to the user
                [[iToast makeText:NSLocalizedString(@"Data Saved", @"")] show];
                
            }
            
        }else{
            //Since the data did not validate, reset the form
    
            gameNumberTextField.text = game.gameNumber;
            opponentTextField.text = game.opponent;
            locationTextField.text = game.location;
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd 'at' HH:mm"];
            
            dateTextField.text = [dateFormatter stringFromDate:game.date];
            [dateFormatter release];
        }
        
    }else{
        //Show Form Boxes
        gameNumberTextField.borderStyle = UITextBorderStyleRoundedRect;
        opponentTextField.borderStyle = UITextBorderStyleRoundedRect;
        locationTextField.borderStyle = UITextBorderStyleRoundedRect;
        dateTextField.borderStyle = UITextBorderStyleRoundedRect;
    }
     
     */
    itemModel = [[NSMutableDictionary alloc] init];
    
    
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
    [itemModel setObject:game.gameNumber forKey:@"gameNumber"];
    if(game.location != nil){
        [itemModel setObject:game.location forKey:@"location"];
    }
    
    if (game.opponent != nil) {
        [itemModel setObject:game.opponent forKey:@"opponent"];
    }
    
    //[itemModel setObject:game.opponent forKey:@"linkCalendar"];
    [itemModel setObject:game.date forKey:@"date"];    
    [itemModel setObject:game.date forKey:@"time"];
    
	GameFormDataSource *sampleFormDataSource = [[[GameFormDataSource alloc] initWithModel:itemModel] autorelease];
	ItemFormController *sampleFormController = [[[ItemFormController alloc] initWithNibName:nil bundle:nil formDataSource:sampleFormDataSource] autorelease];
	sampleFormController.title = @"Edit Game";
	sampleFormController.shouldAutoRotate = showcaseModel.shouldAutoRotate;
	sampleFormController.tableViewStyle = showcaseModel.tableViewStyleGrouped ? UITableViewStyleGrouped : UITableViewStylePlain;
    
	
    [[IBAInputManager sharedIBAInputManager] setInputNavigationToolbarEnabled:showcaseModel.displayNavigationToolbar];
    
	UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
	if (showcaseModel.modalPresentation) {
		UIBarButtonItem *doneButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
         target:self 
                                                                                     action:@selector(completeEditGameForm:)] autorelease];
         
         UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel 
                                                                                       target:self 
                                                                                       action:@selector(cancelEditGameForm)] autorelease];
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

/*
- (IBAction)startGame:(id)sender{
    
    int minPlayers = numPlayers;
    int maxPlayers = 22;
    
    //Check Number of active players
    if( [self numActivePlayers:game.season.team] < minPlayers)
    {
        [HelpManagement errorMessage:[NSString stringWithFormat:@"%d", minPlayers] error:@"minPlayers"];
        //Check min players
        
    } else if ( [self numActivePlayers:game.season.team] > maxPlayers){
        //Check Max Players
        [HelpManagement errorMessage:[NSString stringWithFormat:@"%d", maxPlayers] error:@"maxPlayers"];
    }
    else {

        RootViewController *appController = [RootViewController sharedAppController];
        NSManagedObjectContext *managedObjectContext = [appController managedObjectContext];
        
        //[appController.gameTimer setGameTimer:[self.game.timeHalves intValue] warningTime:5];
        //[appController.gameTimer setGameTimer:1 warningTime:5];
        
        NSError *error = nil;
        if (![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            [FlurryAnalytics logError:@"Unresolved Error Update" message:[game debugDescription] error:error];
            abort();
        }		
        
  
    
        RootViewController *appController = [RootViewController sharedAppController];
        //Display the GameManagement with the new Game;
        GameManagementViewController *gameManagementViewController = appController.gameManagementViewController;
        gameManagementViewController.game = game;
        //FIXME Num players - Fix the datamodel
        
        gameManagementViewController.numPlayers = numPlayers;
        gameManagementViewController.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentModalViewController:gameManagementViewController animated:YES];
        
        startGameButton.userInteractionEnabled = NO;
         
    }
}
 */


- (IBAction)startGame:(id)sender{
    
    /*
    itemModel = [[NSMutableDictionary alloc] init];
    
    
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
    [itemModel setObject:game.gameNumber forKey:@"gameNumber"];
    
	GameFormDataSource *sampleFormDataSource = [[[GameFormDataSource alloc] initWithModel:itemModel] autorelease];
	ItemFormController *sampleFormController = [[[ItemFormController alloc] initWithNibName:nil bundle:nil formDataSource:sampleFormDataSource] autorelease];
	sampleFormController.title = @"Start Game";
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

     */
    
    itemModel = [[NSMutableDictionary alloc] init];
    
    
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
    [itemModel setObject:game.gameNumber forKey:@"gameNumber"];
    
	GameSummaryFormDataSource *sampleFormDataSource = [[[GameSummaryFormDataSource alloc] initWithModel:itemModel] autorelease];
	ItemFormController *sampleFormController = [[[ItemFormController alloc] initWithNibName:nil bundle:nil formDataSource:sampleFormDataSource] autorelease];
	sampleFormController.title = @"Start Game";
	sampleFormController.shouldAutoRotate = showcaseModel.shouldAutoRotate;
	sampleFormController.tableViewStyle = showcaseModel.tableViewStyleGrouped ? UITableViewStyleGrouped : UITableViewStylePlain;
    
	
    [[IBAInputManager sharedIBAInputManager] setInputNavigationToolbarEnabled:showcaseModel.displayNavigationToolbar];
    
	UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
	if (showcaseModel.modalPresentation) {
		/*UIBarButtonItem *doneButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
																					 target:self 
																					 action:@selector(completeForm)] autorelease];
*/
        UIBarButtonItem *doneButton = [[[UIBarButtonItem alloc] initWithTitle:@"Start" style:UIBarButtonItemStyleDone target:self action:@selector(completeStartGameForm)] autorelease];
        UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel 
                                                                                       target:self 
                                                                                       action:@selector(cancelStartGameForm)] autorelease];
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

- (void)completeStartGameForm{

  
    int maxPlayers = 22;

    //Check Number of active players
    if ([self.itemModel valueForKey:@"numPlayers"]  == nil){
        //Check if number is a number
        [HelpManagement errorMessage:@"Number of Players" error:@"requiredFieldEdit"];
        
    }else {
        NSSet* myNumPlayersSet = [self.itemModel valueForKey:@"numPlayers"];
        NSArray *myNumPlayersArray = [myNumPlayersSet allObjects];
        NSString* numPlayers = [myNumPlayersArray objectAtIndex:0];

        
        if( [self numActivePlayers:game.season.team] < [numPlayers intValue])
        {
            //Check min players
            [HelpManagement errorMessage:[NSString stringWithFormat:@"%d", [numPlayers intValue]] error:@"minPlayers"];
            
        } else if ( [self numActivePlayers:game.season.team] > maxPlayers){
            //Check Max Players
            [HelpManagement errorMessage:[NSString stringWithFormat:@"%d", maxPlayers] error:@"maxPlayers"];
        }else if ([self.itemModel valueForKey:@"gameInterval"] == nil){
            
            [HelpManagement errorMessage:@"Game Interval" error:@"requiredFieldEdit"];
            
        }else if ([self.itemModel valueForKey:@"gameIntervalTime"] == nil){
            
            [HelpManagement errorMessage:@"Game Interval Time" error:@"requiredFieldEdit"];
            
        }
        else{
            NSSet* GameIntervalSet = [self.itemModel valueForKey:@"gameInterval"];
            NSArray *gameIntervalArray = [GameIntervalSet allObjects];
            NSString* gameInterval = [gameIntervalArray objectAtIndex:0] ;
            
            NSSet* gameIntervalTimeSet = [self.itemModel valueForKey:@"gameIntervalTime"];
            NSArray *gameIntervalTimeArray = [gameIntervalTimeSet allObjects];
            NSString* gameIntervalTime = [gameIntervalTimeArray objectAtIndex:0];
            NSLog(@"%@",gameInterval);
            NSLog(@"%@", gameIntervalTime );
            /*if ([gameInterval isEqualToString:@"Quarters"]) {
                game.gameInterval = [NSNumber numberWithInt:4];
            }else if ([gameInterval isEqualToString:@"Halves"]) {
                game.gameInterval = [NSNumber numberWithInt:2];
            }
*/
            if ([gameInterval isEqualToString:@"Quarters"]) {
                game.gameInterval = [NSNumber numberWithInt:4];
            }else if ([gameInterval isEqualToString:@"Halves"]) {
                game.gameInterval = [NSNumber numberWithInt:2];
            }
            
            game.numPlayers = numPlayers;
            game.gameIntervalTime =[NSNumber numberWithInt:[gameIntervalTime intValue]]; 

            RootViewController *appController = [RootViewController sharedAppController];
            NSManagedObjectContext *managedObjectContext = [appController managedObjectContext];
            
            NSError *error = nil;
            if (![managedObjectContext save:&error]) {
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                [FlurryAnalytics logError:@"Unresolved Error Update" message:[game debugDescription] error:error];
                abort();
            }	
            NSLog(@"here1");
            
            //Dismiss the form view controller
            [self dismissModalViewControllerAnimated:NO];
            
            NSLog(@"here");
            //Display the GameManagement with the new Game;
            GameManagementViewController *gameManagementViewController = appController.gameManagementViewController;
            gameManagementViewController.game = game;
            //FIXME Num players - Fix the datamodel
            
            gameManagementViewController.numPlayers = [numPlayers intValue];
            gameManagementViewController.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentModalViewController:gameManagementViewController animated:YES];
            
            startGameButton.userInteractionEnabled = NO;
        }

    }
    
  
}

- (void)cancelStartGameForm{
    [self dismissModalViewControllerAnimated:YES];
    
    [itemModel release];
}

- (void)completeEditGameForm:(id)sender{
    
    //[sender resignFirstResponder];
    //[[UIApplication sharedApplication] resignFirstResponder];
//    [self.view endEditing:TRUE];

    //Validate
    
    if ([self.itemModel valueForKey:@"gameNumber"] == nil || [[self.itemModel valueForKey:@"gameNumber"] isEqualToString:@""]) {
        //Check if empty
        
        [HelpManagement errorMessage:@"Game Number" error:@"requiredFieldEdit"];
        
    }else if (![[self.itemModel valueForKey:@"gameNumber"] intValue]){
        //Check if number is a number
        [HelpManagement errorMessage:@"Game Number" error:@"numOnlyField"];
        
        
    }
    else if ([self.itemModel valueForKey:@"date"] == nil){
        
        [HelpManagement errorMessage:@"Date" error:@"requiredFieldEdit"];
        
    }else if ([self.itemModel valueForKey:@"time"] == nil){
        
        [HelpManagement errorMessage:@"Time" error:@"requiredFieldEdit"];
        
    }
    else{
        
        //item.gameNumber = [NSNumber numberWithInt:[[self.itemModel valueForKey:@"gameNumber"] intValue]];
        game.gameNumber = [self.itemModel valueForKey:@"gameNumber"];
        game.location = [self.itemModel valueForKey:@"location"];
        game.opponent = [self.itemModel valueForKey:@"opponent"];
        
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
        //dateTextField.text = [dateFormatter stringFromDate:[dateCal dateFromComponents:dateComponent]];
        //self.game.date = [dateCal dateFromComponents:dateComponent];
        tempDate =  [[dateCal dateFromComponents:dateComponent] copy];
        
        [timeCal release];
        [dateCal release];
        [dateFormatter release];
        
        game.date = tempDate;
        
        //Save the Data.
        RootViewController *ac = [RootViewController sharedAppController];
        NSManagedObjectContext *managedObjectContext = [ac managedObjectContext];
        
        NSError *error = nil;
        if (![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            [FlurryAnalytics logError:@"Unresolved Error Inserting" message:[game debugDescription] error:error];
            abort();
        }		
        
        [self dismissModalViewControllerAnimated:YES];
        //NSLog(@"Dismissed");
        //NSLog(@"%@", [self.trainingModel description]);
    }
    
}
- (void)cancelEditGameForm{
    
    [self dismissModalViewControllerAnimated:YES];
    
    [itemModel release];
}


/*
//HalfTime Length Control
- (IBAction)halfTimeLengthChanged:(id)sender{
    switch (halfLengthControl.selectedSegmentIndex) {
        case 0:
            
            self.game.timeHalves = [NSNumber numberWithInteger:30];
            break;
            
        case 1:
            self.game.timeHalves = [NSNumber numberWithInteger:45];
            break;
    }
}

//Number of players Segmented Control
- (IBAction)numPlayersChanged:(id)sender{
    switch (numPlayersControl.selectedSegmentIndex) {
        case 0:
            
            numPlayers = 8;
            break;
            
        case 1:
            numPlayers = 11;
            break;
    }
}
*/

/*
- (IBAction)intergrateCalendarSwitchChanged:(id)sender{
    if(intergrateCalendarSwitch.on){
        //Create event
        EKEventStore *eventDB = [[EKEventStore alloc] init];
        EKEvent *myEvent  = [EKEvent eventWithEventStore:eventDB];
        
        myEvent.title     = [NSString stringWithFormat:@"%@ - Game: %@", game.season.team.name, self.gameNumberTextField.text];
        myEvent.startDate = self.game.date; 
        
        myEvent.endDate   = [self.game.date dateByAddingTimeInterval:7200];
        
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
        
        NSManagedObjectContext *managedObjectContext = game.managedObjectContext;

        
        NSError *error = nil;
        if (![managedObjectContext save:&error]) {

            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            [FlurryAnalytics logError:@"Unresolved Error Update" message:[game debugDescription] error:error];
            abort();
        }		

    }else{
        
        //Delete Event
        EKEventStore *eventDB = [[EKEventStore alloc] init];
        EKEvent *myEvent  = [eventDB eventWithIdentifier:game.eventIdentifier];

        self.game.eventIdentifier = nil;
        
        [eventDB delete:myEvent];
        [eventDB release];        
        
        NSManagedObjectContext *managedObjectContext = game.managedObjectContext;
        NSError *error = nil;
        if (![managedObjectContext save:&error]) {
            
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            [FlurryAnalytics logError:@"Unresolved Error Update" message:[game debugDescription] error:error];
            abort();
        }		
    }
}
 */


- (BOOL)validateGame{
    
    int maxVal = 99;
    int minVal = 0;
    
    //Game Number validators
    if ([gameNumberTextField.text isEqualToString:@""]) {
        //Check if empty
        [HelpManagement errorMessage:@"Game Number" error:@"requiredFieldEdit"];

        return FALSE;
    }else if (![gameNumberTextField.text intValue]){
        //Check if number is a number
        [HelpManagement errorMessage:@"Game Number" error:@"numOnlyField"];
        return FALSE;
    }
    
    else if (([gameNumberTextField.text intValue] > maxVal) || ([self.game.gameNumber intValue] < minVal)){
        //Check if number within the range        
        NSMutableArray *msgParams = [[[NSMutableArray alloc] init] autorelease];
        [msgParams addObject:@"Game Number"];
        [msgParams addObject:[NSString stringWithFormat:@"%d", minVal]];
        [msgParams addObject:[NSString stringWithFormat:@"%d", maxVal]];
        
        UIAlertView *someError = [[UIAlertView alloc] initWithTitle:[PlistStringUtil retrieveErrorText:@"numRange.title" withParams:msgParams] message:[PlistStringUtil retrieveErrorText:@"numRange.msg" withParams:msgParams] delegate: self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [someError show];
        [someError release];
        
        return FALSE;
    }else if ([opponentTextField.text isEqualToString:@""]){
        //Check if empty
        NSMutableArray *msgParams = [[[NSMutableArray alloc] init] autorelease];
        [msgParams addObject:@"Game Opponent"];
        
        UIAlertView *someError = [[UIAlertView alloc] initWithTitle:[PlistStringUtil retrieveErrorText:@"requiredFieldEdit.title" withParams:msgParams] message:[PlistStringUtil retrieveErrorText:@"requiredField.msg" withParams:msgParams] delegate: self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [someError show];
        [someError release];
        
        return FALSE;
        
    }else if (dateTextField.text == nil){
        
        //Check if empty
        NSMutableArray *msgParams = [[[NSMutableArray alloc] init] autorelease];
        [msgParams addObject:@"Game Date"];
        
        UIAlertView *someError = [[UIAlertView alloc] initWithTitle:[PlistStringUtil retrieveErrorText:@"requiredFieldEdit.title" withParams:msgParams] message:[PlistStringUtil retrieveErrorText:@"requiredFieldEdit.msg" withParams:msgParams] delegate: self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [someError show];
        [someError release];
        
        return FALSE;
        
    }
    
    return TRUE;
    
    
}

- (IBAction)gameLogButton{
    
    // Navigation logic may go here. Create and push another view controller.
    GameLogViewController *listViewController = [[GameLogViewController alloc] initWithNibName:@"GameLogViewController" bundle:nil gameSelected:game];
    [self.navigationController pushViewController:listViewController animated:YES];
    [listViewController release];
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (int)numActivePlayers:(Team*)team{
    
    int num = 0;
    
    NSArray* players = [team.players allObjects];
    
    for(Person *player in players){
        if(player.activeValue){
            num ++;
        }
    }
    
    return num; //Return number of Active Players
}

@end
