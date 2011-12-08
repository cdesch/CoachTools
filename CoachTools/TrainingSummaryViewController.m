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

#import <IBAForms/IBAForms.h>
#import "ItemFormController.h"
#import "ShowcaseModel.h"
#import "TrainingFormDataSource.h"
#import "FlurryAnalytics.h"
#import "HelpManagement.h"


@implementation TrainingSummaryViewController

@synthesize training;
@synthesize itemModel;
@synthesize trainingNumberTextField;
@synthesize locationTextField;
@synthesize dateTextField;
@synthesize notesView;
@synthesize descriptionView;
@synthesize tempDate;

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
    navigationItem.title = @"Training Summary";
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.leftBarButtonItem = nil;

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];

    trainingNumberTextField.text = [training.trainingNumber stringValue];
    locationTextField.text = training.trainingLocation;
    descriptionView.text = training.trainingDescription;
    notesView.text = training.trainingNotes;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd 'at' HH:mm"];
    
    dateTextField.text = [dateFormatter stringFromDate:training.date];
    [dateFormatter release];
}


- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    training.trainingNotes = notesView.text;
    
    //Save the changes
    NSManagedObjectContext *managedObjectContext = training.managedObjectContext;
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        [FlurryAnalytics logError:@"Unresolved Error Update" message:[training debugDescription] error:error];
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }		
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    //[super setEditing:editing animated:animated];
    
    itemModel = [[NSMutableDictionary alloc] init];
    ShowcaseModel *showcaseModel = [[[ShowcaseModel alloc] init] autorelease];
    showcaseModel.shouldAutoRotate = YES;
    showcaseModel.tableViewStyleGrouped = YES;
    showcaseModel.displayNavigationToolbar = YES;
    showcaseModel.modalPresentation = YES;
    showcaseModel.modalPresentationStyle = UIModalPresentationFormSheet;
    
	// Values set on the model will be reflected in the form fields.
	//[sampleFormModel setObject:@"A value contained in the model" forKey:@"readOnlyText"];
    [itemModel setObject:training.trainingNumber forKey:@"trainingNumber"];
    if(training.trainingLocation != nil){
        [itemModel setObject:training.trainingLocation forKey:@"trainingLocation"];
    }
    
    if (training.trainingDescription != nil) {
        [itemModel setObject:training.trainingDescription forKey:@"trainingDescription"];
    }

    [itemModel setObject:training.date forKey:@"date"];    
    [itemModel setObject:training.date forKey:@"time"];
    
	TrainingFormDataSource *sampleFormDataSource = [[[TrainingFormDataSource alloc] initWithModel:itemModel] autorelease];
	ItemFormController *sampleFormController = [[[ItemFormController alloc] initWithNibName:nil bundle:nil formDataSource:sampleFormDataSource] autorelease];
	sampleFormController.title = @"Edit Training";
	sampleFormController.shouldAutoRotate = showcaseModel.shouldAutoRotate;
	sampleFormController.tableViewStyle = showcaseModel.tableViewStyleGrouped ? UITableViewStyleGrouped : UITableViewStylePlain;
    
    [[IBAInputManager sharedIBAInputManager] setInputNavigationToolbarEnabled:showcaseModel.displayNavigationToolbar];
    
	UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
	if (showcaseModel.modalPresentation) {
		UIBarButtonItem *doneButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
                                                                                     target:self 
                                                                                     action:@selector(completeEditForm:)] autorelease];
        
        UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel 
                                                                                       target:self 
                                                                                       action:@selector(cancelEditForm:)] autorelease];
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

- (void)completeEditForm:(id)sender{
    
    //Deactivate the input requestor if it was currenlty editing
    [[IBAInputManager sharedIBAInputManager] deactivateActiveInputRequestor];
    
    //Validate
    if ([self.itemModel valueForKey:@"trainingNumber"] == nil ) {
        //Check if empty
        [HelpManagement errorMessage:@"Training Number" error:@"requiredFieldEdit"];
        
    }
    else if (![[self.itemModel valueForKey:@"trainingNumber"] intValue]){
        //Check if number is a number
        [HelpManagement errorMessage:@"Training Number" error:@"numOnlyField"];
    }
    else if ([self.itemModel valueForKey:@"date"] == nil){
        
        [HelpManagement errorMessage:@"Date" error:@"requiredFieldEdit"];
        
    }else if ([self.itemModel valueForKey:@"time"] == nil){
        
        [HelpManagement errorMessage:@"Time" error:@"requiredFieldEdit"];
        
    }else{
        
        //item.gameNumber = [NSNumber numberWithInt:[[self.itemModel valueForKey:@"gameNumber"] intValue]];
        training.trainingNumber = [NSNumber numberWithInt: [[self.itemModel valueForKey:@"trainingNumber"] intValue]] ;
        training.trainingLocation = [self.itemModel valueForKey:@"trainingLocation"];
        
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
        
        training.date = tempDate;
        
        //Save the Data.
        RootViewController *ac = [RootViewController sharedAppController];
        NSManagedObjectContext *managedObjectContext = [ac managedObjectContext];
        
        NSError *error = nil;
        if (![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            [FlurryAnalytics logError:@"Unresolved Error Updating" message:[training debugDescription] error:error];
            abort();
        }
        
        //Release and refresh the views
        [self viewWillAppear:YES];
        [itemModel release];
        [self dismissModalViewControllerAnimated:YES];
    }
    
}
- (void)cancelEditForm:(id)sender{
    
    [self dismissModalViewControllerAnimated:YES];
    [itemModel release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (BOOL)validateItem{
    
    return TRUE;
}


- (IBAction)attendanceButton:(id)sender{
    
    ListSelectionViewController *listController = [[ListSelectionViewController alloc] initWithNibName:@"ListSelectionViewController" bundle:nil];
    listController.delegate = self;
    
    Team* team = self.training.season.team;
    listController.listArray = [team.players allObjects];

    if (self.training.playersAttendedSet.count > 0) {
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

- (void)selectList:(ListSelectionViewController *)viewController list:(NSArray*)listSelected;{

    //List of players selected
    
    Team* team = self.training.season.team;
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
        [FlurryAnalytics logError:@"Unresolved Error Update" message:[training debugDescription] error:error];
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
