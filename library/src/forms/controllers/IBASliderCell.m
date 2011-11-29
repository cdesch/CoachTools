//
//  IBASliderCell.m
//  IBAForms
//
//  Created by Chris Desch on 11/20/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import "IBASliderCell.h"
#import "IBAFormConstants.h"

@implementation IBASliderCell

@synthesize sliderControl = sliderControl_;

- (void)dealloc {
	IBA_RELEASE_SAFELY(sliderControl_);
    
	[super dealloc];
}

- (id)initWithFormFieldStyle:(IBAFormFieldStyle *)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithFormFieldStyle:style reuseIdentifier:reuseIdentifier])) {
		sliderControl_ = [[UISlider alloc] initWithFrame:CGRectZero];
        sliderControl_.minimumValue = 0;
        sliderControl_.maximumValue = 50;
        sliderControl_.continuous = YES;
        sliderControl_.value = 25;
		[self.cellView addSubview:sliderControl_];
		sliderControl_.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
		sliderControl_.frame = CGRectMake(style.valueFrame.origin.x + style.valueFrame.size.width - sliderControl_.bounds.size.width,
										  ceil((self.bounds.size.height - sliderControl_.bounds.size.height)/2),
										  sliderControl_.bounds.size.width,
										  sliderControl_.bounds.size.height);
	}
    /*
    CGRect frame = CGRectMake(0.0, 0.0, 200.0, 10.0);
    UISlider *slider = [[UISlider alloc] initWithFrame:frame];
    [slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [slider setBackgroundColor:[UIColor clearColor]];
    slider.minimumValue = 0.0;
    slider.maximumValue = 50.0;
    slider.continuous = YES;
    slider.value = 25.0;
    */
    return self;
}
@end
