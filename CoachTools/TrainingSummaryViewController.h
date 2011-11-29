//
//  TrainingSummaryViewController.h
//  CoachTools
//
//  Created by Chris Desch on 10/10/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DateTimeSelectionViewController.h"
#import "Team.h"
#import "ListSelectionViewController.h"

@class Training;

@interface TrainingSummaryViewController : UIViewController<DateTimeSelectionDelegate, ListSelectionDelegate>  {
    
    Training *training;
    
    UITextField *trainingNumberTextField;
    UITextField *locationTextField;
    UITextField *dateTextField;
    
    NSDate *tempDate;
    
    IBOutlet UIButton *startGameButton;
    
    UISwitch *intergrateCalendarSwitch;
}

@property (nonatomic, retain) Training *training;

@property (nonatomic, retain) IBOutlet UITextField *trainingNumberTextField;
@property (nonatomic, retain) IBOutlet UITextField *locationTextField;
@property (nonatomic, retain) IBOutlet UITextField *dateTextField;
@property (nonatomic, retain) NSDate *tempDate;

@property (nonatomic, retain) IBOutlet UISwitch *intergrateCalendarSwitch;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil trainingSelected:(Training *)aTraining;

- (IBAction)dateTextFieldClicked:(id)sender;
- (IBAction)intergrateCalendarSwitchChanged:(id)sender;
- (BOOL)validateItem;



@end
