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
		/*
        IBAFormSection *basicFieldSection = [self addSectionWithHeaderTitle:@"Game Summary" footerTitle:nil];
        basicFieldSection.formFieldStyle =[[[FormFieldStyle alloc] init] autorelease];
        
        [basicFieldSection addFormField:[[[IBATextFormField alloc] initWithKeyPath:@"gameNumber" title:@"Game Number"] autorelease]];
      

        //[basicFieldSection addFormField:[[[IBABooleanFormField alloc] initWithKeyPath:@"displayNavigationToolbar" title:@"Nav Toolbar"] autorelease]];
        
        */
        //IBATextFormField* form =[[[IBATextFormField alloc] initWithKeyPath:@"gameNumber" title:@"Game Number"] autorelease];

        
        IBAFormSection *pickListSection = [self addSectionWithHeaderTitle:@"Game Options" footerTitle:nil];
        pickListSection.formFieldStyle =[[[FormFieldStyle alloc] init] autorelease];
        
		NSArray *pickListOptions = [IBAPickListFormOption pickListOptionsForStrings:[NSArray arrayWithObjects:@"7", @"8",@"9", @"11",nil]];
        //IBAPickListFormOptionsStringTransformer *transformer1 = [[[IBAPickListFormOptionsStringTransformer alloc] initWithPickListOptions:pickListOptions] autorelease];        
		[pickListSection addFormField:[[[IBAPickListFormField alloc] initWithKeyPath:@"numPlayers"
                                                                               title:@"Number of Players"
                                                                    valueTransformer:nil
                                                                       selectionMode:IBAPickListSelectionModeSingle
                                                                             options:pickListOptions] autorelease]];
        
        NSArray *gameIntervalOptions = [IBAPickListFormOption pickListOptionsForStrings:[NSArray arrayWithObjects:@"Halves", @"Quarters",nil]];
        //IBAPickListFormOptionsStringTransformer *transformer = [[[IBAPickListFormOptionsStringTransformer alloc] initWithPickListOptions:gameIntervalOptions] autorelease];  
        [pickListSection addFormField:[[[IBAPickListFormField alloc] initWithKeyPath:@"gameInterval"
                                                                               title:@"Game Interval"
                                                                    valueTransformer:nil
                                                                       selectionMode:IBAPickListSelectionModeSingle
                                                                             options:gameIntervalOptions] autorelease]];
        
        NSArray *gameIntervalTimeOptions = [IBAPickListFormOption pickListOptionsForStrings:[NSArray arrayWithObjects:@"15",@"20", @"25",@"30", @"35",@"40", @"45", @"50", @"55", @"60", nil]];
        //IBAPickListFormOptionsStringTransformer *transformer2 = [[[IBAPickListFormOptionsStringTransformer alloc] initWithPickListOptions:gameIntervalTimeOptions] autorelease];        
        [pickListSection addFormField:[[[IBAPickListFormField alloc] initWithKeyPath:@"gameIntervalTime"
                                                                               title:@"Game Interval Time"
                                                                    valueTransformer:nil
                                                                       selectionMode:IBAPickListSelectionModeSingle
                                                                             options:gameIntervalTimeOptions] autorelease]];
        
        /*
		NSArray *carListOptions = [IBAPickListFormOption pickListOptionsForStrings:[NSArray arrayWithObjects:@"Honda",
                                                                                    @"BMW",
                                                                                    @"Holden",
                                                                                    @"Ford",
                                                                                    @"Toyota",
                                                                                    @"Mitsubishi",
                                                                                    nil]];
        */
         /*
		IBAPickListFormOptionsStringTransformer *transformer = [[[IBAPickListFormOptionsStringTransformer alloc] initWithPickListOptions:carListOptions] autorelease];
		[pickListSection addFormField:[[[IBAPickListFormField alloc] initWithKeyPath:@"multiplePickListItems"
                                                                               title:@"Multiple"
                                                                    valueTransformer:transformer
                                                                       selectionMode:IBAPickListSelectionModeMultiple
                                                                             options:carListOptions] autorelease]];
 
         */
        
    }
    return self;
}

- (void)setModelValue:(id)value forKeyPath:(NSString *)keyPath {
	[super setModelValue:value forKeyPath:keyPath];
	
	NSLog(@"%@", [self.model description]);
}




@end
