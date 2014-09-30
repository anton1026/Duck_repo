//
//  WelcomeLayer.m
//  Duck
//
//  Created by Anton on 9/12/14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import "WelcomeLayer.h"
#import "Global.h"
#import "MenuLayer.h"
#import "GameLevel.h"

#define Delay 30


@implementation WelcomeLayer{
   
}


// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	WelcomeLayer *layer = [WelcomeLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}
-(id) init
{
	if( (self=[super init])) {
        
		// ask director for the window size
        
		CGSize size = [[CCDirector sharedDirector] winSize];
        WIN_SIZE_X =size.width;
        WIN_SIZE_Y =size.height;
        
        g_fx = size.width/1024.0f;
        g_fy = size.height/768.0f;
        
        
        if([[UIScreen mainScreen] respondsToSelector:@selector(scale)]){
            NSLog(@"scale =%f",[[UIScreen mainScreen]scale]);
            if  ([[UIScreen mainScreen]scale] >1.0){
                NSLog(@"Retain");
                flag_retain =true;
                g_fx1=2;
                g_fy1=2;
                
            }else{
                NSLog(@"iPad2");
                flag_retain =false;
                g_fx1=1;
                g_fy1=1;
            }
        }
        
		CCSprite *background;
		
//		if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
//			background = [CCSprite spriteWithFile:@"Default.png"];
//			background.rotation = 90;
//		} else {
		//	background = [CCSprite spriteWithFile:@"Default-Landscape~ipad.png"];
//}
      	background = [CCSprite spriteWithFile:@"welcome.png"];
        
        [background setScaleX:g_fx*g_fx1];
        [background setScaleY:g_fy*g_fy1];
  		background.position = ccp(size.width/2, size.height/2);
        [self addChild: background];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"basic.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"basic2.plist"];
        
      
       

        bFirst =true;
        current_level =1;
        openLevels =1;
        LeftRightKef =50;
        UpDownKef =50;
        ShowButtons =1;
        [self schedule:@selector(ontime:) interval:1.0f/20.0f];

       // [self schedule:@"ontime" interval:1.0f/20.0f];
    }
	
	return self;
}
-(void) ontime : (ccTime) dt
{
    
     cnt++;
    if (cnt>Delay){
        [self unschedule:@selector(ontime)];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionShrinkGrow transitionWithDuration:0.5 scene:MenuLayer.scene]];
        cnt =0;
    }

    
    if(bFirst)
    {
   //     long time = 1000;//SystemClock.uptimeMillis();
    
        GameLevel *level1 =[[GameLevel alloc] initWithXMLFile:@"level1" Src:@"Amazonka"];
        GameLevel *level2 =[[GameLevel alloc] initWithXMLFile:@"level2" Src:@"Level2"];
        GameLevel *level3 =[[GameLevel alloc] initWithXMLFile:@"level3" Src:@"Level3"];
        GameLevel *level4=[[GameLevel alloc] initWithXMLFile:@"level4" Src:@"Level4"];
        GameLevel *level5 =[[GameLevel alloc] initWithXMLFile:@"level5" Src:@"Level5"];
        GameLevel *level6 =[[GameLevel alloc] initWithXMLFile:@"level6" Src:@"Level6"];
        GameLevel *level7 =[[GameLevel alloc] initWithXMLFile:@"level7" Src:@"Level7"];
        GameLevel *level8 =[[GameLevel alloc] initWithXMLFile:@"level8" Src:@"Level8"];
        GameLevel *level9 =[[GameLevel alloc] initWithXMLFile:@"level9" Src:@"Level9"];
        GameLevel *level10 =[[GameLevel alloc] initWithXMLFile:@"level10" Src:@"Level10"];
    
    //settings for levels
    level1.m_NumberHunters = 20;
    //level1.m_HunterLives = 2;
    level1.m_HunterLives = 1;
    level1.m_HunterPulaCnt = 1;
    level1.m_PulaSpeed = 300;
    level1.m_MaxBombs = 2;
    level1.m_MinDelayBomb = 10000;
    level1.m_MaxAddDelayBomb = 10000;
    
    level1.m_MaxBonus = 1;
    level1.m_MinDelayBonus = 10000;
    level1.m_MaxAddDelayBonus = 10000;
    
    level1.m_MaxLives = 1;
    level1.m_MinDelayLives = 10000;
    level1.m_MaxAddDelayLives = 10000;
    // ---------------------------------
    
    
    level2.m_NumberHunters = 30;
    level2.m_HunterLives = 2;
    level2.m_HunterLives = 1;
    level2.m_HunterPulaCnt = 1;
    level2.m_PulaSpeed = 330;
    level2.m_MaxBombs = 2;
    level2.m_MinDelayBomb = 10000;
    level2.m_MaxAddDelayBomb = 10000;
	
    level2.m_MaxBonus = 1;
    level2.m_MinDelayBonus = 8000;
    level2.m_MaxAddDelayBonus = 8000;
    
    level2.m_MaxLives = 2;
    level2.m_MinDelayLives = 10000;
    level2.m_MaxAddDelayLives = 10000;
    // ---------------------------------
    
    level3.m_NumberHunters = 45;
    level3.m_HunterLives = 2;
    level3.m_HunterLives = 1;
    level3.m_HunterPulaCnt = 2;
    level3.m_PulaSpeed = 330;
    level3.m_MaxBombs = 2;
    level3.m_MinDelayBomb = 10000;
    level3.m_MaxAddDelayBomb = 10000;
    
    level3.m_MaxBonus = 1;
    level3.m_MinDelayBonus = 8000;
    level3.m_MaxAddDelayBonus = 8000;
    
    level3.m_MaxLives = 2;
    level3.m_MinDelayLives = 8000;
    level3.m_MaxAddDelayLives = 8000;
    // ---------------------------------
    
    level4.m_NumberHunters = 60;
    level4.m_HunterLives = 3;
    level4.m_HunterLives = 1;
    level4.m_HunterPulaCnt = 2;
    level4.m_PulaSpeed = 345;
    level4.m_MaxBombs = 2;
    level4.m_MinDelayBomb = 7000;
    level4.m_MaxAddDelayBomb = 7000;
    
    level4.m_MaxBonus = 2;
    level4.m_MinDelayBonus = 8000;
    level4.m_MaxAddDelayBonus = 8000;
    
    level4.m_MaxLives = 3;
    level4.m_MinDelayLives = 8000;
    level4.m_MaxAddDelayLives = 8000;
    // ---------------------------------
    
    level5.m_NumberHunters = 75;
    level5.m_HunterLives = 3;
    level5.m_HunterPulaCnt = 2;
    level5.m_PulaSpeed = 345;
    level5.m_MaxBombs = 2;
    level5.m_MinDelayBomb = 5000;
    level5.m_MaxAddDelayBomb = 5000;
    
    level5.m_MaxBonus = 2;
    level5.m_MinDelayBonus = 8000;
    level5.m_MaxAddDelayBonus = 8000;
    
    level5.m_MaxLives = 3;
    level5.m_MinDelayLives = 6000;
    level5.m_MaxAddDelayLives = 6000;
    // ---------------------------------
    
    
    level6.m_NumberHunters = 90;
    level6.m_HunterLives = 4;
    level6.m_HunterPulaCnt = 2;
    level6.m_PulaSpeed = 360;
    level6.m_MaxBombs = 4;
    level6.m_MinDelayBomb = 5000;
    level6.m_MaxAddDelayBomb = 5000;
    
    level6.m_MaxBonus = 3;
    level6.m_MinDelayBonus = 8000;
    level6.m_MaxAddDelayBonus = 8000;
    
    level6.m_MaxLives = 3;
    level6.m_MinDelayLives = 5000;
    level6.m_MaxAddDelayLives = 5000;
    // ---------------------------------
    
    level7.m_NumberHunters = 105;
    level7.m_HunterLives = 4;
    level7.m_HunterPulaCnt = 2;
    level7.m_PulaSpeed = 360;
    level7.m_MaxBombs = 4;
    level7.m_MinDelayBomb = 5000;
    level7.m_MaxAddDelayBomb = 5000;
    
    level7.m_MaxBonus = 3;
    level7.m_MinDelayBonus = 8000;
    level7.m_MaxAddDelayBonus = 8000;
    
    level7.m_MaxLives = 3;
    level7.m_MinDelayLives = 5000;
    level7.m_MaxAddDelayLives = 5000;
    // ---------------------------------
    
    level8.m_NumberHunters = 140;
    level8.m_HunterLives = 4;
    level8.m_HunterPulaCnt = 2;
    level8.m_PulaSpeed = 360;
    level8.m_MaxBombs = 6;
    level8.m_MinDelayBomb = 5000;
    level8.m_MaxAddDelayBomb = 5000;
    
    level8.m_MaxBonus = 3;
    level8.m_MinDelayBonus = 6000;
    level8.m_MaxAddDelayBonus = 6000;
    
    level8.m_MaxLives = 4;
    level8.m_MinDelayLives = 5000;
    level8.m_MaxAddDelayLives = 5000;
    // ---------------------------------
    
    
    level9.m_NumberHunters = 160;
    level9.m_HunterLives = 5;
    level9.m_HunterPulaCnt = 2;
    level9.m_PulaSpeed = 375;
    level9.m_MaxBombs = 2;
    level9.m_MinDelayBomb = 5000;
    level9.m_MaxAddDelayBomb = 5000;
    
    level9.m_MaxBonus = 3;
    level9.m_MinDelayBonus = 6000;
    level9.m_MaxAddDelayBonus = 6000;
    
    level9.m_MaxLives = 4;
    level9.m_MinDelayLives = 5000;
    level9.m_MaxAddDelayLives = 5000;
    // ---------------------------------
    
    level10.m_NumberHunters = 190;
    level10.m_HunterLives = 5;
    level10.m_HunterPulaCnt = 2;
    level10.m_PulaSpeed = 390;
    level10.m_MaxBombs = 5;
    level10.m_MinDelayBomb = 5000;
    level10.m_MaxAddDelayBomb = 5000;
    
    level10.m_MaxBonus = 2;
    level10.m_MinDelayBonus = 5000;
    level10.m_MaxAddDelayBonus = 5000;
    
    level10.m_MaxLives = 4;
    level10.m_MinDelayLives = 5000;
    level10.m_MaxAddDelayLives = 5000;
    // ---------------------------------
     Level_Lists = [[NSMutableArray alloc] init];
        
     [Level_Lists addObject:level1];
     [Level_Lists addObject:level2];
     [Level_Lists addObject:level3];
     [Level_Lists addObject:level4];
     [Level_Lists addObject:level5];
     [Level_Lists addObject:level6];
     [Level_Lists addObject:level7];
     [Level_Lists addObject:level8];
     [Level_Lists addObject:level9];
     [Level_Lists addObject:level10];
        
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"basic.plist"];
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"basic2.plist"];
        
    
//     long delta = 100;//SystemClock.uptimeMillis() - time;
//      if (delta < DELAY)
//      {
//        try {
//            Thread.sleep(DELAY-delta);
//        } catch (InterruptedException e) {
//            e.printStackTrace();
//        }
//    }
//    
    bFirst = false;
    
    }
}

@end