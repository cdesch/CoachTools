//
//  IAPManagerViewController.h
//  CoachTools
//
//  Created by Chris Desch on 8/27/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
#import "InAppPurchaseObserver.h"

@interface IAPManagerViewController : UIViewController <SKProductsRequestDelegate> {
	InAppPurchaseObserver *inappObserver;	
	UIButton *inappButton;
    
}
@property (nonatomic, retain) InAppPurchaseObserver *inappObserver;
@property (nonatomic, retain) IBOutlet UIButton *inappButton;

-(IBAction)buyInApp:(id)sender;
- (void)doneButton:(id)sender;

@end
