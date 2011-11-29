//
//  PlayerSummaryViewController.m
//  CoachTools
//
//  Created by cj on 5/16/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "PlayerSummaryViewController.h"
#import "Person.h"
#import "GameSub.h"
#import "Game.h"
#import "iToast.h"
#import "PlistStringUtil.h"


@implementation PlayerSummaryViewController

@synthesize player;
@synthesize lastNameTextField;
@synthesize firstNameTextField;
@synthesize playerNumberTextField;
@synthesize emailTextField;
@synthesize playerActiveSwitch;

@synthesize segControlGraphType;
@synthesize segControlSeasonType;
@synthesize dataForPlot;
@synthesize dataForShadow;
@synthesize dataForChart;
@synthesize generalStatsArray;
@synthesize positionStatsDictionary;
@synthesize gameTimesDictionary;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil playerSelected:(Person *)aPlayer
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //NSLog(@"ViewController: %@", nibNameOrNil);
        
        //Initialize
        player = aPlayer;

    }
    
    return self;
}

- (void)dealloc
{
    [barChart release];
    [dataForChart release];
	[dataForPlot release];
 
    [generalStatsArray release];    
    [gameTimesDictionary release];
    [positionStatsDictionary release];    

    
    [lastNameTextField release];
    [firstNameTextField release];
    [playerNumberTextField release];
    [emailTextField release];
    [playerActiveSwitch release];
    
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
    
    UINavigationItem *navigationItem = self.navigationItem;
    navigationItem.title = @"Player Summary";
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    
    //********** Compile Stats *******
    
    //General Stats ******
    generalStatsArray = [[NSMutableArray alloc] init];
    
    [generalStatsArray addObject:[NSNumber numberWithInt:[player.gameStart count]]];
    [generalStatsArray addObject:[NSNumber numberWithInt:[player.gameScore count]]];
    [generalStatsArray addObject:[NSNumber numberWithInt:[player.gameAssist count]]];
    //[generalStatsArray addObject:[NSNumber numberWithInt:5]];
    //[generalStatsArray addObject:[NSNumber numberWithInt:20]];
    //[generalStatsArray addObject:[NSNumber numberWithInt:50]];    
        
    //Time Stats  *********
    //timeStatsArray = [[NSMutableArray alloc] init ];    
    positionStatsDictionary = [[NSMutableDictionary alloc] init];

    int totalTime = 0;
    
    gameTimesDictionary = [[NSMutableDictionary alloc] init ];
   
    //Find the time played for each game and the time played in each position
    for (GameSub *sub in  [player.gameSub allObjects]){
        
        //find time played 
        int subTime = ([sub.endTime intValue] - [sub.startTime intValue]);
        
        //check if the key exists -  totalled Game time played
        if([gameTimesDictionary objectForKey:sub.game.gameNumber] == nil){
            [gameTimesDictionary setObject:[NSNumber numberWithInt:subTime]  forKey:sub.game.gameNumber];
        }else{
            //get the object and add the subtime for the game. 
            NSNumber *time = [gameTimesDictionary objectForKey:sub.game];
            int temp  = [time intValue];
            temp = temp + subTime;
            [gameTimesDictionary setObject:[NSNumber numberWithInt:temp]  forKey:sub.game.gameNumber];
        }
        
        //add to time played
        totalTime = totalTime + subTime;
        
        //Add the time for that position also
        if([positionStatsDictionary objectForKey:sub.positionName] == nil){
            [positionStatsDictionary setObject:[NSNumber numberWithInt:subTime]  forKey:sub.positionName];
            //NSLog(@" %d, %@", subTime, sub.positionName);
        }else{
            //get the object and add the subtime for the game. 
            NSNumber *time = [positionStatsDictionary objectForKey:sub.positionName];
            int temp  = [time intValue];
            temp = temp + subTime;
            //NSLog(@" %d, %@", temp, sub.positionName);
            [positionStatsDictionary setObject:[NSNumber numberWithInt:temp]  forKey:sub.positionName];
        }
        
        /*
        if([sub.positionName isEqualToString:@"Defender"]){
            defenderTime = defenderTime  + subTime;
        }else if ([sub.positionName isEqualToString:@"Goal"]){
            goalTime = goalTime + subTime;
        }else if([sub.positionName isEqualToString:@"Forward"]){
            forwardTime = forwardTime + subTime;
        }else if([sub.positionName isEqualToString: @"Midfield"]){
            midfieldTime = midfieldTime + subTime;
        }*/
        
    }
    
    //add to dictionary
/*
    
    NSLog(@"Defender %d", defenderTime);    
    NSLog(@"Forward %d", forwardTime);
    NSLog(@"Midfield %d", midfieldTime);
    NSLog(@"Goal %d", goalTime);
    NSLog(@"Total %d", totalTime);
  */  
    /*
    for (NSString* key in gameTimesDictionary) {
        id value = [gameTimesDictionary objectForKey:key];
        //int temp = [value intValue];
        NSLog(@"Gametime: %@, %d", key,[value intValue] );
        
    }
    
    for (NSString* key in positionStatsDictionary) {
        id value = [positionStatsDictionary objectForKey:key];
        //int temp = [value intValue];
        NSLog(@"position: %@, %d", key,[value intValue] );
        
    }
*/    
    // *******************  SEGMENTED CONTROL FOR SELECTING GRAPH DATA *****************************
    NSArray *graphTypes = [NSArray arrayWithObjects: @"Stats", @"Time", @"Positions", nil];
    segControlGraphType = [[UISegmentedControl alloc] initWithItems:graphTypes];
    segControlGraphType.frame = CGRectMake(scatterPlotView.frame.origin.x, scatterPlotView.frame.origin.y - 20, scatterPlotView.frame.size.width, 20);
    segControlGraphType.segmentedControlStyle = UISegmentedControlStylePlain;
    segControlGraphType.selectedSegmentIndex = 0;
    [segControlGraphType addTarget:self action:@selector(segControlChanged) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segControlGraphType];
    [segControlGraphType release];

/*    
    NSArray *seasonTypes = [NSArray arrayWithObjects: @"Season", @"Career", nil]; 
    segControlSeasonType = [[UISegmentedControl alloc] initWithItems:seasonTypes];
    segControlSeasonType.frame = CGRectMake(scatterPlotView.frame.origin.x - scatterPlotView.frame.size.height/2 - 9, scatterPlotView.frame.origin.y + scatterPlotView.frame.size.height/2 - 10, scatterPlotView.frame.size.height, 20);
    segControlSeasonType.segmentedControlStyle = UISegmentedControlStylePlain;
    segControlSeasonType.selectedSegmentIndex = 0;
    segControlSeasonType.transform = CGAffineTransformRotate(segControlSeasonType.transform, 270.0/180*M_PI);
    [segControlSeasonType addTarget:self action:@selector(segControlChanged) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segControlSeasonType];
    [segControlSeasonType release];    
 */   
    [self buildGraph:segControlGraphType.selectedSegmentIndex:segControlSeasonType.selectedSegmentIndex];

}

