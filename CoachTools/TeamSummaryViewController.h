//
//  TeamSummaryViewController.h
//  CoachTools
//
//  Created by cj on 5/7/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Team;

@interface TeamSummaryViewController : UIViewController <UIPopoverControllerDelegate> {

    Team *team;
    NSMutableDictionary *itemModel;

    UITextField *nameTextField;
    UITextField *uniformColorTextField;
    UITextField *locationTextField;

}

@property (nonatomic, retain) UIPopoverController *popoverController;
@property (nonatomic, retain) Team *team;
@property (nonatomic, retain) NSMutableDictionary *itemModel;

@property (nonatomic, retain) IBOutlet UITextField *nameTextField;
@property (nonatomic, retain) IBOutlet UITextField *uniformColorTextField;
@property (nonatomic, retain) IBOutlet UITextField *locationTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil teamSelected:(Team *)aTeam;

- (BOOL)validateTeam;

- (void)completeEditForm:(id)sender;
- (void)cancelEditForm:(id)sender;

- (IBAction)managePlayersButton;
- (IBAction)manageSeasonButton; 

@end
