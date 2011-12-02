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

@interface RootViewController : UIViewController <NSFetchedResultsControllerDelegate, AboutDelegate, EKEventEditViewDelegate> {
	
    NSArray *menuSectionsArray;
    NSMutableArray *menuOptionsArray;
    
    GameTimer   *gameTimer;
    GameManagementViewController *gameManagementViewController;
    
    IBOutlet UIImageView *background;
    IBOutlet UILabel *titleLabel;

}
@property (nonatomic, retain) NSArray *menuSectionsArray;
@property (nonatomic, retain) NSMutableArray *menuOptionsArray;

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

- (IBAction)IAPManagerButton:(id)sender;
- (IBAction)notAvailable:(id)sender;

- (void)testPredicate;
- (IBAction)testButton:(id)sender;



@end
