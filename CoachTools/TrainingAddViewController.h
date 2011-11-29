//
//  TrainingAddViewController.h
//  CoachTools
//
//  Created by Chris Desch on 10/3/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "Training.h"
#import "DateTimeSelectionViewController.h"

@protocol AddTrainingDelegate;

@class Training;

@interface TrainingAddViewController : UIViewController <DateTimeSelectionDelegate> {

    id<AddTrainingDelegate> delegate;

    Training *training;
    Season *season;
    
    IBOutlet UITextField *trainingNumberTextField;
    IBOutlet UITextField *locationTextField;
    IBOutlet UITextField *dateTextField;
    
    NSDate *tempDate;
    UISwitch *intergrateCalendarSwitch;
}

@property (nonatomic, retain) Training *training;
@property (nonatomic, retain) Season *season;
@property (nonatomic, retain) IBOutlet UITextField *trainingNumberTextField;

@property (nonatomic, retain) IBOutlet UITextField *locationTextField;
@property (nonatomic, retain) IBOutlet UITextField *dateTextField;
@property (nonatomic, retain) NSDate *tempDate;
@property (nonatomic, retain) IBOutlet UISwitch *intergrateCalendarSwitch;

@property(nonatomic,assign)id <AddTrainingDelegate> delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil seasonSelected:(Season *)aSeason;
- (IBAction)dateTextFieldClicked:(id)sender;
- (void)saveButton:(id)sender;
- (void)cancelButton:(id)sender;
- (IBAction)intergrateCalendarSwitchChanged:(id)sender;

- (BOOL)validateItem;

@end

@protocol AddTrainingDelegate <NSObject>

    - (void)addTrainingViewController:(TrainingAddViewController *)trainingAddViewController didAddTraining:(Training*)training;

@end
