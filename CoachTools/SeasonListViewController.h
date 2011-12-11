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
#import "Season.h"

@interface SeasonListViewController : UITableViewController <SeasonAddDelegate> {
    
    NSMutableArray  *itemArray;
    Team            *team;
    
    Season          *item;
    NSMutableDictionary *itemModel;
}

@property (nonatomic, retain) NSMutableArray    *itemArray;
@property (nonatomic, retain) Team              *team;
@property (nonatomic, retain) Season          *item;
@property (nonatomic, retain) NSMutableDictionary *itemModel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil teamSelected:(Team *)aTeam;

- (void)completeForm;
- (void)cancelForm;
- (void)showSeason:(Season *)season animated:(BOOL)animated;
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (NSArray*)fetchObjectStats:(Season*)objectName;

@end
