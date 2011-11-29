//
//  IBASliderField.h
//  IBAForms
//
//  Created by Chris Desch on 11/20/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//
#import "IBAFormField.h"
#import "IBASliderCell.h"

/*
typedef enum {
	IBABooleanFormFieldTypeSwitch = 0,
	IBABooleanFormFieldTypeCheck,
} IBABooleanFormFieldType;
*/

@interface IBASliderField : IBAFormField{
    IBASliderCell *sliderCell_;
}

@property (nonatomic, readonly) IBASliderCell *sliderCell;
//@property (nonatomic, assign) IBABooleanFormFieldType booleanFormFieldType;
- (id)initWithKeyPath:(NSString *)keyPath title:(NSString *)title;
- (id)initWithKeyPath:(NSString *)keyPath title:(NSString *)title min:(int)min max:(int)max;

/*
- (id)initWithKeyPath:(NSString *)keyPath title:(NSString *)title type:(IBABooleanFormFieldType)booleanFormFieldType;
- (id)initWithKeyPath:(NSString *)keyPath title:(NSString *)title valueTransformer:(NSValueTransformer *)valueTransformer type:(IBABooleanFormFieldType)booleanFormFieldType;
*/

@end
