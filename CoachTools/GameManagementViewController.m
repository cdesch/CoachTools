//
//  GameManagementViewController.m
//  CoachTools
//
//  Created by cj on 4/10/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import "GameManagementViewController.h"
#import "cocos2d.h"

#import "RootViewController.h"

#import "GameController.h"
#import "GameScene.h"
#import "GameSub.h"
#import "GameStart.h"
#import "GameScore.h"
#import "SelectStartersLayer.h"

#import "ZPopoverController.h"
#import "ZFloatingManager.h"
#import "ZActionSheet.h"
#import "ZAlertView.h"
#import "ZAction.h"


static GameManagementViewController *sharedInstance;

@implementation GameManagementViewController

@synthesize mainView;
@synthesize navBar;

@synthesize starterScene;
@synthesize gameScene;
@synthesize chalkTalkScene;
@synthesize endButtonItem;

@synthesize game;

@synthesize popOverController;
@synthesize numPlayers;

+ (GameManagementViewController *)sharedController {	
    return sharedInstance;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil 
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //NSLog(@"ViewController: %@", nibNameOrNil);
        //state = kgameStopped;
        numPlayers = 8;
        
    }
    return self;
}


- (void) startCocos2d
{
    //NSLog(@"Entering %s", __PRETTY_FUNCTION__); 
    
    //NSLog(@"Running...");
    EAGLView *glview = [EAGLView viewWithFrame:CGRectMake(0, 0, 1024,704)];
    
    [mainView addSubview:glview];
    
    CCDirector *director = [CCDirector sharedDirector];
    [director setOpenGLView:glview];
    /*
    CCScene *scene = [CCScene node];

    //id node = [HelloWorldLayer node];
    //id node = [GameScene node];
    id node = [SelectStartersLayer node];
    [scene addChild: node z:0];

    [director runWithScene:scene];
    */
    //CCScene *scene = [CCScene node];
    //CCScene *scene = [SelectStartersLayer node];
    starterScene = [SelectStartersLayer node];
   
    //id node = [HelloWorldLayer node];
    //id node = [GameScene node];
    //id node = [SelectStartersLayer node];
    //[scene addChild: node z:0];
    
    [director runWithScene:starterScene];

    state = kgameRunning;
    
    //NSLog(@"Exiting %s", __PRETTY_FUNCTION__); 
}

- (void) endCocos2d
{
    //NSLog(@"Entering %s", __PRETTY_FUNCTION__); 
    //NSLog(@"Ending...");
    CCDirector *director = [CCDirector sharedDirector];

    // Since v0.99.4 you have to remove the OpenGL View manually
    EAGLView *view = [director openGLView];

    [view removeFromSuperview];

    // kill the director
    [director end];
    

    state = kgameStopped;
    //[[CCDirector sharedDirector] purgeCachedData];
    //[CCSpriteFrameCache purgeSharedSpriteFrameCache];
    
    //NSLog(@"Exiting %s", __PRETTY_FUNCTION__); 

}
//Since Coco is already running, run a new game.   
- (void)runNewGame{
    //NSLog(@"Entering %s", __PRETTY_FUNCTION__); 
    //Check if the game has been played.
    
    //Run the new game
    CCDirector *director = [CCDirector sharedDirector];
    
    CCScene *scene = [CCScene node];
    id node = [SelectStartersLayer node];
    [scene addChild: node z:0];
    
    [director replaceScene:scene];
    NSLog(@"Num Players: %d", numPlayers);
    state = kgameRunning;
        
    //NSLog(@"Exiting %s", __PRETTY_FUNCTION__); 
}

//
// Use attach / detach
// To hide / unhide the cocos2d view.
// If you want to remove them, use runWithScene / end
// IMPORTANT: Memory is not released if you use attach / detach
//
- (void) attachView
{
    //NSLog(@"Entering %s", __PRETTY_FUNCTION__); 
    //NSLog(@"Attaching...");
    CCDirector *director = [CCDirector sharedDirector];
    
    // attach to super view
    EAGLView *glview = [director openGLView];
    [mainView addSubview:glview];
    
    // start the animation again
    [director startAnimation];
    
     //NSLog(@"Exiting %s", __PRETTY_FUNCTION__); 
}

- (void) detachView
{
    //NSLog(@"Detaching...");
    
    CCDirector *director = [CCDirector sharedDirector];
    
    // remove the OpenGL view from the superview
    EAGLView *view = [director openGLView];
    [view removeFromSuperview];
    
    // Stop animation
    [director stopAnimation];
    
}

- (void)dealloc
{
    [endButtonItem release];
    [mainView release];
    [navBar release];
    [super dealloc];
}

