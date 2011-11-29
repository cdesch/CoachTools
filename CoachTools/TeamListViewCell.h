//
//  TeamListViewCell.h
//  CoachTools
//
//  Created by cj on 6/8/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamListViewCell : UITableViewCell {

    IBOutlet UILabel *teamNameLabel;
    IBOutlet UILabel *winLabel;
    IBOutlet UILabel *lossLabel;
    IBOutlet UILabel *drawLabel;

    
}

@property (nonatomic, retain) IBOutlet UILabel *teamNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *winLabel;
@property (nonatomic, retain) IBOutlet UILabel *lossLabel;
@property (nonatomic, retain) IBOutlet UILabel *drawLabel;

@end
