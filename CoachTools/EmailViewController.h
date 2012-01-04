//
//  EmailViewController.h
//  CoachTools
//
//  Created by Chris Desch on 1/3/12.
//  Copyright (c) 2012 Desch Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@protocol EmailDelegate;

@interface EmailViewController : UITableViewController <MFMailComposeViewControllerDelegate> {
    
    id <EmailDelegate> delegate;
    
    NSArray *buttonLabels;

    NSString *receiptsline;
    NSString *subjectLine;
    NSString *bodyMessage;
    
}

@property (nonatomic, assign) id <EmailDelegate> delegate;
@property (nonatomic, retain) NSArray *buttonLabels;

- (id)initWithStyle:(UITableViewStyle)style object:(id)object;
- (void)doneButton:(id)sender;
//- (void)displayComposerSheet;

@end

@protocol EmailDelegate <NSObject>

- (void)doneEmail:(EmailViewController*)viewController;

@end