- (IBAction)segControlChanged
{
    
    [self buildGraph:segControlGraphType.selectedSegmentIndex:segControlSeasonType.selectedSegmentIndex];
    
}

- (void)viewDidUnload
{
    self.lastNameTextField = nil;
    self.firstNameTextField = nil;
    self.playerNumberTextField = nil;
    self.playerActiveSwitch = nil;
    self.emailTextField = nil;
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated{

    lastNameTextField.text = player.lastName;
    firstNameTextField.text = player.firstName;
    playerNumberTextField.text = player.playerNumber;
    playerActiveSwitch.on = [player.active boolValue];
    emailTextField.text = player.email;
   
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    [super setEditing:editing animated:animated];
    
    //Set Editing and Hide backbutton
    lastNameTextField.enabled = editing;
    firstNameTextField.enabled = editing;
    playerNumberTextField.enabled = editing;
    emailTextField.enabled = editing;
	[self.navigationItem setHidesBackButton:editing animated:YES];
    

    
	if (!editing) {
        //Reset the forms
        lastNameTextField.borderStyle = UITextBorderStyleNone;
        firstNameTextField.borderStyle = UITextBorderStyleNone;
        playerNumberTextField.borderStyle = UITextBorderStyleNone;
        emailTextField.borderStyle = UITextBorderStyleNone;
        
        if ([self validatePerson]){
            //form data to the object
            player.lastName = lastNameTextField.text;
            player.firstName = firstNameTextField.text;
            player.playerNumber = playerNumberTextField.text;
            player.email = emailTextField.text;
            
            NSManagedObjectContext *context = player.managedObjectContext;
            NSError *error = nil;
            if (![context save:&error]) {
                
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort();
            }else{
                //Confirm the Save to the user
                [[iToast makeText:NSLocalizedString(@"Data Saved", @"")] show];
                
            }
            
        }else{
            //Since the data did not validate, reset the form
            lastNameTextField.text = player.lastName;
            firstNameTextField.text = player.firstName;
            playerNumberTextField.text = player.playerNumber;
            emailTextField.text = player.email;
        }


	}else{
        
        //Show Form Boxes
        lastNameTextField.borderStyle = UITextBorderStyleRoundedRect;
        firstNameTextField.borderStyle = UITextBorderStyleRoundedRect;
        playerNumberTextField.borderStyle = UITextBorderStyleRoundedRect;
        emailTextField.borderStyle = UITextBorderStyleRoundedRect;
    }	

}

- (IBAction)activeSwitchChanged:(id)sender{
    player.active = [NSNumber numberWithBool:playerActiveSwitch.on];
    
    NSManagedObjectContext *context = player.managedObjectContext;
    NSError *error = nil;
    if (![context save:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }else{
                
    }
    
}

// Build the graph
// ------------------ ORIGINAL COREPLOT CODE FROM CHRIS ---------------------------
/*
 - (void)buildGraph{
    // Create graph from theme
    
    graph = [[CPXYGraph alloc] initWithFrame:CGRectZero];
	CPTheme *theme = [CPTheme themeNamed:kCPDarkGradientTheme];
    [graph applyTheme:theme];
    scatterPlotView.hostedGraph = graph;
	
    graph.paddingLeft = 10.0;
	graph.paddingTop = 10.0;
	graph.paddingRight = 10.0;
	graph.paddingBottom = 10.0;
    
    // Setup plot space
    CPXYPlotSpace *plotSpace = (CPXYPlotSpace *)graph.defaultPlotSpace;
    plotSpace.allowsUserInteraction = YES;
    plotSpace.xRange = [CPPlotRange plotRangeWithLocation:CPTDecimalFromFloat(1.0) length:CPTDecimalFromFloat(2.0)];
    plotSpace.yRange = [CPPlotRange plotRangeWithLocation:CPTDecimalFromFloat(1.0) length:CPTDecimalFromFloat(3.0)];
	
    // Axes
	CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
    CPTXYAxis *x = axisSet.xAxis;
    x.majorIntervalLength = CPTDecimalFromString(@"0.5");
    x.orthogonalCoordinateDecimal = CPTDecimalFromString(@"2");
    x.minorTicksPerInterval = 2;
 	NSArray *exclusionRanges = [NSArray arrayWithObjects:
								[CPPlotRange plotRangeWithLocation:CPTDecimalFromFloat(1.99) length:CPTDecimalFromFloat(0.02)], 
								[CPPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.99) length:CPTDecimalFromFloat(0.02)],
								[CPPlotRange plotRangeWithLocation:CPTDecimalFromFloat(2.99) length:CPTDecimalFromFloat(0.02)],
								nil];
	x.labelExclusionRanges = exclusionRanges;
	
    CPTXYAxis *y = axisSet.yAxis;
    y.majorIntervalLength = CPTDecimalFromString(@"0.5");
    y.minorTicksPerInterval = 5;
    y.orthogonalCoordinateDecimal = CPTDecimalFromString(@"2");
	exclusionRanges = [NSArray arrayWithObjects:
					   [CPPlotRange plotRangeWithLocation:CPTDecimalFromFloat(1.99) length:CPTDecimalFromFloat(0.02)], 
					   [CPPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.99) length:CPTDecimalFromFloat(0.02)],
					   [CPPlotRange plotRangeWithLocation:CPTDecimalFromFloat(3.99) length:CPTDecimalFromFloat(0.02)],
					   nil];
	y.labelExclusionRanges = exclusionRanges;
	
    // Create a green plot area
	CPScatterPlot *dataSourceLinePlot = [[[CPScatterPlot alloc] init] autorelease];
    dataSourceLinePlot.identifier = @"Green Plot";
    
    CPMutableLineStyle *lineStyle = [[dataSourceLinePlot.dataLineStyle mutableCopy] autorelease];
	lineStyle.lineWidth = 3.f;
    lineStyle.lineColor = [CPTColor greenColor];
	lineStyle.dashPattern = [NSArray arrayWithObjects:[NSNumber numberWithFloat:5.0f], [NSNumber numberWithFloat:5.0f], nil];
    dataSourceLinePlot.dataLineStyle = lineStyle;
    
    dataSourceLinePlot.dataSource = self;
	
	// Put an area gradient under the plot above
    CPTColor *areaColor = [CPTColor colorWithComponentRed:0.3 green:1.0 blue:0.3 alpha:0.8];
    CPGradient *areaGradient = [CPGradient gradientWithBeginningColor:areaColor endingColor:[CPTColor clearColor]];
    areaGradient.angle = -90.0f;
    CPFill *areaGradientFill = [CPFill fillWithGradient:areaGradient];
    dataSourceLinePlot.areaFill = areaGradientFill;
    dataSourceLinePlot.areaBaseValue = CPTDecimalFromString(@"1.75");
	
	// Animate in the new plot, as an example
	dataSourceLinePlot.opacity = 0.0f;
	dataSourceLinePlot.cachePrecision = CPPlotCachePrecisionDecimal;
    [graph addPlot:dataSourceLinePlot];
	
	CABasicAnimation *fadeInAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
	fadeInAnimation.duration = 1.0f;
	fadeInAnimation.removedOnCompletion = NO;
	fadeInAnimation.fillMode = kCAFillModeForwards;
	fadeInAnimation.toValue = [NSNumber numberWithFloat:1.0];
	[dataSourceLinePlot addAnimation:fadeInAnimation forKey:@"animateOpacity"];
	
	// Create a blue plot area
	CPScatterPlot *boundLinePlot = [[[CPScatterPlot alloc] init] autorelease];
    boundLinePlot.identifier = @"Blue Plot";
    
    lineStyle = [[boundLinePlot.dataLineStyle mutableCopy] autorelease];
	lineStyle.miterLimit = 1.0f;
	lineStyle.lineWidth = 3.0f;
	lineStyle.lineColor = [CPTColor blueColor];
    lineStyle = lineStyle;
    
    boundLinePlot.dataSource = self;
	boundLinePlot.cachePrecision = CPPlotCachePrecisionDouble;
	boundLinePlot.interpolation = CPScatterPlotInterpolationHistogram;
	[graph addPlot:boundLinePlot];
	
	// Do a blue gradient
	CPTColor *areaColor1 = [CPTColor colorWithComponentRed:0.3 green:0.3 blue:1.0 alpha:0.8];
    CPGradient *areaGradient1 = [CPGradient gradientWithBeginningColor:areaColor1 endingColor:[CPTColor clearColor]];
    areaGradient1.angle = -90.0f;
    areaGradientFill = [CPFill fillWithGradient:areaGradient1];
    boundLinePlot.areaFill = areaGradientFill;
    boundLinePlot.areaBaseValue = [[NSDecimalNumber zero] decimalValue];    
	
	// Add plot symbols
	CPMutableLineStyle *symbolLineStyle = [CPMutableLineStyle lineStyle];
	symbolLineStyle.lineColor = [CPTColor blackColor];
	CPPlotSymbol *plotSymbol = [CPPlotSymbol ellipsePlotSymbol];
	plotSymbol.fill = [CPFill fillWithColor:[CPTColor blueColor]];
	plotSymbol.lineStyle = symbolLineStyle;
    plotSymbol.size = CGSizeMake(10.0, 10.0);
    boundLinePlot.plotSymbol = plotSymbol;
	
    // Add some initial data
	NSMutableArray *contentArray = [NSMutableArray arrayWithCapacity:100];
	NSUInteger i;
    
	for ( i = 0; i < 10; i++ ) {
		id x = [NSNumber numberWithFloat:1+i*0.05];
		id y = [NSNumber numberWithFloat:1.2*rand()/(float)RAND_MAX + 1.2];
		[contentArray addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:x, @"x", y, @"y", nil]];
	}
	self.dataForPlot = contentArray;
}
*/
#pragma mark -
#pragma mark Plot Data Source Methods

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

// Method to build a bar chart
// I would like to refactor this into a class/wrapper for coreplot
- (void)buildGraph:(NSInteger)type:(NSInteger)season
{
    NSString *xTitle;
    NSString *yTitle;
    float xRange = 0;
    float yRange = 0;
    NSString *xInterval;
    NSString *yInterval;
    NSMutableArray *labelText;
	NSInteger i;
    NSInteger graphType;
    NSMutableArray *contentArray;
    
    switch(type)
    {
        case 0: // Stats
            graphType = 0;
            xTitle = @"Stats";
            yTitle = @"Amount";     
            xRange = 55.0; // Height of graph area
            yRange = 3.0;  // Width of graph area (number of bars)
            xInterval = @"5";  // Spacing between x tick lines
            yInterval = @"15"; // Spacing between y tick lines  
            labelText = [NSMutableArray arrayWithObjects: @"Starts", @"Goals", @"Assists",  nil ];

            //Get the data from the datasource for the plot
            contentArray = [NSMutableArray arrayWithCapacity:yRange];
            
            for ( i = 0; i < yRange; i++ ) {
             
                id x = [NSNumber numberWithInteger:i];
                id y = [generalStatsArray objectAtIndex:i];
                [contentArray addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:x, @"x", y, @"y",nil]];
             }
            
            break;
        case 1: // Time
            graphType = 0;
            xTitle = @"Game";
            yTitle = @"Time";
            xRange = 100.0; // Height of graph area
            yRange = [gameTimesDictionary count];  // Width of graph area (number of bars)
            xInterval = @"5";  // Spacing between x tick lines
            yInterval = @"15"; // Spacing between y tick lines
            labelText = [NSMutableArray arrayWithCapacity:yRange];
            
            //Number of games - Assign a Label for each bar - assign a name to that label
            /*
            for ( i = 0; i < yRange; i++ )
            {
                NSString *label = [NSString stringWithFormat:@"Game %i", i+ 1];
                [labelText addObject:label];
            }*/
            
            //Get the data from the datasource for the plot
            contentArray = [NSMutableArray arrayWithCapacity:yRange];
            
            i = 0;
            
            for (NSString* key in gameTimesDictionary) {
                id value = [gameTimesDictionary objectForKey:key];
                //int temp = [value intValue];
                //NSLog(@"Gametime: %@, %d", key,[value intValue] );
                
                //Create the label for the data point
                NSString *label = [NSString stringWithFormat:@"Game %@",key];
                [labelText addObject:label];
                
                //Data Data Point
                id x = [NSNumber numberWithInteger:i];
                id y = [NSNumber numberWithInteger:[value intValue]/60];
                [contentArray addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:x, @"x", y, @"y",nil]];
                i ++;
            }
            
            
            break;
        case 2: // Other
            graphType = 1;
            xTitle = @"Other";
            yTitle = @"Amount"; 
            xRange = 100.0; // Height of graph area
            yRange = [positionStatsDictionary count];   //Width of graph area (number of bars)
            xInterval = @"5";  // Spacing between x tick lines
            yInterval = @"15"; // Spacing between y tick lines    
            labelText = [NSMutableArray arrayWithCapacity:yRange];
            
            /*
            for ( i = 0; i < yRange; i++ )
            {
                NSString *label = [NSString stringWithFormat:@"Position %i", i+ 1];
                [labelText addObject:label];
            } */       
            
            //Get the data from the datasource for the plot
            contentArray = [NSMutableArray arrayWithCapacity:yRange];
            
            
            for (NSString* key in positionStatsDictionary) {
                id value = [positionStatsDictionary objectForKey:key];
                //int temp = [value intValue];
                //NSLog(@"Gametime: %@, %d", key,[value intValue] );
                
                //Data Data Point
                id x = [NSNumber numberWithInteger:[value intValue]];
                id y = [NSString stringWithFormat:@"Position %@",key];
                [contentArray addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:x, @"x", y, @"y",nil]];
            
            }
            
            
            
            break;
        default:
            break;
    }
    
    switch (season) {
        case 0:     // Season stats
            break;
        case 1:     // Career stats
            break;
        default:
            break;
    }
    
    ///////*********************************//////
    
    CPTTheme *theme = [CPTTheme themeNamed:kCPTDarkGradientTheme];
    switch (graphType) {
            
        case 0:
            // Create Bar Graph
            graph = [[CPTXYGraph alloc] initWithFrame:self.view.bounds];
            [graph applyTheme:theme];
            scatterPlotView.hostedGraph = graph;
            graph.plotAreaFrame.masksToBorder = NO;
                
            graph.paddingLeft = 70.0;
            graph.paddingTop = 20.0;
            graph.paddingRight = 20.0;
            graph.paddingBottom = 80.0;
            
            // Add plot space for horizontal bar charts
            CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
            plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0f) length:CPTDecimalFromFloat(xRange)];
            plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0f) length:CPTDecimalFromFloat(yRange)];
            
            
            CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
            CPTXYAxis *x = axisSet.xAxis;
            x.axisLineStyle = nil;
            x.majorTickLineStyle = nil;
            x.minorTickLineStyle = nil;
            x.minorTicksPerInterval = 1;
            x.majorIntervalLength = CPTDecimalFromString(xInterval);
            x.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0");    
            x.title = xTitle;
            x.titleLocation = CPTDecimalFromFloat(7.5f);
            x.titleOffset = 55.0f;
            
            // Define some custom labels for the data elements
            x.labelRotation = M_PI/4;
            x.labelingPolicy = CPTAxisLabelingPolicyNone;
            NSMutableArray *barLabels = [NSMutableArray arrayWithCapacity:yRange];
            
            for ( i = 0; i < yRange; i++ ) {
                CPTAxisLabel *newLabel = [[CPTAxisLabel alloc] initWithText: [labelText objectAtIndex:i] textStyle:x.labelTextStyle];
                newLabel.tickLocation = CPTDecimalFromString([NSString stringWithFormat:@"%d", i]);
                newLabel.offset = 0.5;//x.labelOffset + x.majorTickLength;
                newLabel.rotation = M_PI/4;
                [barLabels addObject:newLabel];
                [newLabel release];
            }	
            
            x.axisLabels =  [NSSet setWithArray:barLabels];
            
            CPTXYAxis *y = axisSet.yAxis;
            y.axisLineStyle = nil;
            y.majorTickLineStyle = nil;
            y.minorTickLineStyle = nil;
            y.majorIntervalLength = CPTDecimalFromString(yInterval);
            y.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0");
            y.title = yTitle;
            y.titleOffset = 45.0f;
            y.titleLocation = CPTDecimalFromFloat(45.0f);
            CPTBarPlot *barPlot;
            
            // Will we display team averages for career?  I don't think so....
            if (season == 0) {
                // Back Bars - Shadow for Team Averages
                barPlot = [CPTBarPlot tubularBarPlotWithColor:[CPTColor grayColor] horizontalBars:NO];
                barPlot.dataSource = self;
                barPlot.baseValue = CPTDecimalFromString(@"0");
                barPlot.barOffset = CPTDecimalFromString(@"0.5");
                //barPlot.cornerRadius = 2.0f;
                barPlot.identifier = @"Back";
                [graph addPlot:barPlot toPlotSpace:plotSpace];
            }
            
            // Front Bars - For Current Player
            barPlot = [CPTBarPlot tubularBarPlotWithColor:[CPTColor yellowColor] horizontalBars:NO];
            barPlot.dataSource = self;
            barPlot.baseValue = CPTDecimalFromString(@"0");
            barPlot.barOffset = CPTDecimalFromString(@"0.65");
            barPlot.identifier = @"General Stats";
            [graph addPlot:barPlot toPlotSpace:plotSpace];   
            
            // Put Data Source into Plot            
            //contentArray = [NSMutableArray arrayWithCapacity:yRange];
            /*
            for ( i = 0; i < yRange; i++ ) {
                id x = [NSNumber numberWithFloat:(float)(random() % (int)xRange)];
                id y = [NSNumber numberWithFloat:(float)(random() % (int)xRange)];
                [contentArray addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:x, @"x", y, @"y",nil]];
            }*/	
            
            //
            self.dataForPlot = contentArray;
            [graph addPlot:barPlot];
            //[contentArray removeAllObjects];	
            break;
            
            /////////*********************************//////////
        case 1:
            graph = [[CPTXYGraph alloc] initWithFrame: self.view.bounds];	
            //theme = [CPTheme themeNamed:kCPDarkGradientTheme];
            [graph applyTheme:theme];
            
            scatterPlotView.hostedGraph = graph;      
            
            // Define some custom labels for the data elements
            //NSMutableArray *pieLabels = [NSMutableArray arrayWithObjects:@"goal", @"defender", @"midfield", @"forward", nil];    
            
            CPTPieChart *pieChart = [[CPTPieChart alloc] init];
            pieChart.dataSource = self;
            pieChart.pieRadius = scatterPlotView.frame.size.height/3;
            pieChart.identifier = @"Pie";
            pieChart.startAngle = M_PI_4;
            pieChart.sliceDirection = CPTPieDirectionCounterClockwise;
            
            
            //contentArray = [NSMutableArray arrayWithCapacity:yRange];
            
            // Generate Random Data
            // *************** // ******
            
            //positionStatsDictionary
            /*for ( i = 0; i < yRange; i++ ) {
                srand(time(NULL));
                id x = [NSNumber numberWithFloat:(float)(random() % (int)xRange)];
                //id y = [NSNumber numberWithFloat:(float)(random() % (int)xRange)];
                id y = [pieLabels objectAtIndex:i];
                [contentArray addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:x, @"x", y, @"y",nil]];
            }*/
            
            
            self.dataForChart = contentArray;
            
            [graph addPlot:pieChart];
            [graph release];
            [pieChart release];
            break;
        default:
            break;
    }
    
}

