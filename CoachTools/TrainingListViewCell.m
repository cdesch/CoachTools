//
//  TrainingListViewCell.m
//  CoachTools
//
//  Created by Chris Desch on 12/6/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import "TrainingListViewCell.h"

@implementation TrainingListViewCell

@synthesize itemNameLabel;
@synthesize dateLabel;
@synthesize locationLabel;


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
