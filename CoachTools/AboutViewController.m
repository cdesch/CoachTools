//
//  AboutViewController.m
//  CoachTools
//
//  Created by cj on 7/28/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import "AboutViewController.h"
#import "Crittercism.h"


@implementation AboutViewController

@synthesize delegate;
@synthesize appNameLabel;
@synthesize versionLabel;
@synthesize buildVersionLabel;
@synthesize message;

@synthesize subjectLine;
@synthesize emailLine;
@synthesize bodyMessage;
@synthesize versionString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [message release];
    [super dealloc];
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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.appNameLabel.text = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
    self.versionLabel.text = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    self.buildVersionLabel = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBuildNumber"];
    
    versionString = [NSString stringWithFormat:@"V.%@ Build.%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBuildNumber"]];
    
    subjectLine = [NSString stringWithFormat:@"CoachTools: Contact - %@", versionString];
    emailLine = @"coachtoolsapps@gmail.com";
    bodyMessage = [NSString stringWithFormat:@"CoachTools: Contact - %@", versionString];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.versionString = nil;
    self.message = nil;
    self.subjectLine = nil;
    self.emailLine = nil;
    self.bodyMessage = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark -
#pragma mark Actions

- (IBAction)showPicker:(id)sender
{
    //Setup Message
    subjectLine = [NSString stringWithFormat:@"CoachTools: Contact - %@", versionString];
    emailLine = @"coachtoolsapps@gmail.com";
    bodyMessage = [NSString stringWithFormat:@"CoachTools: Contact - %@ \n\n Email: \n Contact: Purpose \n Subject: \n \n Description:", versionString];
    
	// This sample can run on devices running iPhone OS 2.0 or later  
	// The MFMailComposeViewController class is only available in iPhone OS 3.0 or later. 
	// So, we must verify the existence of the above class and provide a workaround for devices running 
	// earlier versions of the iPhone OS. 
	// We display an email composition interface if MFMailComposeViewController exists and the device can send emails.
	// We launch the Mail application on the device, otherwise.
	
	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil){
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail]){
			[self displayComposerSheet];
		}
		else{
			[self launchMailAppOnDevice];
		}
	}
	else{
		[self launchMailAppOnDevice];
	}
}

- (IBAction)reportBug:(id)sender
{
    //Setup Message
    subjectLine = [NSString stringWithFormat:@"CoachTools: Report Bug - %@", versionString];
    emailLine = @"coachtoolsapps@gmail.com";
    bodyMessage = [NSString stringWithFormat:@"CoachTools: Report Bug - %@ \n \n Error Message: \n \n Error Description: \n \n What steps will reproduce the problem?\n 1. \n 2. \n 3. \n\n\n What is the expected result? \n\n\n What happens instead? \n\n\n Please provide any additional information below. Attach a screenshot if possible.", versionString];
    
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil){
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail]){
			[self displayComposerSheet];
		}
		else{
			[self launchMailAppOnDevice];
		}
	}
	else{
		[self launchMailAppOnDevice];
	}
}

- (IBAction)requestEnhancement:(id)sender{
    
    //Setup Message
    subjectLine = [NSString stringWithFormat:@"CoachTools: Request Enhancement -  %@", versionString];
    emailLine = @"coachtoolsapps@gmail.com";
    bodyMessage = [NSString stringWithFormat:@"CoachTools:  Request Enhancement - %@ \n\n\n What problem are you trying to resolve with this feature? \n\n\n How do you address this problem now? \n\n\n Please describe the feature in as much detail as possible: \n\n\n Is there anything else you would like to tell us?", versionString];
    
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil)
	{
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail]){
			[self displayComposerSheet];
		}
		else
		{
			[self launchMailAppOnDevice];
		}
	}
	else
	{
		[self launchMailAppOnDevice];
	}
}

#pragma mark -
#pragma mark Compose Mail

// Displays an email composition interface inside the application. Populates all the Mail fields. 
- (void)displayComposerSheet 
{
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
    
	[picker setSubject:subjectLine];
    
	// Set up recipients
	NSArray *toRecipients = [NSArray arrayWithObject:emailLine]; 
	//NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil]; 
	//NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com"]; 
	
	[picker setToRecipients:toRecipients];
	//[picker setCcRecipients:ccRecipients];	
	//[picker setBccRecipients:bccRecipients];
	
	// Attach an image to the email
	//NSString *path = [[NSBundle mainBundle] pathForResource:@"rainy" ofType:@"png"];
    //NSData *myData = [NSData dataWithContentsOfFile:path];
	//[picker addAttachmentData:myData mimeType:@"image/png" fileName:@"rainy"];
	
	// Fill out the email body text
	NSString *emailBody = bodyMessage;
	[picker setMessageBody:emailBody isHTML:NO];
	
	[self presentModalViewController:picker animated:YES];
    [picker release];
}


// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
	message.hidden = NO;
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			message.text = @"Thank you for your Feedback. Mail Result: canceled";
			break;
		case MFMailComposeResultSaved:
			message.text = @"Thank you for your Feedback. Mail Result: saved";
			break;
		case MFMailComposeResultSent:
			message.text = @"Thank you for your Feedback. Mail Result: sent";
			break;
		case MFMailComposeResultFailed:
			message.text = @"Thank you for your Feedback. Mail Result: failed";
			break;
		default:
			message.text = @"Thank you for your Feedback. Mail Result: not sent";
			break;
	}
    
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Workaround

// Launches the Mail application on the device.
- (void)launchMailAppOnDevice
{
	NSString *recipients = @"coachtoolsapps@gmail.com";
	NSString *body = [NSString stringWithFormat:@"CoachTools: Contact - %@", versionString];
	
	NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
	email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
    
    [recipients release];
    [body release];
    [email release];
    
}

- (IBAction)doneButton:(id)sender {
	if([self.delegate respondsToSelector:@selector(returnView:)]) {
		[self.delegate returnView:self];
	}
}

- (IBAction)crittercismPressed:(id)sender {
    
    [Crittercism showCrittercism];
}

@end
