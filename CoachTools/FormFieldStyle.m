//
//  FormFieldStyle.m
//  CoachTools
//
//  Created by Chris Desch on 11/11/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import <IBAForms/IBAFormConstants.h>
#import "FormFieldStyle.h"


@implementation FormFieldStyle

- (id)init {
	if (self = [super init]) {
		self.labelTextColor = [UIColor blackColor];
		self.labelFont = [UIFont boldSystemFontOfSize:16];
		self.labelTextAlignment = UITextAlignmentLeft;
		self.labelFrame = CGRectMake(IBAFormFieldLabelX, 8, 160, IBAFormFieldLabelHeight); // 140
		self.valueTextAlignment = UITextAlignmentRight;
		self.valueTextColor = [UIColor colorWithRed:0.220 green:0.329 blue:0.529 alpha:1.0];
		self.valueFont = [UIFont systemFontOfSize:16];
		self.valueFrame = CGRectMake(180, 13, 130, IBAFormFieldValueHeight); //160 150
	}
	
	return self;
}

@end
