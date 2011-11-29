//
//  IBASliderField.m
//  IBAForms
//
//  Created by Chris Desch on 11/20/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import "IBASliderField.h"

@interface IBASliderField () 
- (void)sliderValueChanged:(id)sender;
@end

@implementation IBASliderField

@synthesize sliderCell = sliderCell_;

- (void)dealloc {
	IBA_RELEASE_SAFELY(sliderCell_);
	
	[super dealloc];
}

- (id)initWithKeyPath:(NSString *)keyPath title:(NSString *)title{
	if ((self = [super initWithKeyPath:keyPath title:title])) {
		//self.booleanFormFieldType = booleanFormFieldType;
	}
	
	return self;	
}

- (id)initWithKeyPath:(NSString *)keyPath title:(NSString *)title min:(int)min max:(int)max{
	if ((self = [super initWithKeyPath:keyPath title:title])) {
		//self.booleanFormFieldType = booleanFormFieldType;
	}
	
	return self;	
}
/*
-(IBAction) sliderChanged:(id) sender{

    UISlider *slider = (UISlider *) sender;
    int progressAsInt =(int)(slider.value + 0.5f);
    NSString *newText =[[NSString alloc]

                        initWithFormat:@"%d",progressAsInt];
    self.sliderLabel.text = newText;
    [newText release];
    
    
    UISlider * sd;
    UISwitch *ss;
    ss.s
}
*/
#pragma mark -
#pragma mark Cell management

- (IBAFormFieldCell *)cell {
	IBAFormFieldCell *cell = nil;
	
/*	switch (self.booleanFormFieldType) {
		case IBABooleanFormFieldTypeSwitch:
			cell = [self switchCell];
			break;
		case IBABooleanFormFieldTypeCheck:
			cell = [self checkCell];
			break;
		default:
			NSAssert(NO, @"Invalid booleanFormFieldType");
			break;
	}
*/
	cell = [self sliderCell];
	return cell;
}

- (IBASliderCell *)sliderCell {
	if (sliderCell_ == nil) {
		sliderCell_ = [[IBASliderCell alloc] initWithFormFieldStyle:self.formFieldStyle 
                                                           reuseIdentifier:@"IBASliderCell"];
        
		[sliderCell_.sliderControl addTarget:self action:@selector(sliderValueChanged:) 
                            forControlEvents:UIControlEventValueChanged];
	}
	
	return sliderCell_;
}


- (void)updateCellContents {
    /*
	switch (self.booleanFormFieldType) {
		case IBABooleanFormFieldTypeSwitch:
		{
			self.switchCell.label.text = self.title;
			[self.switchCell.switchControl setOn:[[self formFieldValue] boolValue]];
			break;
		}
		case IBABooleanFormFieldTypeCheck:
		{
			self.checkCell.label.text = self.title;
			self.checkCell.accessoryType = ([[self formFieldValue] boolValue]) ? UITableViewCellAccessoryCheckmark : 
            UITableViewCellAccessoryNone;
			break;
		}
		default:
			NSAssert(NO, @"Invalid booleanFormFieldType");
			break;
	}
     */
}

- (void)select {
    

		[self setFormFieldValue:[NSNumber numberWithInt:self.sliderCell.sliderControl.value]];
		//[self updateCellContents];
}

- (void)sliderValueChanged:(id)sender {
	if (sender == self.sliderCell.sliderControl) {
		[self setFormFieldValue:[NSNumber numberWithInt:self.sliderCell.sliderControl.value]];
	}
}                       
@end
