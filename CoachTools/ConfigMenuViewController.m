//
//  ConfigMenuViewController.m
//  DevCoachTools
//
//  Created by cj on 3/16/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import "ConfigMenuViewController.h"
#import "CocoaHelper.h"
#import "GameManagementViewController.h"
//#import "RootViewController.h"

@implementation ConfigMenuViewController

@synthesize myPositionsView=_myPositionsView;
@synthesize myPositionsList=_myPositionsList;

@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

- (IBAction)done:(id)sender{


    //Set the formation to the based on the picker view. Send the formation to the HUD Layer
    [self.delegate setFormation:self formation:[_myPositionsList objectAtIndex:[_myPositionsView selectedRowInComponent:0]]];
    
    //Hide the ConfigMenuViewController
    [CocoaHelper hideUIViewController];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

    _myPositionsList = [[NSMutableArray alloc] init];
    
    // Path to the plist (in the application bundle)
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Formations" ofType:@"plist"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        //NSLog(@"The file exists");
    } else {
        //NSLog(@"The file does not exist");
    }
    
    NSArray *myArray = [[NSArray alloc] initWithContentsOfFile:path];
    //NSLog(@"The count: %i", [myArray count]);
    
    for(NSDictionary *dict in myArray)
    {
        NSString *numPlayers = [dict objectForKey:@"numPlayers"];
        
        //Load the formations based on the number of players in that formation
        if([numPlayers intValue] == [GameManagementViewController sharedController].numPlayers ){
            NSArray *formArray = [dict objectForKey:@"formations"];
            for(NSDictionary *formsDict in formArray)
            {
                [_myPositionsList addObject:[formsDict objectForKey:@"name"]];
            }
        }
    }
    [myArray dealloc];
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
 	if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
	   interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        
        return YES;
        
    }   
    
    //All others NO
	return NO;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_myPositionsList count];
}
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_myPositionsList objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
   // NSLog(@"Selected: %@. For Component: %i", [_myPositionsList objectAtIndex:row], component);
}

@end
