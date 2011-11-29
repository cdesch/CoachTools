//
//  PlayerFormDataSource.m
//  CoachTools
//
//  Created by Chris Desch on 11/11/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//


#import <IBAForms/IBAForms.h>
#import "PlayerFormDataSource.h"
#import "StringToNumberTransformer.h"
#import "FormFieldStyle.h"

#import "ShowcaseButtonStyle.h"

@implementation PlayerFormDataSource

- (id)initWithModel:(id)aModel {
	if (self = [super initWithModel:aModel]) {
        
        // Some basic form fields that accept text input
        IBAFormSection *buttonSection = [self addSectionWithHeaderTitle:nil footerTitle:nil];
		buttonSection.formFieldStyle = [[[ShowcaseButtonStyle alloc] init] autorelease];;
		[buttonSection addFormField:[[[IBAButtonFormField alloc] initWithTitle:@"From Contacts"
																		  icon:nil
																executionBlock:^{
																	[self displaySampleForm];
																}] autorelease]];
        
		IBAFormSection *basicFieldSection = [self addSectionWithHeaderTitle:@"Add Player" footerTitle:nil];
        basicFieldSection.formFieldStyle =[[[FormFieldStyle alloc] init] autorelease];
        
        [basicFieldSection addFormField:[[[IBATextFormField alloc] initWithKeyPath:@"playerNumber" title:@"Player Number"] autorelease]];
		[basicFieldSection addFormField:[[[IBATextFormField alloc] initWithKeyPath:@"firstName" title:@"First Name"] autorelease]];
        [basicFieldSection addFormField:[[[IBATextFormField alloc] initWithKeyPath:@"lastName" title:@"Last Name"] autorelease]];
        [basicFieldSection addFormField:[[[IBATextFormField alloc] initWithKeyPath:@"email" title:@"E-Mail"] autorelease]];
        
        
		
        
        
        // Date fields
		IBAFormSection *dateFieldSection = [self addSectionWithHeaderTitle:@"Dates" footerTitle:nil];
        dateFieldSection.formFieldStyle = [[[FormFieldStyle alloc] init] autorelease];
        
		NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
		[dateFormatter setDateStyle:NSDateFormatterShortStyle];
		[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
		[dateFormatter setDateFormat:@"EEE d MMM yyyy"];
        
		[dateFieldSection addFormField:[[[IBADateFormField alloc] initWithKeyPath:@"birthdate"
                                                                            title:@"Birth Date"
                                                                     defaultValue:[NSDate date]
                                                                             type:IBADateFormFieldTypeDate
                                                                    dateFormatter:dateFormatter] autorelease]];

        
    }
    return self;
}

- (void)setModelValue:(id)value forKeyPath:(NSString *)keyPath {
	[super setModelValue:value forKeyPath:keyPath];
	
	NSLog(@"%@", [self.model description]);
}

@end
