//
//  GameStartViewCell.m
//  CoachTools
//
//  Created by Chris Desch on 8/23/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import "GameStartViewCell.h"

@implementation GameStartViewCell

@synthesize playerNameLabel;
@synthesize positionLabel;

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
