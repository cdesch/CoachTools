//
//  PlayerListViewCell.h
//  CoachTools
//
//  Created by cj on 6/9/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BadgeView.h"

@interface PlayerListViewCell : UITableViewCell {
    IBOutlet UILabel *playerNumberLabel;
    IBOutlet UILabel *playerNameLabel;
    IBOutlet UILabel *startStatLabel;
    IBOutlet UILabel *goalsStatLabel;
    IBOutlet UILabel *assistStatLabel;
    IBOutlet UILabel *penaltyStatLabel;
    BadgeView *badgeView;
}

@property (nonatomic, retain) IBOutlet UILabel *playerNumberLabel;
@property (nonatomic, retain) IBOutlet UILabel *playerNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *startStatLabel;
@property (nonatomic, retain) IBOutlet UILabel *goalsStatLabel;
@property (nonatomic, retain) IBOutlet UILabel *assistStatLabel;
@property (nonatomic, retain) IBOutlet UILabel *penaltyStatLabel;
@property (nonatomic, retain) IBOutlet BadgeView *badgeView;


@end
