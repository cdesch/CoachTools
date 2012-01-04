//
//  RootViewController.h
//  CoachTools
//
//  Created by cj on 4/10/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "GameTimer.h"
#import "GameManagementViewController.h"
#import "AboutViewController.h"
#import <EventKitUI/EventKitUI.h>

#import "IAPManagerViewController.h"


#import "APICallsViewController.h"
#import "FBConnect.h"


@interface RootViewController : UIViewController <NSFetchedResultsControllerDelegate, AboutDelegate, EKEventEditViewDelegate, IAPManagerDelegate,FBRequestDelegate,
FBDialogDelegate,
FBSessionDelegate> {
	
    NSArray *permissions;

    IBOutlet UIButton *loginButton;
    IBOutlet UILabel *nameLabel;
    IBOutlet UIImageView *profilePhotoImageView;
    
    GameTimer   *gameTimer;
    GameManagementViewController *gameManagementViewController;
    
    IBOutlet UIImageView *background;
    IBOutlet UILabel *titleLabel;
    
    APICallsViewController *pendingApiCallsController;
}

@property (nonatomic, retain) NSArray *permissions;

@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UIImageView *profilePhotoImageView;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, retain) GameTimer *gameTimer;
@property (nonatomic, retain) GameManagementViewController *gameManagementViewController;

@property (nonatomic, retain) UIImageView *background;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;

+ (RootViewController *)sharedAppController;

- (NSArray *)allInstancesOf:(NSString *)entityName orderedBy:(NSString *)attName;
- (NSArray *)allInstancesOf:(NSString *)entityName orderedBy:(NSString *)attName parentEntity:(NSString *)parentName;
- (IBAction)pushThis:(id)sender;
- (IBAction)crittercismPressed:(id)sender;
- (IBAction)infoButton:(id)sender;
- (IBAction)chalkTalk:(id)sender;
- (IBAction)IAPManagerButton:(id)sender;
- (IBAction)notAvailable:(id)sender;
- (IBAction)launchFeedback:(id)sender;
- (IBAction)testButton:(id)sender;
- (IBAction)shareKitButton:(id)sender;

- (void)showLoggedIn;
- (void)showLoggedOut;


@end