// Return the number of data points for the plot
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot 
{
    
    if ([plot isKindOfClass:[CPTPieChart class]]){
        
        NSLog(@" rec in Chart %d",  [self.dataForChart count]);
         return [self.dataForChart count];
    }
    //Return the number of records in that plot
    else if ([plot isKindOfClass:[CPTBarPlot class]]){
        
        NSLog(@" records in plot %d", [dataForPlot count]);
        return [dataForPlot count];

    }
    else{
        return [dataForPlot count];
    }
        
}

//determine if its a x or y coordinate and return that value for the plot
-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index 
{
    /*
    //Is it a bar plot
    if([plot isKindOfClass:[CPTBarPlot class]]){
    
        if(fieldEnum == CPTBarPlotFieldBarLocation){
        
        }else if ( fieldEnum == CPTBarPlotFieldBarTip){
        
        }
        else { 
        
        } 
    }
    */
    
     NSDecimalNumber *num = nil;
    //Check if its a Pie Chart to Plot
     if ( [plot isKindOfClass:[CPTPieChart class]] ) {

        if ( index >= [self.dataForChart count] ) return nil;
        NSDictionary *sample = [dataForChart objectAtIndex:index];
        if ( fieldEnum == CPTPieChartFieldSliceWidth ) {
            NSLog(@"pie x %@", [sample valueForKey:@"x"]);
            return [sample valueForKey:@"x"];
            //return [self.dataForChart objectAtIndex:index];

        }
        else {
            NSLog(@"pie y %@", [sample valueForKey:@"y"]);
            return [sample valueForKey:@"y"];
        }
     }
    //Check if its a bar Chart to plot
     else if ( [plot isKindOfClass:[CPTBarPlot class]] ) {
         NSDictionary *sample = [dataForPlot objectAtIndex:index];
         
         if (fieldEnum == CPTBarPlotFieldBarLocation){
             NSLog(@"x %@", [sample valueForKey:@"x"]);
             return [sample valueForKey:@"x"];
         }
         else{
             NSLog(@"y %@", [sample valueForKey:@"y"]);
             return [sample valueForKey:@"y"];
         }

         /*
         switch ( fieldEnum ) {
            case CPTBarPlotFieldBarLocation:
                //num = (NSDecimalNumber *)[NSDecimalNumber numberWithUnsignedInteger:index];
                //num  = [dataForPlot objectAtIndex:index];
                num = [[dataForPlot objectAtIndex:index] valueForKey:(fieldEnum == CPTScatterPlotFieldX ? @"x" : @"y")];
                    NSLog(@" Bar Location %d", index);
                    
                break;
            case CPTBarPlotFieldBarTip:
                num = [[dataForPlot objectAtIndex:index] valueForKey:(fieldEnum == CPTScatterPlotFieldX ? @"x" : @"y")];
                //num = (NSDecimalNumber *)[NSDecimalNumber numberWithUnsignedInteger:index];
                //num = [dataForPlot objectAtIndex:index];
                
                //    if ( [plot.identifier isEqual:@"Bar Plot 2"] ) {
                        num = [num decimalNumberBySubtracting:[NSDecimalNumber decimalNumberWithString:@"10"]];
                 //   }
                NSLog(@" Bar tip %d", index);
                
                
                break;
        }*/
    }
    /*
    else {
         if ( index % 8 ) {
             num = [[dataForPlot objectAtIndex:index] valueForKey:(fieldEnum == CPTScatterPlotFieldX ? @"x" : @"y")];
             // Green plot gets shifted above the blue
             if ( [(NSString *)plot.identifier isEqualToString:@"Green Plot"] ) {
                 if ( fieldEnum == CPTScatterPlotFieldY ) {
                    num = (NSDecimalNumber *)[NSDecimalNumber numberWithDouble:[num doubleValue] + 1.0];
                 }
             }
         }
         else {
             num = [NSDecimalNumber notANumber];
         }
     }
     */
    //Return the number
     return num;
     
}


