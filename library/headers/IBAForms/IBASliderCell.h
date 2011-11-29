//
//  IBASliderCell.h
//  IBAForms
//
//  Created by Chris Desch on 11/20/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import "IBAFormFieldCell.h"

@interface IBASliderCell : IBAFormFieldCell {

    UISlider *sliderControl_;
}

@property (nonatomic, retain) UISlider *sliderControl;


@end
