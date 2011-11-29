//
//  GameListViewCell.m
//  CoachTools
//
//  Created by cj on 7/9/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import "GameListViewCell.h"

@implementation GameListViewCell

@synthesize gameNumberLabel;
@synthesize opponentLabel;
@synthesize dateLabel;
@synthesize locationLabel;
@synthesize badgeView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code

    }
    
    return self;
}

#pragma mark -
#pragma mark accessors

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    badgeView.isSelected = selected;
    
    if(selected){
        gameNumberLabel.textColor = [UIColor whiteColor];
        opponentLabel.textColor = [UIColor whiteColor];
        dateLabel.textColor = [UIColor whiteColor];
        locationLabel.textColor = [UIColor whiteColor];
        
    }else{
        gameNumberLabel.textColor = [UIColor blackColor];
        opponentLabel.textColor = [UIColor blackColor];
        dateLabel.textColor = [UIColor blackColor];
        locationLabel.textColor = [UIColor blackColor];
    }
    
    
    [self.badgeView setNeedsDisplay];
    
    // Configure the view for the selected state
}


- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
    [super setHighlighted:highlighted animated:animated];
    badgeView.isSelected = highlighted;
    
    if(highlighted){
        
        gameNumberLabel.textColor = [UIColor whiteColor];
        opponentLabel.textColor = [UIColor whiteColor];
        dateLabel.textColor = [UIColor whiteColor];
        locationLabel.textColor = [UIColor whiteColor];
        
    }else{
        gameNumberLabel.textColor = [UIColor blackColor];
        opponentLabel.textColor = [UIColor blackColor];
        dateLabel.textColor = [UIColor blackColor];
        locationLabel.textColor = [UIColor blackColor];
    }
    
    [self.badgeView setNeedsDisplay];
    
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    [super setEditing:editing animated:animated];
    
    [self.badgeView setNeedsDisplay];
}

- (void)dealloc
{
    [super dealloc];
}

@end
