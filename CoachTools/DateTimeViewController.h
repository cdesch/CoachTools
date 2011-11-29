//
//  DateTimeViewController.h
//  CoachTools
//
//  Created by cj on 7/31/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>
#import	"TDSemiModal.h"

@interface DateTimeViewController : TDSemiModalViewController {
    id delegate;

}

-(IBAction)saveDateEdit:(id)sender;
-(IBAction)clearDateEdit:(id)sender;
-(IBAction)cancelDateEdit:(id)sender;

@property (nonatomic, retain) IBOutlet id delegate;
@property (nonatomic, retain) IBOutlet UIDatePicker* datePicker;

@end

@interface NSObject (DateTimeViewController)
-(void)datePickerSetDate:(DateTimeViewController*)viewController;
-(void)datePickerClearDate:(DateTimeViewController*)viewController;
-(void)datePickerCancel:(DateTimeViewController*)viewController;
@end