/*


- (void)constructBarChart
{
    //NSLog(@"Entering %s", __PRETTY_FUNCTION__);
    
    // Create barChart from theme
    barChart = [[CPTXYGraph alloc] initWithFrame:CGRectZero];
	CPTTheme *theme = [CPTTheme themeNamed:kCPTDarkGradientTheme];
    [barChart applyTheme:theme];
    scatterPlotView.hostedGraph = barChart;
    barChart.plotAreaFrame.masksToBorder = NO;
	
    barChart.paddingLeft = 70.0;
	barChart.paddingTop = 20.0;
	barChart.paddingRight = 20.0;
	barChart.paddingBottom = 80.0;
	
	// Add plot space for horizontal bar charts
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)barChart.defaultPlotSpace;
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0f) length:CPTDecimalFromFloat(300.0f)];
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0f) length:CPTDecimalFromFloat(16.0f)];
    
	CPTXYAxisSet *axisSet = (CPTXYAxisSet *)barChart.axisSet;
    CPTXYAxis *x = axisSet.xAxis;
    x.axisLineStyle = nil;
    x.majorTickLineStyle = nil;
    x.minorTickLineStyle = nil;
    x.majorIntervalLength = CPTDecimalFromString(@"5");
    x.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0");
	x.title = @"X Axis";
    x.titleLocation = CPTDecimalFromFloat(7.5f);
	x.titleOffset = 55.0f;
	
	// Define some custom labels for the data elements
	x.labelRotation = M_PI/4;
	x.labelingPolicy = CPTAxisLabelingPolicyNone;
    
    //
	NSArray *customTickLocations = [NSArray arrayWithObjects:[NSDecimalNumber numberWithInt:1], [NSDecimalNumber numberWithInt:5], [NSDecimalNumber numberWithInt:10], [NSDecimalNumber numberWithInt:15], nil];
	NSArray *xAxisLabels = [NSArray arrayWithObjects:@"Label A", @"Label B", @"Label C", @"Label D", @"Label E", nil];
	NSUInteger labelLocation = 0;
    
    //X Axis Label
	NSMutableArray *customLabels = [NSMutableArray arrayWithCapacity:[xAxisLabels count]];
	for (NSNumber *tickLocation in customTickLocations) {
		CPTAxisLabel *newLabel = [[CPTAxisLabel alloc] initWithText: [xAxisLabels objectAtIndex:labelLocation++] textStyle:x.labelTextStyle];
		newLabel.tickLocation = [tickLocation decimalValue];
		newLabel.offset = x.labelOffset + x.majorTickLength;
		newLabel.rotation = M_PI/4;
		[customLabels addObject:newLabel];
		[newLabel release];
	}
	
	x.axisLabels =  [NSSet setWithArray:customLabels];
	
	CPTXYAxis *y = axisSet.yAxis;
    y.axisLineStyle = nil;
    y.majorTickLineStyle = nil;
    y.minorTickLineStyle = nil;
    y.majorIntervalLength = CPTDecimalFromString(@"50");
    y.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0");
	y.title = @"Y Axis";
	y.titleOffset = 45.0f;
    y.titleLocation = CPTDecimalFromFloat(150.0f);
	
    // First bar plot
    CPTBarPlot *barPlot = [CPTBarPlot tubularBarPlotWithColor:[CPTColor darkGrayColor] horizontalBars:NO];
    barPlot.baseValue = CPTDecimalFromString(@"0");
    barPlot.dataSource = self;
    barPlot.barOffset = CPTDecimalFromFloat(-0.25f);
    barPlot.identifier = @"Bar Plot 1";
    [barChart addPlot:barPlot toPlotSpace:plotSpace];
    
    // Second bar plot
    barPlot = [CPTBarPlot tubularBarPlotWithColor:[CPTColor blueColor] horizontalBars:NO];
    barPlot.dataSource = self;
    barPlot.baseValue = CPTDecimalFromString(@"0");
    barPlot.barOffset = CPTDecimalFromFloat(0.25f);
    barPlot.barCornerRadius = 2.0f;
    barPlot.identifier = @"Bar Plot 2";
	barPlot.delegate = self;
    [barChart addPlot:barPlot toPlotSpace:plotSpace];

    NSLog(@"Exiting %s", __PRETTY_FUNCTION__);
}
 
 */

