//
//  WelcomeLayer.m
//  Duck
//
//  Created by Anton on 9/12/14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import "WelcomeLayer.h"
#import "Global.h"
#import "MenuLayer.h"s

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
       //  CCSpriteBatchNode *basicSpriteSheet1  = [CCSpriteBatchNode batchNodeWithFile:@"basic.png"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"basic2.plist"];
        
      
       //  CCSpriteBatchNode *basicSpriteSheet2  = [CCSpriteBatchNode batchNodeWithFile:@"basic.png"];

        
        current_level =0;
        
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
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFlipX transitionWithDuration:0.5 scene:MenuLayer.scene]];
        cnt =0;
    }
    
}

@end