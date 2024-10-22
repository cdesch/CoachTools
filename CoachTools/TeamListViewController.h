//
//  TeamListViewController.h
//  CoachTools
//
//  Created by cj on 5/7/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Team.h"
#import "AddTeamViewController.h"
#import "MBProgressHUD.h"


@interface TeamListViewController : UITableViewController <UINavigationControllerDelegate, UIPopoverControllerDelegate, AddTeamDelegate, UIActionSheetDelegate, MBProgressHUDDelegate, NSFetchedResultsControllerDelegate> {
    
    NSFetchedResultsController *_fetchedResultsController;
    
    MBProgressHUD *HUD;

    NSSortDescriptor *tableSortDescriptor;
    
    Team          *item;
    NSMutableDictionary *itemModel;
    
}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSSortDescriptor *tableSortDescriptor;

@property (nonatomic, retain) Team          *item;
@property (nonatomic, retain) NSMutableDictionary *itemModel;

- (void)insertItemButton:(id)sender;
- (void)sortButton:(id)sender;
- (void)sortList:(NSString *)key ascendingOrder:(BOOL)order;
- (void)generateItem;
- (void)newItem;
- (void)newItemForm;
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)showTeam:(Team *)team animated:(BOOL)animated;
- (NSArray*)fetchObjectStats:(NSString*)objectName;

@end
