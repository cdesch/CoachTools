//
//  TeamListViewCell.m
//  CoachTools
//
//  Created by cj on 6/8/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import "TeamListViewCell.h"

@implementation TeamListViewCell


@synthesize teamNameLabel;
@synthesize winLabel;
@synthesize lossLabel;
@synthesize drawLabel;
@synthesize notPlayedLabel;


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


- (void)dealloc
{
    [super dealloc];
}

@end
