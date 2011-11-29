//
//  SeasonSummaryViewController.h
//  CoachTools
//
//  Created by Chris Desch on 8/30/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Season;

@interface SeasonSummaryViewController : UIViewController {
    Season *season;
    
     UITextField *seasonNameTextField;
}

@property (nonatomic, retain) Season *season;

@property (nonatomic, retain) IBOutlet UITextField *seasonNameTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil seasonSelected:(Season *)aSeason;
- (IBAction)gamesButton:(id)sender;
- (IBAction)trainingButton:(id)sender;
- (BOOL)validateSeason;

@end