- (IBAction)teamManagement:(id)sender{
    // NSLog(@"Entering %s", __PRETTY_FUNCTION__);
    
    //[[CCDirector sharedDirector] pause];
    //state = kgamePaused;
    //[self detachView];
    //[self dismissModalViewControllerAnimated:YES];
    //NSLog(@"Exiting %s", __PRETTY_FUNCTION__);
    
}

- (IBAction)cancelButton:(id)sender{

    
    if ([ZFloatingManager shouldFloatingWithIdentifierAppear:@"EndStarters"]) {
        
        //ZAction *cancel = [ZAction actionWithTitle:@"Cancel" target:nil action:nil object:nil];
        ZAction *destroy = [ZAction actionWithTitle:@"End Starter Selection" target:self action:@selector(endStarters:) object:nil];
        
        
        ZActionSheet *sheet = [[[ZActionSheet alloc] initWithTitle:@"Cancel Starter Selection?" cancelAction:nil destructiveAction:destroy otherActions:[NSArray arrayWithObjects:nil]] autorelease];
        sheet.identifier = @"EndStarters";
        [sheet showFromBarButtonItem:sender animated:YES];
    }

    
}

- (IBAction)finishedButton:(id)sender{
    
    //NSLog(@"Entering %s", __PRETTY_FUNCTION__);

    if ([[CCDirector sharedDirector] runningScene] == gameScene) {
        
        if ([ZFloatingManager shouldFloatingWithIdentifierAppear:@"EndGame"]) {
            
            //ZAction *cancel = [ZAction actionWithTitle:@"Cancel" target:nil action:nil object:nil];
            ZAction *destroy = [ZAction actionWithTitle:@"End Game" target:self action:@selector(endGame:) object:nil];
            
            
            ZActionSheet *sheet = [[[ZActionSheet alloc] initWithTitle:@"Are You Sure?" cancelAction:nil destructiveAction:destroy otherActions:[NSArray arrayWithObjects:nil]] autorelease];
            sheet.identifier = @"EndGame";
            [sheet showFromBarButtonItem:sender animated:YES];
        }
        
        
    }else if([[CCDirector sharedDirector] runningScene] == starterScene){
        
        if ([ZFloatingManager shouldFloatingWithIdentifierAppear:@"EndStarters"]) {
            
            //ZAction *cancel = [ZAction actionWithTitle:@"Cancel" target:nil action:nil object:nil];
            ZAction *destroy = [ZAction actionWithTitle:@"Complete" target:self action:@selector(finishedStarterSelection:) object:nil];
            ZAction *cancel = [ZAction actionWithTitle:@"Cancel Selection" target:self action:@selector(endStarters:) object:nil];
            ZActionSheet *sheet = [[[ZActionSheet alloc] initWithTitle:@"Starter Selection Complete?" cancelAction:nil destructiveAction:destroy otherActions:[NSArray arrayWithObjects:cancel,nil]] autorelease];
            sheet.identifier = @"EndStarters";
            [sheet showFromBarButtonItem:sender animated:YES];
        }

        
    }
    
    //NSLog(@"Exiting %s", __PRETTY_FUNCTION__);
}

- (void)endGame:(id)object{
    //NSLog(@"Entering %s", __PRETTY_FUNCTION__);
    
    [[[GameScene sharedScene] playerLayer] saveEndGameData];
    [self compileStats];
    
    [self endCocos2d];
    [self dismissModalViewControllerAnimated:YES];
    [self hideGameTimerControls];
    [[RootViewController sharedAppController].gameTimer reset];
    
    
    [GameScene nilSharedScene];
    
    //NSLog(@"Exiting %s", __PRETTY_FUNCTION__);
}

- (void)endStarters:(id)object{
    
    [self endCocos2d];
    [self dismissModalViewControllerAnimated:YES];
}

- (void)finishedStarterSelection:(id)object{
    if([[SelectStartersLayer sharedScene] starterSelectionComplete])
    {
        
        [self runGameScene];
        endButtonItem.title = @"End Game";
    
    }
    
}

- (void)showGameTimerControls{
    
    //NSLog(@"Entering %s", __PRETTY_FUNCTION__); 

    [self.navBar addSubview:[RootViewController sharedAppController].gameTimer.gameTimerDisplay];
    [self.navBar addSubview:[RootViewController sharedAppController].gameTimer.gameTimerButton];
    //NSLog(@"Exiting %s", __PRETTY_FUNCTION__); 
}

//
- (void)hideGameTimerControls{
    for(id view in self.navBar.subviews ){
        if ([view isKindOfClass:[GameTimerButton class]] || [view isKindOfClass:[GameTimerDisplay class]]) {

            [view removeFromSuperview];
        }
        
    }
    
    endButtonItem.title = @"End Selection";
   
}


