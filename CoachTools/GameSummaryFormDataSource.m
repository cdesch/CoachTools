//
//  GameSummaryFormDataSource.m
//  CoachTools
//
//  Created by Chris Desch on 11/20/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import "GameSummaryFormDataSource.h"
#import <IBAForms/IBAForms.h>
#import "StringToNumberTransformer.h"
#import "FormFieldStyle.h"
#import "ShowcaseButtonStyle.h"

@implementation GameSummaryFormDataSource

- (id)initWithModel:(id)aModel {
	if (self = [super initWithModel:aModel]) {
        
        // Some basic form fields that accept text input
        
        IBAFormSection *pickListSection = [self addSectionWithHeaderTitle:@"Game Options" footerTitle:nil];
        pickListSection.formFieldStyle =[[[FormFieldStyle alloc] init] autorelease];
        
		NSArray *pickListOptions = [IBAPickListFormOption pickListOptionsForStrings:[NSArray arrayWithObjects:@"7", @"8",@"9", @"11",nil]];
        IBAPickListFormOptionsStringTransformer *modalPresentationStyleTransformer = [[[IBAPickListFormOptionsStringTransformer alloc] initWithPickListOptions:pickListOptions] autorelease];
		[pickListSection addFormField:[[[IBAPickListFormField alloc] initWithKeyPath:@"numPlayers"
                                                                               title:@"Number of Players"
                                                                    valueTransformer:modalPresentationStyleTransformer
                                                                       selectionMode:IBAPickListSelectionModeSingle
                                                                             options:pickListOptions] autorelease]];
        
        NSArray *gameIntervalOptions = [IBAPickListFormOption pickListOptionsForStrings:[NSArray arrayWithObjects:@"Halves", @"Quarters",nil]];
        IBAPickListFormOptionsStringTransformer *transformer = [[[IBAPickListFormOptionsStringTransformer alloc] initWithPickListOptions:gameIntervalOptions] autorelease];  
        [pickListSection addFormField:[[[IBAPickListFormField alloc] initWithKeyPath:@"gameInterval"
                                                                               title:@"Game Interval"
                                                                    valueTransformer:transformer
                                                                       selectionMode:IBAPickListSelectionModeSingle
                                                                             options:gameIntervalOptions] autorelease]];

        NSArray *gameIntervalTimeOptions = [IBAPickListFormOption pickListOptionsForStrings:[NSArray arrayWithObjects:@"15",@"20", @"25",@"30", @"35",@"40", @"45", @"50", @"55", @"60", nil]];
        IBAPickListFormOptionsStringTransformer *transformer2 = [[[IBAPickListFormOptionsStringTransformer alloc] initWithPickListOptions:gameIntervalTimeOptions] autorelease];
    
        [pickListSection addFormField:[[[IBAPickListFormField alloc] initWithKeyPath:@"gameIntervalTime"
                                                                               title:@"Game Interval Time"
                                                                    valueTransformer:transformer2
                                                                       selectionMode:IBAPickListSelectionModeSingle
                                                                             options:gameIntervalTimeOptions] autorelease]];

    }
    return self;
}

- (void)setModelValue:(id)value forKeyPath:(NSString *)keyPath {
	[super setModelValue:value forKeyPath:keyPath];
	NSLog(@"%@", keyPath);
	NSLog(@"%@", [self.model description]);
}




@end
