//
//  IADManagerViewController.h
//  CoachTools
//
//  Created by Chris Desch on 8/27/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iAd/ADBannerView.h"


@interface IADManagerViewController : UIViewController <ADBannerViewDelegate>{

    ADBannerView *adBannerView;
    BOOL adBannerViewIsVisible;
}


@property (nonatomic, retain) IBOutlet ADBannerView * adBannerView;
@property (nonatomic) BOOL adBannerViewIsVisible;
- (void)doneButton:(id)sender;

@end
