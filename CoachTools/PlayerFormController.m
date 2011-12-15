//
//  PlayerFormController.m
//  CoachTools
//
//  Created by Chris Desch on 12/14/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import "PlayerFormController.h"

@implementation PlayerFormController

@synthesize shouldAutoRotate = shouldAutoRotate_;
@synthesize tableViewStyle = tableViewStyle_;

- (void)loadView {
	[super loadView];
    
	UIView *view = [[[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
	[view setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
	
	UITableView *formTableView = [[[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:self.tableViewStyle] autorelease];
	[formTableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
	[self setTableView:formTableView];
	
	[view addSubview:formTableView];
	[self setView:view];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return self.shouldAutoRotate;
}

@end
