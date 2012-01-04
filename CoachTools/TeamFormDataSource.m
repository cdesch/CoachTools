//
//  TeamFormDataSource.m
//  CoachTools
//
//  Created by Chris Desch on 10/23/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import "TeamFormDataSource.h"
#import <IBAForms/IBAForms.h>
#import "StringToNumberTransformer.h"
#import "FormFieldStyle.h"

@implementation TeamFormDataSource

- (id)initWithModel:(id)aModel {
	if (self = [super initWithModel:aModel]) {
        
        // Some basic form fields that accept text input
		IBAFormSection *basicFieldSection = [self addSectionWithHeaderTitle:@"Team Information" footerTitle:nil];
        basicFieldSection.formFieldStyle = [[[FormFieldStyle alloc] init] autorelease];
        
		[basicFieldSection addFormField:[[[IBATextFormField alloc] initWithKeyPath:@"name" title:@"Name"] autorelease]];

        //[basicFieldSection addFormField:[[[IBATextFormField alloc] initWithKeyPath:@"uniformColor" title:@"Uniform Color"] autorelease]];

        /*
        IBATextFormField* myfield = [[[IBATextFormField alloc] initWithKeyPath:@"uniformColor" title:@"Uniform Color"] autorelease];
        myfield.formFieldStyle = 
          */      
        
    }
    return self;
}

- (void)setModelValue:(id)value forKeyPath:(NSString *)keyPath {
	[super setModelValue:value forKeyPath:keyPath];
	
	NSLog(@"%@", [self.model description]);
}


@end