#pragma mark -
#pragma mark Plot Data Source Methods


-(CPTFill *) barFillForBarPlot:(CPTBarPlot *)barPlot recordIndex:(NSNumber *)index; 
{
    return nil;
}

//-(CPFill *)sliceFillForPieChart:(CPTPieChart *)pieChart recordIndex:(NSUInteger)index {
    
	//CPFill * fill;
    //fill= [CPFill fillWithGradient:[CPGradient rainbowGradient]];
    //fill = [CPFill fillWithColor:[CPTColor greenColor]];
    //fill = [CPFill fillWithColor:[CPTColor blueColor]];
    //fill = [CPFill fillWithColor:[CPTColor orangeColor]];
    //fill = [CPFill fillWithColor:[CPTColor purpleColor]];
    //fill = [CPFill fillWithColor:[CPTColor redColor]];
    
	//return fill;
//}


//-sliceFillForPieChart:recordIndex:
/*
-(CPTLayer *)dataLabelForPlot:(CPTPlot *)plot recordIndex:(NSUInteger)index 
{
    //CPTTextLayer *label = [[CPTTextLayer alloc] initWithText:@""];
    CPTTextLayer *label = [[CPTTextLayer alloc] initWithText:[NSString stringWithFormat:@"%i", index]];
    CPTMutableTextStyle *textStyle = [label.textStyle mutableCopy];
    textStyle.color = [CPTPieChart defaultPieSliceColorForIndex:index];
    label.textStyle = textStyle; 
    
    [textStyle release];
	id num = 0;
    
    NSLog(@"here2");
    if ( [plot isKindOfClass:[CPTPieChart class]] ) {
		if ( index >= [self.dataForChart count] ) return nil;
        num = [[self.dataForChart objectAtIndex:index] valueForKey:(@"x")];
        label.text = [NSString stringWithFormat:@"%@ (%@)", [[self.dataForChart objectAtIndex:index] valueForKey:(@"y")], num];
        textStyle.color = [CPTPieChart defaultPieSliceColorForIndex:index];
        textStyle.fontSize = 25;
        label.bounds = CGRectMake(0, 0, [label.text length] * 13, 30);
        NSLog(@"here");
        
	}
    else if ( [plot isKindOfClass:[CPTBarPlot class]] ) {
        num = [[self.dataForPlot objectAtIndex:index] valueForKey:(@"x")];
        textStyle.color = [CPTColor yellowColor];
		label.text = [NSString stringWithFormat:@"%@", num];
        // The shadow plot will be the average stat for a player on the team
        if ( [plot.identifier isEqual:@"Back"] ) {
            num = [[self.dataForPlot objectAtIndex:index] valueForKey:(@"y")];            
            textStyle.color = [CPTColor grayColor];
            label.text = [NSString stringWithFormat:@"%@", num];            
        }        
    }
    return [label autorelease];
}*/



