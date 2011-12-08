//
//  ChalkTalkViewController.m
//  CoachTools
//
//  Created by Chris Desch on 12/8/11.
//  Copyright (c) 2011 Desch Enterprises. All rights reserved.
//

#import "ChalkTalkViewController.h"
#import "cocos2d.h"
#import "ChalkTalkLayer.h"

@implementation ChalkTalkViewController

@synthesize mainView;
@synthesize navBar;

@synthesize chalkTalkScene;
@synthesize endButtonItem;


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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CCScene *scene = [[CCDirector sharedDirector] runningScene];    
    if(scene == nil)
    {
        //Start Coco with a new Scene
        [self startCocos2d];
        //NSLog(@"Run Cocos2d");
        
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



- (void) startCocos2d{
    
    
    NSLog(@"Entering %s", __PRETTY_FUNCTION__);
    NSLog(@"Running...");
    
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
    chalkTalkScene = [ChalkTalkLayer node];
    
    //id node = [HelloWorldLayer node];
    //id node = [GameScene node];
    //id node = [SelectStartersLayer node];
    //[scene addChild: node z:0];
    
    [director runWithScene:chalkTalkScene];
    

    
    //NSLog(@"Exiting %s", __PRETTY_FUNCTION__); 
}

- (void) endCocos2d
{
    NSLog(@"Entering %s", __PRETTY_FUNCTION__); 
    NSLog(@"Ending...");
    CCDirector *director = [CCDirector sharedDirector];
    
    // Since v0.99.4 you have to remove the OpenGL View manually
    EAGLView *view = [director openGLView];
    
    [view removeFromSuperview];
    
    // kill the director
    [director end];
   
    
}
//Since Coco is already running, run a new game.   
- (void)runNewGame{
    NSLog(@"Entering %s", __PRETTY_FUNCTION__); 
    //Check if the game has been played.
    
    //Run the new game
    CCDirector *director = [CCDirector sharedDirector];
    
    CCScene *scene = [CCScene node];
    id node = [ChalkTalkLayer node];
    [scene addChild: node z:0];
    
    [director replaceScene:scene];

    
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
    NSLog(@"Entering %s", __PRETTY_FUNCTION__); 
    NSLog(@"Attaching...");
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

- (IBAction)endGameButton:(id)sender{
    
    [self endCocos2d];
    [self dismissModalViewControllerAnimated:YES];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    // Return YES for supported orientations
 	if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
	   interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        
        return YES;
    }   
    
    //All others NO
	return NO;
}
@end
