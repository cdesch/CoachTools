//
//  PlayerSummaryViewController.h
//  CoachTools
//
//  Created by cj on 5/16/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"
#import "PlayerEditViewController.h"


@class Person;

@interface PlayerSummaryViewController : UIViewController <CPTPlotDataSource, CPTPieChartDataSource, CPTBarPlotDelegate, PlayerEditDelegate> {
    Person *player;
    
    UITextField *lastNameTextField;
    UITextField *firstNameTextField;
    UITextField *playerNumberTextField;
    UISwitch *playerActiveSwitch;
    
    NSMutableArray *generalStatsArray;
    NSMutableDictionary *positionStatsDictionary; 
    
    NSMutableDictionary *gameTimesDictionary;
    
    CPTXYGraph *graph, *barChart;
    IBOutlet CPTGraphHostingView *scatterPlotView;
    
    NSMutableDictionary *playerModel;
    
}

@property (nonatomic, retain) Person *player;
@property (nonatomic, retain) IBOutlet UITextField *lastNameTextField;
@property (nonatomic, retain) IBOutlet UITextField *firstNameTextField;
@property (nonatomic, retain) IBOutlet UITextField *playerNumberTextField;
@property (nonatomic, retain) IBOutlet UISwitch *playerActiveSwitch;
@property (nonatomic, retain) UISegmentedControl *segControlGraphType;
@property (nonatomic, retain) UISegmentedControl *segControlSeasonType;

@property (nonatomic, retain) NSMutableArray *generalStatsArray;
@property (nonatomic, retain) NSMutableDictionary *positionStatsDictionary; 
@property (nonatomic, retain) NSMutableDictionary *gameTimesDictionary;

@property(readwrite, retain, nonatomic) NSMutableArray *dataForChart, *dataForPlot, *dataForShadow;

@property (nonatomic, retain) NSMutableDictionary *playerModel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil playerSelected:(Person *)aPlayer;
- (void)editItem:(id)sender;
- (IBAction)activeSwitchChanged:(id)sender;
- (IBAction)emergancyContactButton:(id)sender;
// Build the graph
- (void)buildGraph:(NSInteger)type:(NSInteger)season;
//- (void)constructBarChart;
- (IBAction)segControlChanged;

- (BOOL)validatePerson;
- (BOOL)validateEmail: (NSString *) candidate;

@end
