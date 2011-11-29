//
//  BadgeView.m
//  CoachTools
//
//  Created by Chris Desch on 8/19/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import "BadgeView.h"
#import <QuartzCore/QuartzCore.h>



@implementation BadgeView

@synthesize badgeText = badgeText_;
@synthesize badgeColor = badgeColor_;
@synthesize badgeTextColor = badgeTextColor_;
@synthesize badgeHighlightedColor = badgeHighlightedColor_;
@synthesize isSelected;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

        
        self.backgroundColor = [UIColor clearColor];
		self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {	
    self.backgroundColor = [UIColor clearColor];
    self.layer.masksToBounds = YES;
    
	CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor *currentBadgeColor = badgeColor_;
    UIColor *currentBadgeTextColor = badgeTextColor_;
    

    if (isSelected) {
		currentBadgeColor = badgeHighlightedColor_;
        currentBadgeTextColor = [UIColor colorWithRed:2.0f/255.0f green:112.0f/255.0f blue:237.0f/255.0f alpha:1.0f];
		if (!currentBadgeColor) {
			currentBadgeColor = [UIColor whiteColor];
		}
	} 
    
    //Set Default
    if (!currentBadgeColor) {
        currentBadgeColor = [UIColor colorWithRed:0.53 green:0.6 blue:0.738 alpha:1.];
    }
        
    if(!currentBadgeTextColor ){

       currentBadgeTextColor = [UIColor whiteColor];
    }
    
    CGSize badgeTextSize = [badgeText_ sizeWithFont:[UIFont boldSystemFontOfSize:13.]];
	CGRect badgeViewFrame = CGRectIntegral(CGRectMake(rect.size.width - badgeTextSize.width - 24, (rect.size.height - badgeTextSize.height - 4) / 2, badgeTextSize.width + 14, badgeTextSize.height + 4));
		
	CGContextSaveGState(context);	
	CGContextSetFillColorWithColor(context, currentBadgeColor.CGColor);
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathAddArc(path, NULL, badgeViewFrame.origin.x + badgeViewFrame.size.width - badgeViewFrame.size.height / 2, badgeViewFrame.origin.y + badgeViewFrame.size.height / 2, badgeViewFrame.size.height / 2, M_PI / 2, M_PI * 3 / 2, YES);
    CGPathAddArc(path, NULL, badgeViewFrame.origin.x + badgeViewFrame.size.height / 2, badgeViewFrame.origin.y + badgeViewFrame.size.height / 2, badgeViewFrame.size.height / 2, M_PI * 3 / 2, M_PI / 2, YES);
    CGContextAddPath(context, path);
	CGContextDrawPath(context, kCGPathFill);
	CFRelease(path);
	CGContextRestoreGState(context);
	CGContextSaveGState(context);	

	CGContextSetBlendMode(context, kCGBlendModeNormal);
    [currentBadgeTextColor set];
    [badgeText_ drawInRect:CGRectInset(badgeViewFrame, 7, 2) withFont:[UIFont boldSystemFontOfSize:13.]];
	CGContextRestoreGState(context);
        

}



@end
