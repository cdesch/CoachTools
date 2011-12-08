//
//  TrainingFormDataSource.m
//  CoachTools
//
//  Created by Chris Desch on 10/10/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import <IBAForms/IBAForms.h>
#import "TrainingFormDataSource.h"
#import "StringToNumberTransformer.h"
#import "FormFieldStyle.h"

@implementation TrainingFormDataSource

- (id)initWithModel:(id)aModel {
	if (self = [super initWithModel:aModel]) {
        
        // Some basic form fields that accept text input
		IBAFormSection *basicFieldSection = [self addSectionWithHeaderTitle:@"Training Information" footerTitle:nil];
        basicFieldSection.formFieldStyle =[[[FormFieldStyle alloc] init] autorelease];

        
		[basicFieldSection addFormField:[[[IBATextFormField alloc] initWithKeyPath:@"trainingNumber" title:@"Number"] autorelease]];
        [basicFieldSection addFormField:[[[IBATextFormField alloc] initWithKeyPath:@"trainingDescription" title:@"Description"] autorelease]];
        [basicFieldSection addFormField:[[[IBATextFormField alloc] initWithKeyPath:@"trainingLocation" title:@"Location"] autorelease]];

        
		[basicFieldSection addFormField:[[[IBABooleanFormField alloc] initWithKeyPath:@"booleanSwitchValue" title:@"Calendar"] autorelease]];
        
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

    }
    return self;
}

- (void)setModelValue:(id)value forKeyPath:(NSString *)keyPath {
	[super setModelValue:value forKeyPath:keyPath];
	
	NSLog(@"%@", [self.model description]);
}


@end
