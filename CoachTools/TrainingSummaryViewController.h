//
//  TrainingSummaryViewController.h
//  CoachTools
//
//  Created by Chris Desch on 10/10/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Team.h"
#import "ListSelectionViewController.h"

@class Training;

@interface TrainingSummaryViewController : UIViewController<ListSelectionDelegate>  {
    
    Training            *training;
    NSMutableDictionary *itemModel;
    UITextField         *trainingNumberTextField;
    UITextField         *locationTextField;
    UITextField         *dateTextField;
    UITextField         *descriptionView;
    UITextView          *notesView;
    NSDate              *tempDate;

}

@property (nonatomic, retain) Training              *training;
@property (nonatomic, retain) NSMutableDictionary   *itemModel;
@property (nonatomic, retain) IBOutlet UITextField  *trainingNumberTextField;
@property (nonatomic, retain) IBOutlet UITextField  *locationTextField;
@property (nonatomic, retain) IBOutlet UITextField  *dateTextField;
@property (nonatomic, retain) IBOutlet UITextField  *descriptionView;
@property (nonatomic, retain) IBOutlet UITextView   *notesView;

@property (nonatomic, retain) NSDate                *tempDate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil trainingSelected:(Training *)aTraining;

- (IBAction)attendanceButton:(id)sender;

- (void)completeEditForm:(id)sender;
- (void)cancelEditForm:(id)sender;

- (BOOL)validateItem;



@end