-(CPTLayer *)dataLabelForPlot:(CPTPlot *)plot recordIndex:(NSUInteger)index
{
    //if ( piePlotIsRotating ) return nil;
    
	static CPTMutableTextStyle *whiteText = nil;
	
	if ( !whiteText ) {
		whiteText = [[CPTMutableTextStyle alloc] init];
		whiteText.color = [CPTColor whiteColor];
	}
	
	CPTTextLayer *newLayer = nil;

	if ( [plot isKindOfClass:[CPTPieChart class]] ) {
        if ([[self.dataForChart objectAtIndex:index] valueForKey:(@"y")]  == nil){
                newLayer = (id)[NSNull null];
        }
        else{
            newLayer = [[[CPTTextLayer alloc] initWithText:[NSString stringWithFormat:@"%@ (%@)", [[self.dataForChart objectAtIndex:index] valueForKey:(@"y")], [[self.dataForChart objectAtIndex:index] valueForKey:(@"x")]] style:whiteText] autorelease];

        }
	}
	else if ( [plot isKindOfClass:[CPTScatterPlot class]] ) {
		newLayer = [[[CPTTextLayer alloc] initWithText:[NSString stringWithFormat:@"%lu", index] style:whiteText] autorelease];
	}
    
	
	return newLayer;
}