- (void)runGameScene{
    //NSLog(@"Entering %s", __PRETTY_FUNCTION__); 
    
    gameScene =[GameScene node];
    CCDirector *director = [CCDirector sharedDirector];
    [director replaceScene:[CCTransitionFade transitionWithDuration:0.5f scene:gameScene]];
    
    //Show and Set Gametimer
    RootViewController *sharedAppController = [RootViewController sharedAppController];
    //[[sharedAppController gameTimer] setGameTimer:1 warningTime:5]; //FOR TESTING ONLY
    [[sharedAppController gameTimer] setGameTimer:[game.gameIntervalTime intValue] warningTime:5];
    
    [self showGameTimerControls];
    //NSLog(@"Exiting %s", __PRETTY_FUNCTION__); 
}

- (void)compileStats{
    
    //NSLog(@"Entering %s", __PRETTY_FUNCTION__); 
    
    RootViewController *ac = [RootViewController sharedAppController];
    NSManagedObjectContext *managedObjectContext = [ac managedObjectContext];
    
    //Save Total Game Time
    game.time = [NSNumber numberWithInt:[ac.gameTimer timeToInt]];
    
    //Was the game won?
    if ([game.homeScore intValue] > [game.opponentScore intValue])
    {
        int temp = [[[game season] team].cWins intValue];
        temp ++;
        [[game season] team].cWins =  [NSNumber numberWithInt:temp];
         
    }else if ([game.homeScore intValue] < [game.opponentScore intValue] ) {
        int temp = [[[game season] team].cLosses intValue];
        temp ++;
        [[game season] team].cLosses =  [NSNumber numberWithInt:temp];
    }
    
    //Update Player Stats
    //Player Starts
    NSArray *gameStartsArray = [game.gameStart allObjects];
    for (GameStart *start in gameStartsArray){
        
        int temp = [ start.player.cStarts intValue];
        temp ++;
        start.player.cStarts =  [NSNumber numberWithInt:temp];
    }
    
    //Player Goals
    NSArray *gameGoalsArray = [game.gameScore allObjects];
    for (GameScore *score in gameGoalsArray){
        
        int temp = [ score.player.cGoals intValue];
        temp ++;
        score.player.cGoals =  [NSNumber numberWithInt:temp];
    }
    
    //Playing Time Total
    NSArray *gameSubsArray = [game.gameSub allObjects];
    for (GameSub *sub in gameSubsArray){
        
        int temp = [ sub.player.cPlayingTime intValue];
        int startTime = [sub.startTime intValue];
        int endtime = [sub.endTime intValue];
        temp = temp + (endtime - startTime );
        sub.player.cPlayingTime =  [NSNumber numberWithInt:temp];
    }
    
    //Remove Duplicate Entries
    //Playing Time Total
    NSArray *gameSubsArray2 = [game.gameSub allObjects];
    for (GameSub *sub in gameSubsArray2){
        
        int startTime = [sub.startTime intValue];
        int endtime = [sub.endTime intValue];
        if(startTime == endtime){
            [managedObjectContext deleteObject:sub];
        }
    }
    
    //SAVE 
	NSError *error = nil;
	if (![managedObjectContext save:&error]) {
        
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}		

    // NSLog(@"Exiting %s", __PRETTY_FUNCTION__); 
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
    
    //NSLog(@"Entering %s", __PRETTY_FUNCTION__);
    
    //Singleton
    sharedInstance = self;
    
    //Check if the scene is running prior to loading a newone
    CCScene *scene = [[CCDirector sharedDirector] runningScene];    
    if(scene == nil)
    {
        //Start Coco with a new Scene
        [self startCocos2d];
        //NSLog(@"Run Cocos2d");
        
    }
    /*
    else 
    {
        //Resume a scene
        //[self attachView]; 
        //NSLog(@"attached View");
        
        //Start new Scene
    }
     */
    //NSLog(@"Exiting %s", __PRETTY_FUNCTION__);
}

- (void)viewWillAppear:(BOOL)animated{
    
    //NSLog(@"Entering %s", __PRETTY_FUNCTION__);
    /*
    //Check if the scene is running prior to loading a newone
    CCScene *scene = [[CCDirector sharedDirector] runningScene];    
    if(scene == nil)
    {
        //Run a new Scene
        [self runCocos2d];
        NSLog(@"Run Cocos2d");
    }else
    {
        NSLog(@"Scene Already loaded");
    }*/
    if (state == kgamePaused){
        [self attachView];
    }else if(state == kgameEnded){
        [self runNewGame];
    }else if (state == kgameStopped){
        [self startCocos2d];
    }
    
    
    //NSLog(@"Exiting %s", __PRETTY_FUNCTION__);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    //NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
 	if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
	   interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        
        return YES;
        
    }   
    
    //All others NO
	return NO;
}

@end
