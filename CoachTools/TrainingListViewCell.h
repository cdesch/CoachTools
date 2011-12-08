//
//  TrainingListViewCell.h
//  CoachTools
//
//  Created by Chris Desch on 12/6/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrainingListViewCell : UITableViewCell  {
    UILabel *itemNameLabel;
    UILabel *dateLabel;
    UILabel *locationLabel;  

}

@property (nonatomic, retain) IBOutlet UILabel *itemNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *dateLabel; 
@property (nonatomic, retain) IBOutlet UILabel *locationLabel; 


@end
