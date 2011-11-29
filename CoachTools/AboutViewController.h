//
//  AboutViewController.h
//  CoachTools
//
//  Created by cj on 7/28/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@protocol AboutDelegate;

@interface AboutViewController : UIViewController <MFMailComposeViewControllerDelegate> {
    
    id <AboutDelegate> delegate;
    IBOutlet UILabel *appNameLabel;
    IBOutlet UILabel *versionLabel;
    IBOutlet UILabel *buildVersionLabel;
    IBOutlet UILabel *message;
    
    NSString *subjectLine;
    NSString *emailLine;
    NSString *bodyMessage;

}

@property (nonatomic, assign) id <AboutDelegate> delegate;
@property (nonatomic, retain) IBOutlet UILabel *appNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *versionLabel;
@property (nonatomic, retain) IBOutlet UILabel *buildVersionLabel;
@property (nonatomic, retain) IBOutlet UILabel *message;

@property (nonatomic, retain) NSString *subjectLine;
@property (nonatomic, retain) NSString *emailLine;
@property (nonatomic, retain) NSString *bodyMessage;

-(IBAction)showPicker:(id)sender;
-(IBAction)reportBug:(id)sender;
-(IBAction)requestEnhancement:(id)sender;
-(IBAction)doneButton:(id)sender;
- (IBAction)crittercismPressed:(id)sender;
-(void)displayComposerSheet;
-(void)launchMailAppOnDevice;


@end

@protocol AboutDelegate <NSObject>

-(void)returnView:(AboutViewController*)viewController;

@end