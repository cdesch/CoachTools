//
//  GameScoreViewCell.m
//  CoachTools
//
//  Created by Chris Desch on 8/23/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import "GameScoreViewCell.h"

@implementation GameScoreViewCell

@synthesize scoringPlayerNameLabel;
@synthesize positionLabel;
@synthesize assistingPlayerNameLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
