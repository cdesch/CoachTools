//
//  GameScoreViewCell.h
//  CoachTools
//
//  Created by Chris Desch on 8/23/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameScoreViewCell : UITableViewCell {
    UILabel *scoringPlayerNameLabel;
    UILabel *positionLabel;
    UILabel *assistingPlayerNameLabel;
}

@property (nonatomic, retain) IBOutlet UILabel *scoringPlayerNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *positionLabel;
@property (nonatomic, retain) IBOutlet UILabel *assistingPlayerNameLabel;

@end
