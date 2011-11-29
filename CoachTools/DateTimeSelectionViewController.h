//
//  DateTimeSelectionViewController.h
//  CoachTools
//
//  Created by cj on 8/1/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol DateTimeSelectionDelegate;

@interface DateTimeSelectionViewController : UIViewController {
    
    NSDate *date;
    id <DateTimeSelectionDelegate> delegate;
}

@property (nonatomic, assign) id <DateTimeSelectionDelegate> delegate;
@property (nonatomic, retain) IBOutlet UIDatePicker* datePicker;
@property (nonatomic, retain) IBOutlet UIDatePicker* timePicker;

-(IBAction)saveDateEdit:(id)sender;
-(IBAction)clearDateEdit:(id)sender;
-(IBAction)cancelDateEdit:(id)sender;

@end


@protocol DateTimeSelectionDelegate <NSObject>

-(void)datePickerSetDate:(DateTimeSelectionViewController*)viewController;
-(void)datePickerClearDate:(DateTimeSelectionViewController*)viewController;
-(void)datePickerCancel:(DateTimeSelectionViewController*)viewController;

@end