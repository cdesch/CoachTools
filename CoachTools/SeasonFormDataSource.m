//
//  SeasonFormDataSource.m
//  CoachTools
//
//  Created by Chris Desch on 12/8/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import "SeasonFormDataSource.h"
#import <IBAForms/IBAForms.h>
#import "StringToNumberTransformer.h"
#import "FormFieldStyle.h"
#import "ShowcaseButtonStyle.h"


@implementation SeasonFormDataSource

- (id)initWithModel:(id)aModel {
	if (self = [super initWithModel:aModel]) {
        
        // Some basic form fields that accept text input
		IBAFormSection *basicFieldSection = [self addSectionWithHeaderTitle:@"Season Information" footerTitle:nil];
        basicFieldSection.formFieldStyle = [[[FormFieldStyle alloc] init] autorelease];
        
		[basicFieldSection addFormField:[[[IBATextFormField alloc] initWithKeyPath:@"name" title:@"Name"] autorelease]];
    }
    return self;
}

- (void)setModelValue:(id)value forKeyPath:(NSString *)keyPath {
	[super setModelValue:value forKeyPath:keyPath];
	NSLog(@"%@", keyPath);
	NSLog(@"%@", [self.model description]);
}





@end
