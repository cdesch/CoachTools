//
//  IAPManagerViewController.m
//  CoachTools
//
//  Created by Chris Desch on 8/27/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import "IAPManagerViewController.h"

@implementation IAPManagerViewController

@synthesize inappObserver;
@synthesize inappButton;

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

    inappObserver = [[InAppPurchaseObserver alloc] init];
    
	if ([SKPaymentQueue canMakePayments]) {
		// Yes, In-App Purchase is enabled on this device!
		// Proceed to fetch available In-App Purchase items.
		//Shared Secret
        //d007c1e229a3429695798317964f6206

		// Replace "Your IAP Product ID" with your actual In-App Purchase Product ID,
		// fetched from either a remote server or stored locally within your app. 
		SKProductsRequest *prodRequest= [[SKProductsRequest alloc] initWithProductIdentifiers: [NSSet setWithObject: @"com.cdesch.CoachTools.BeerMoney"]];
		prodRequest.delegate = self;
		[prodRequest start];
		
	} else {
		// Notify user that In-App Purchase is disabled via button text.
		[inappButton setTitle:@"In-App Purchase is Disabled" forState:UIControlStateNormal];
		inappButton.enabled = NO;
	}	
	
    
    
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
	[inappButton release];
	[inappObserver release];
    [super dealloc];
}


#pragma mark - actions 

- (void)doneButton:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}



// Store Kit returns a response from an SKProductsRequest.
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    
	// Populate the inappBuy button with the received product info.
	SKProduct *validProduct = nil;
	int count = [response.products count];
	if (count>0) {
		validProduct = [response.products objectAtIndex:0];
	}
	if (!validProduct) {
		[inappButton setTitle:@"No Products Available" forState:UIControlStateNormal];
		inappButton.enabled = NO;
		return;
	}
	
	NSString *buttonText = [[NSString alloc] initWithFormat:@"%@ - Buy %@", validProduct.localizedTitle, validProduct.price];
	[inappButton setTitle:buttonText forState:UIControlStateNormal];
	inappButton.enabled = YES;
	[buttonText release];
}

// When the buy button is clicked, start In-App Purchase process.
-(IBAction)buyInApp:(id)sender {
	
	// Replace "Your IAP Product ID" with your actual In-App Purchase Product ID.
	SKPayment *paymentRequest = [SKPayment paymentWithProductIdentifier: @"com.cjdesch.CoachTools"]; 
    
	// Assign an Observer class to the SKPaymentTransactionObserver,
	// so that it can monitor the transaction status.
	[[SKPaymentQueue defaultQueue] addTransactionObserver:inappObserver];
	
	// Request a purchase of the selected item.
	[[SKPaymentQueue defaultQueue] addPayment:paymentRequest];
    
}

@end
