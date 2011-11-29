//
//  SeasonListViewController.h
//  CoachTools
//
//  Created by cj on 8/1/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeasonAddViewController.h"
#import "Team.h"

@interface SeasonListViewController : UITableViewController <SeasonAddDelegate> {
    
    NSMutableArray  *seasonArray;
    Team            *team;
}


@property (nonatomic, retain) NSMutableArray    *seasonArray;
@property (nonatomic, retain) Team              *team;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil teamSelected:(Team *)aTeam;
- (void)showSeason:(Season *)season animated:(BOOL)animated;
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
