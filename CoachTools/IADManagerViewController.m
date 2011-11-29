//
//  IADManagerViewController.m
//  CoachTools
//
//  Created by Chris Desch on 8/27/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import "IADManagerViewController.h"

@implementation IADManagerViewController

@synthesize adBannerView;
@synthesize adBannerViewIsVisible;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneButton:)];
    
    
    self.navigationItem.leftBarButtonItem = doneButton;
    
    [doneButton release];
    
    adBannerView = [[ADBannerView alloc] initWithFrame:CGRectZero];
    //adBannerView.frame = CGRectOffset(adBannerView.frame, 0, -50);
    //adBannerView.requiredContentSizeIdentifiers = [NSSet setWithObject:ADBannerContentSizeIdentifier320x50];
    //adBannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifier320x50;
    
    adBannerView.delegate=self;
    
    self.adBannerViewIsVisible=NO;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)dealloc {
    adBannerView.delegate=nil;
    [adBannerView release];
    [super dealloc];
}

- (void)doneButton:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - iAD Actions and functions
- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (!self.adBannerViewIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        // banner is invisible now and moved out of the screen on 50 px
        banner.frame = CGRectOffset(banner.frame, 0, 50);
        [UIView commitAnimations];
        self.adBannerViewIsVisible = YES;
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    if (self.adBannerViewIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        // banner is visible and we move it out of the screen, due to connection issue
        banner.frame = CGRectOffset(banner.frame, 0, -50);
        [UIView commitAnimations];
        self.adBannerViewIsVisible = NO;
    }
}

#pragma mark - Helper functions
- (int)getBannerHeight:(UIDeviceOrientation)orientation {
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        return 32;
    } else {
        return 50;
    }
}

- (int)getBannerHeight {
    return [self getBannerHeight:[UIDevice currentDevice].orientation];
}

@end
