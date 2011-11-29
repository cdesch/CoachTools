//
//  GameStartViewCell.h
//  CoachTools
//
//  Created by Chris Desch on 8/23/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameStartViewCell : UITableViewCell {
    
    UILabel *playerNameLabel;
    UILabel *positionLabel;
}

@property (nonatomic, retain) IBOutlet UILabel *playerNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *positionLabel;

@end
