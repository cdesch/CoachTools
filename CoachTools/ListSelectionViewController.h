//
//  ListSelectionViewController.h
//  CoachTools
//
//  Created by cj on 8/1/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ListSelectionDelegate;

@interface ListSelectionViewController : UITableViewController {
    
    id<ListSelectionDelegate> delegate;
    
    NSArray *listArray;
    NSMutableArray *selectedArray;

}

@property (nonatomic,assign)id <ListSelectionDelegate> delegate;

@property (nonatomic, retain) NSArray *listArray;
@property (nonatomic, retain) NSMutableArray *selectedArray;


- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
//- (void)doneButton:(id)sender;

@end


@protocol ListSelectionDelegate <NSObject>

- (void)selectList:(ListSelectionViewController *)viewController list:(NSArray*)listSelected;
- (void)selectObject:(ListSelectionViewController *)viewController;


@end