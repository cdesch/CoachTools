//
//  IAPManagerViewController.h
//  SortIt
//
//  Created by Chris Desch on 12/16/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@protocol IAPManagerDelegate;

@interface IAPManagerViewController : UITableViewController{
    id <IAPManagerDelegate > delegate;
    MBProgressHUD *_hud;

    
}

@property (retain) id delegate;
@property (retain) MBProgressHUD *hud;

- (void)doneButton:(id)sender;
    
@end


@protocol IAPManagerDelegate <NSObject>

- (void)doneInAppPurchases:(IAPManagerViewController *)doneInAppPurchases;

@end