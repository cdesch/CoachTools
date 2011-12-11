//
//  TrainingListViewController.h
//  CoachTools
//
//  Created by Chris Desch on 9/20/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Season.h"
#import "TrainingAddViewController.h"

@interface TrainingListViewController : UITableViewController <AddTrainingDelegate,UIPopoverControllerDelegate> {
    
    NSMutableDictionary *trainingModel;
    Training            *item;
    NSMutableArray      *itemArray;
    Season              *Season;
    NSDate              *tempDate;
}

@property (nonatomic, retain) NSMutableDictionary   *trainingModel;
@property (nonatomic, retain) Training              *item;
@property (nonatomic, retain) NSMutableArray        *itemArray;
@property (nonatomic, retain) Season                *season;
@property (nonatomic, retain) NSDate                *tempDate;
 

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil seasonSelected:(Season *)aSeason;

- (void)insertItemButton:(id)sender;
- (void)showTraining:(Training *)training animated:(BOOL)animated;
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)validateDates:(Training*)itemSelected;


@end
