//
//  GameListViewCell.h
//  CoachTools
//
//  Created by cj on 7/9/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BadgeView.h"

@interface GameListViewCell : UITableViewCell {
    UILabel *gameNumberLabel;
    UILabel *opponentLabel;
    UILabel *dateLabel;
    UILabel *locationLabel;  
    UILabel *penaltyStatLabel;
    BadgeView *badgeView;
}

@property (nonatomic, retain) IBOutlet UILabel *gameNumberLabel;
@property (nonatomic, retain) IBOutlet UILabel *opponentLabel;
@property (nonatomic, retain) IBOutlet UILabel *dateLabel; 
@property (nonatomic, retain) IBOutlet UILabel *locationLabel; 
@property (nonatomic, retain) IBOutlet UILabel *penaltyStatLabel;
@property (nonatomic, retain) IBOutlet BadgeView *badgeView;

@end
