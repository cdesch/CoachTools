//
//  ConfigMenuViewController.h
//  DevCoachTools
//
//  Created by cj on 3/16/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//
#import "cocos2d.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol ConfigMenuViewControllerDelegate;

@interface ConfigMenuViewController : UIViewController {
    id <ConfigMenuViewControllerDelegate> delegate;
}
@property (retain) id delegate;

@property (nonatomic, retain) IBOutlet UIPickerView *myPositionsView;
@property (nonatomic, retain) NSMutableArray *myPositionsList;


- (IBAction)done:(id)sender;


@end

@protocol ConfigMenuViewControllerDelegate <NSObject>

- (void)setFormation:(ConfigMenuViewController *)setFormation formation:(NSString *)formationName;

@end
