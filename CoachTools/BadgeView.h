//
//  BadgeView.h
//  CoachTools
//
//  Created by Chris Desch on 8/19/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BadgeView : UIView {
    
    NSString    *badgeText_;
	UIColor     *badgeColor_;
    UIColor     *badgeTextColor_;
	UIColor     *badgeHighlightedColor_;
    BOOL        isSelected;
}

@property (nonatomic, copy)  NSString *badgeText;
@property (nonatomic, retain) UIColor *badgeColor;    
@property (nonatomic, retain) UIColor *badgeTextColor;
@property (nonatomic, retain) UIColor *badgeHighlightedColor;
@property (nonatomic, readwrite) BOOL  isSelected;


@end
