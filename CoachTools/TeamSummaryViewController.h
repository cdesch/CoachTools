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

    UITextField *nameTextField;

}

@property (nonatomic, retain) UIPopoverController *popoverController;
@property (nonatomic, retain) Team *team;

@property (nonatomic, retain) IBOutlet UITextField *nameTextField;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil teamSelected:(Team *)aTeam;


- (BOOL)validateTeam;

- (IBAction)managePlayersButton;
- (IBAction)manageSeasonButton; 

@end
