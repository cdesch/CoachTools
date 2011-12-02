//
//  GameFormDataSource.m
//  CoachTools
//
//  Created by Chris Desch on 11/11/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import <IBAForms/IBAForms.h>
#import "GameFormDataSource.h"
#import "StringToNumberTransformer.h"
#import "FormFieldStyle.h"

#import "ShowcaseButtonStyle.h"
#import "ShowcaseModel.h"
#import "ItemFormController.h"
#import "GameSummaryFormDataSource.h"

@implementation GameFormDataSource

- (id)initWithModel:(id)aModel {
	if (self = [super initWithModel:aModel]) {
        
        // Some basic form fields that accept text input
		IBAFormSection *basicFieldSection = [self addSectionWithHeaderTitle:@"Add Game" footerTitle:nil];
        basicFieldSection.formFieldStyle =[[[FormFieldStyle alloc] init] autorelease];
        
        [basicFieldSection addFormField:[[[IBATextFormField alloc] initWithKeyPath:@"gameNumber" title:@"Game Number"] autorelease]];
		[basicFieldSection addFormField:[[[IBATextFormField alloc] initWithKeyPath:@"location" title:@"Location"] autorelease]];
        [basicFieldSection addFormField:[[[IBATextFormField alloc] initWithKeyPath:@"opponent" title:@"Opponent"] autorelease]];
        [basicFieldSection addFormField:[[[IBABooleanFormField alloc] initWithKeyPath:@"linkCalendar" title:@"Link Calendar"] autorelease]];
        //[basicFieldSection addFormField:[[[IBASliderField alloc] initWithKeyPath:@"Slider" title:@"Slider"] autorelease]];

        // Date fields
		IBAFormSection *dateFieldSection = [self addSectionWithHeaderTitle:@"Dates" footerTitle:nil];
        dateFieldSection.formFieldStyle = [[[FormFieldStyle alloc] init] autorelease];

		NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
		[dateFormatter setDateStyle:NSDateFormatterShortStyle];
		[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
		[dateFormatter setDateFormat:@"EEE d MMM yyyy"];
        
		[dateFieldSection addFormField:[[[IBADateFormField alloc] initWithKeyPath:@"date"
                                                                            title:@"Date"
                                                                     defaultValue:[NSDate date]
                                                                             type:IBADateFormFieldTypeDate
                                                                    dateFormatter:dateFormatter] autorelease]];
        
		NSDateFormatter *timeFormatter = [[[NSDateFormatter alloc] init] autorelease];
		[timeFormatter setDateStyle:NSDateFormatterShortStyle];
		[timeFormatter setTimeStyle:NSDateFormatterNoStyle];
		[timeFormatter setDateFormat:@"h:mm a"];
        
		[dateFieldSection addFormField:[[[IBADateFormField alloc] initWithKeyPath:@"time"
                                                                            title:@"Time"
                                                                     defaultValue:[NSDate date]
                                                                             type:IBADateFormFieldTypeTime
                                                                    dateFormatter:timeFormatter] autorelease]];
        /*
        NSArray *modalPresentationStyleOptions = [IBAPickListFormOption pickListOptionsForStrings:[NSArray arrayWithObjects:
                                                                                                   @"Full Screen", 
                                                                                                   @"Page Sheet",
                                                                                                   @"Form Sheet", 
                                                                                                   @"Current Context",
                                                                                                   nil]];	
		IBASingleIndexTransformer *modalPresentationStyleTransformer = [[[IBASingleIndexTransformer alloc] initWithPickListOptions:modalPresentationStyleOptions] autorelease];
		[basicFieldSection addFormField:[[[IBAPickListFormField alloc] initWithKeyPath:@"modalPresentationStyle"
                                                                                 title:@"Modal Style"
                                                                      valueTransformer:modalPresentationStyleTransformer
                                                                         selectionMode:IBAPickListSelectionModeSingle
                                                                               options:modalPresentationStyleOptions] autorelease]];	
		*/
		/*
		IBAFormSection *buttonSection = [self addSectionWithHeaderTitle:nil footerTitle:nil];
		buttonSection.formFieldStyle = [[[ShowcaseButtonStyle alloc] init] autorelease];;
		[buttonSection addFormField:[[[IBAButtonFormField alloc] initWithTitle:@"Start Game"
																		  icon:nil
																executionBlock:^{
																	[self displaySampleForm];
																}] autorelease]];
        */
        


    }
    return self;
}

- (void)setModelValue:(id)value forKeyPath:(NSString *)keyPath {
	[super setModelValue:value forKeyPath:keyPath];
	
	NSLog(@"%@", [self.model description]);
}





@end