- (BOOL)validatePerson{
    
    int maxVal = 99;
    int minVal = 0;
    
    //Game Number validators
    if ([playerNumberTextField.text isEqualToString:@""]) {
        //Check if empty
        NSMutableArray *msgParams = [[[NSMutableArray alloc] init] autorelease];
        [msgParams addObject:@"Player Number"];
        
        UIAlertView *someError = [[UIAlertView alloc] initWithTitle:[PlistStringUtil retrieveErrorText:@"requiredFieldEdit.title" withParams:msgParams] message:[PlistStringUtil retrieveErrorText:@"requiredFieldEdit.msg" withParams:msgParams] delegate: self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [someError show];
        [someError release];
        
        return FALSE;
    }else if (![playerNumberTextField.text intValue]){
        //Check if number is a number
        
        NSMutableArray *msgParams = [[[NSMutableArray alloc] init] autorelease];
        [msgParams addObject:@"Player Number"];
        
        UIAlertView *someError = [[UIAlertView alloc] initWithTitle:[PlistStringUtil retrieveErrorText:@"numOnlyField.title" withParams:msgParams] message:[PlistStringUtil retrieveErrorText:@"numOnlyField.msg" withParams:msgParams] delegate: self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [someError show];
        [someError release];
        
        return FALSE;
    }
    
    else if (([playerNumberTextField.text intValue] > maxVal) || ([playerNumberTextField.text intValue] < minVal)){
        //Check if number within the range        
        NSMutableArray *msgParams = [[[NSMutableArray alloc] init] autorelease];
        [msgParams addObject:@"Player Number"];
        [msgParams addObject:[NSString stringWithFormat:@"%d", minVal]];
        [msgParams addObject:[NSString stringWithFormat:@"%d", maxVal]];
        
        UIAlertView *someError = [[UIAlertView alloc] initWithTitle:[PlistStringUtil retrieveErrorText:@"numRange.title" withParams:msgParams] message:[PlistStringUtil retrieveErrorText:@"numRange.msg" withParams:msgParams] delegate: self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [someError show];
        [someError release];
        
        return FALSE;
    }else if ([lastNameTextField.text isEqualToString:@""]){
        
        //Check if empty
        NSMutableArray *msgParams = [[[NSMutableArray alloc] init] autorelease];
        [msgParams addObject:@"Last Name"];
        
        UIAlertView *someError = [[UIAlertView alloc] initWithTitle:[PlistStringUtil retrieveErrorText:@"requiredFieldEdit.title" withParams:msgParams] message:[PlistStringUtil retrieveErrorText:@"requiredFieldEdit.msg" withParams:msgParams] delegate: self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [someError show];
        [someError release];
        
        return FALSE;
        
    }else if ([firstNameTextField.text isEqualToString:@""]){
        
        //Check if empty
        NSMutableArray *msgParams = [[[NSMutableArray alloc] init] autorelease];
        [msgParams addObject:@"First Name"];
        
        UIAlertView *someError = [[UIAlertView alloc] initWithTitle:[PlistStringUtil retrieveErrorText:@"requiredFieldEdit.title" withParams:msgParams] message:[PlistStringUtil retrieveErrorText:@"requiredFieldEdit.msg" withParams:msgParams] delegate: self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [someError show];
        [someError release];
        
        return FALSE;
    }else if (![emailTextField.text isEqualToString:@""] && ![self validateEmail:emailTextField.text]){
        
        NSMutableArray *msgParams = [[[NSMutableArray alloc] init] autorelease];
        [msgParams addObject:emailTextField.text];
        
        UIAlertView *someError = [[UIAlertView alloc] initWithTitle:[PlistStringUtil retrieveErrorText:@"emailInvalid.title" withParams:msgParams] message:[PlistStringUtil retrieveErrorText:@"emailInvalid.msg" withParams:msgParams] delegate: self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [someError show];
        [someError release];
        
        return FALSE;
    }
    
    return TRUE;
    
}

- (BOOL)validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
    
    return [emailTest evaluateWithObject:candidate];
}

@end
