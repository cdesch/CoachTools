//
//  TeamEditViewController.h
//  CoachTools
//
//  Created by Chris Desch on 1/2/12.
//  Copyright (c) 2012 Desch Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELCTextfieldCell.h"
#import "Team.h"

@protocol EditTeamDelegate;

@interface TeamEditViewController : UITableViewController <ELCTextFieldDelegate> {

    id<EditTeamDelegate> delegate;
    Team *item;
    NSArray *itemLabels;
	NSArray *itemPlaceholders;
    
}

@property (nonatomic, assign) id <EditTeamDelegate> delegate;
@property (nonatomic, retain) Team      *item;
@property (nonatomic, retain) NSArray   *itemLabels;
@property (nonatomic, retain) NSArray   *itemPlaceholders;


- (id)initWithStyle:(UITableViewStyle)style team:(Team*)team;
- (void)saveButton:(id)sender;
- (void)cancelButton:(id)sender;

@end

@protocol EditTeamDelegate <NSObject>

- (void)editingFinished:(TeamEditViewController *)teamEditViewController didAddTeam:(Team *)team;
- (void)editingCancelled:(TeamEditViewController *)teamEditViewController didAddTeam:(Team *)team;

@end