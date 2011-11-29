//
//  GameListViewController.h
//  CoachTools
//
//  Created by cj on 5/4/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "Team.h"
#import "Season.h"
#import "AddGameViewController.h"

@interface GameListViewController : UITableViewController <UINavigationControllerDelegate,  UIPopoverControllerDelegate, AddGameDelegate, UIActionSheetDelegate> {
    
    NSMutableDictionary *itemModel;
    NSMutableArray      *itemArray;
    Game                *item;
//    Team            *team;
    Season              *season;
    
    NSDate              *tempDate;

}
@property (nonatomic, retain) NSMutableDictionary   *itemModel;
@property (nonatomic, retain) NSMutableArray        *itemArray;
@property (nonatomic, retain) Game                  *item;
//@property (nonatomic, retain) Team              *team;
@property (nonatomic, retain) Season                *season;
@property (nonatomic, retain) NSDate                *tempDate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil seasonSelected:(Season *)aSeason;

- (void)sortButton:(id)sender;
- (void)sortList:(NSString *)key ascendingOrder:(BOOL)order;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)insertGameButton;
- (void)showGame:(Game *)game animated:(BOOL)animated;
- (void)checkCalendarDates:(Game*)aGame;

@end
