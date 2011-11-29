//
//  PlayerListViewCell.m
//  CoachTools
//
//  Created by cj on 6/9/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import "PlayerListViewCell.h"

@implementation PlayerListViewCell

@synthesize playerNumberLabel;
@synthesize playerNameLabel;
@synthesize goalsStatLabel;
@synthesize startStatLabel;
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
        playerNumberLabel.textColor = [UIColor whiteColor];
        playerNameLabel.textColor = [UIColor whiteColor];
        goalsStatLabel.textColor = [UIColor whiteColor];
        startStatLabel.textColor = [UIColor whiteColor];
        
    }else{
        playerNumberLabel.textColor = [UIColor blackColor];
        playerNameLabel.textColor = [UIColor blackColor];
        goalsStatLabel.textColor = [UIColor blackColor];
        startStatLabel.textColor = [UIColor blackColor];
    }
    
    
    [self.badgeView setNeedsDisplay];

    // Configure the view for the selected state
}


- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
    [super setHighlighted:highlighted animated:animated];
    badgeView.isSelected = highlighted;
    
    if(highlighted){
        
        playerNumberLabel.textColor = [UIColor whiteColor];
        playerNameLabel.textColor = [UIColor whiteColor];
        goalsStatLabel.textColor = [UIColor whiteColor];
        startStatLabel.textColor = [UIColor whiteColor];
        
    }else{
        playerNumberLabel.textColor = [UIColor blackColor];
        playerNameLabel.textColor = [UIColor blackColor];
        goalsStatLabel.textColor = [UIColor blackColor];
        startStatLabel.textColor = [UIColor blackColor];
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
