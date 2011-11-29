//
//  ItemFormModel.h
//  CoachTools
//
//  Created by Chris Desch on 10/10/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemFormModel : NSObject {
    BOOL shouldAutoRotate_;
	BOOL tableViewStyleGrouped_;
	BOOL modalPresentation_;
    BOOL displayNavigationToolbar_;
	UIModalPresentationStyle modalPresentationStyle_;
}

@property (nonatomic, assign) BOOL shouldAutoRotate;
@property (nonatomic, assign) BOOL tableViewStyleGrouped;
@property (nonatomic, assign) BOOL modalPresentation;
@property (nonatomic, assign) BOOL displayNavigationToolbar;
@property (nonatomic, assign) UIModalPresentationStyle modalPresentationStyle;

@end
