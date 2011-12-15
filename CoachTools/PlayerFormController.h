//
//  PlayerFormController.h
//  CoachTools
//
//  Created by Chris Desch on 12/14/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import <IBAForms/IBAFormViewController.h>


@interface PlayerFormController : IBAFormViewController {
	BOOL shouldAutoRotate_;
	UITableViewStyle tableViewStyle_;
}

@property (nonatomic, assign) BOOL shouldAutoRotate;
@property (nonatomic, assign) UITableViewStyle tableViewStyle;

@end
