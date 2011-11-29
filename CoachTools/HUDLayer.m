//
//  HUDLayer.m
//  CoachTools
//
//  Created by cj on 5/17/11.
//  Copyright 2011 Desch Enterprises. All rights reserved.
//

#import "HUDLayer.h"
#import "GameScene.h"
#import "ConfigMenuViewController.h"
#import "CocoaHelper.h"

#import "Formation.h"
#import "FormationPosition.h"

#import "GameManagementViewController.h"
#import "GameLogViewController.h"

@implementation HUDLayer

@synthesize bench;
@synthesize configMenuViewController;

-(id) init
{
	if( (self=[super init] ) )
	{
        benchState = FALSE;
        
		self.isTouchEnabled = YES;
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        //CCLabelTTF *label = [CCLabelTTF labelWithString:@"HUD Layer" fontName:@"Helvetica" fontSize:40];
		//label.position =  ccp( 500 , 675 ); //size.height/2 // 750
		//add the label as a child to this Layer
		//[self addChild: label];
        
        //Setup bench
        bench = [CCSprite spriteWithFile:@"bench2.png"];
        CGSize benchSize = [bench contentSize];
        benchShowPosition = CGPointMake(benchSize.width / 2, size.height/2 ); 
        benchHidePosition = CGPointMake(- benchSize.width /2,  size.height/2); 
        [bench setPosition:benchHidePosition];
        
        [self addChild:bench];

        //Setup on screen buttons for bench and configuration menu
        CCMenuItemFont *benchButton = [CCMenuItemFont itemFromString:@"Bench" target:self selector:@selector(bench:)];
		benchButton.position=ccp(950,25);
        
        CCMenuItemFont *logButton = [CCMenuItemFont itemFromString:@"Game Log" target:self selector:@selector(logAction:)];
		logButton.position=ccp(650,25);
        
        CCMenuItemFont *configButton = [CCMenuItemFont itemFromString:@"Config Menu" target:self selector:@selector(config:)];
		configButton.position=ccp(350,25);
        
        CCMenu *menu = [CCMenu menuWithItems:benchButton,logButton,configButton, nil];
		[self addChild:menu];
		menu.position=ccp(0,0);
        
        // --- Game Management Config Menu --- // Modal View Controll
        // allocate for later display
        configMenuViewController = [[ConfigMenuViewController alloc] initWithNibName:@"ConfigMenuViewController" bundle:nil];
        
        //Set delegate as self for the delegate protocol
        configMenuViewController.delegate = self;
        
	}
	return self;
}

- (void) dealloc
{
    [configMenuViewController release];
	[super dealloc];
}

- (void)bench:(id)sender{
    
    CGSize benchSize = [bench contentSize];
    BackgroundLayer* bg = [[GameScene sharedScene] backgroundLayer];
    PlayerLayer* pl = [[GameScene sharedScene] playerLayer];
    
    if(benchState == FALSE){
        //Extend Bench
        benchState = TRUE;
        [bg runAction:[CCMoveTo actionWithDuration:1 position:CGPointMake(benchSize.width, 0)]];
        [pl benchOffSet:benchSize.width];
        [bench runAction: [CCMoveTo actionWithDuration:1 position:benchShowPosition]];

    }else if(benchState == TRUE)
    {
        //Retract Bench
        benchState = FALSE;
        [bg runAction:[CCMoveTo actionWithDuration:1 position:CGPointMake( 0 , 0)]];
        [pl benchOffSet:(-benchSize.width)];
        [bench runAction:[CCMoveTo actionWithDuration:1 position:benchHidePosition]];
    }
    
}

- (void)logAction:(id)sender{
    GameLogViewController *viewController = [[GameLogViewController alloc] initWithNibName:@"GameLogViewController" bundle:nil gameSelected:[GameManagementViewController sharedController].game gameRunning:TRUE];
    
    UINavigationController        *navController;
    navController = [[ UINavigationController alloc ]
                     initWithRootViewController: viewController ];
    navController.view.frame = CGRectMake(0, 0, 1024, 771);
    viewController.delegate = self;
    [CocoaHelper showUIViewController:navController];
    
    [viewController release];
    [navController release];
    
}

- (void)hideViewController:(GameLogViewController *)viewController{
    [CocoaHelper hideUIViewController];
}

- (void)config:(id)sender{
 
    [CocoaHelper showUIViewController:configMenuViewController];
    
}


//Send the formation to the ConfigureMenuViewController to the PlayerLayer
- (void)setFormation:(ConfigMenuViewController *)setFormation formation:(NSString *)formationName{
    
    //Check if the bench is out first -  Move it back if it is
    if(benchState == TRUE)
    {
        CGSize benchSize = [bench contentSize];
        BackgroundLayer* bg = [[GameScene sharedScene] backgroundLayer];
        PlayerLayer* pl = [[GameScene sharedScene] playerLayer];
        
        benchState = FALSE;
        [bg runAction:[CCMoveTo actionWithDuration:0 position:CGPointMake( 0 , 0)]];
        [pl benchOffSet:(-benchSize.width)];
        [bench runAction:[CCMoveTo actionWithDuration:0 position:benchHidePosition]];
    }
    
    //Change the player formation
    PlayerLayer* pl = [[GameScene sharedScene] playerLayer];
    [pl setFormation:formationName];
    
}


@end
