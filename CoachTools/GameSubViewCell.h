//
//  GameSubViewCells.h
//  CoachTools
//
//  Created by Chris Desch on 8/23/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameSubViewCell : UITableViewCell{
    
    UILabel *playerNameLabel;
    UILabel *positionLabel;
    UILabel *timeLabel;
    
}

@property (nonatomic, retain) IBOutlet UILabel *playerNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *positionLabel;
@property (nonatomic, retain) IBOutlet UILabel *timeLabel;

@end
