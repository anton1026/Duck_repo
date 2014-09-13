//
//  MenuLayer.m
//  Duck
//
//  Created by Anton on 9/13/14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import "MenuLayer.h"

#import "SimpleAudioEngine.h"
#import "Global.h"
#import "SetupLayer.h"
#import "SelectLayer.h"

@implementation MenuLayer{
    CCSprite *m_Cancel;
}

//float g_fx,g_fy,g_fx1,g_fy1;
//bool flag_retain=false;
// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MenuLayer *layer = [MenuLayer node];
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
	if( (self=[super init])) {
         [self setTouchEnabled:true];
		// ask director for the window size
        
		CGSize size = [[CCDirector sharedDirector] winSize];
     	CCSprite *background;
        if (_isRus)
            background = [CCSprite spriteWithFile:@"mainmenurus.png"];
        else
            background = [CCSprite spriteWithFile:@"mainmenu.png"];
            
        [background setScaleX:g_fx*g_fx1];
        [background setScaleY:g_fy*g_fy1];
        
		background.position = ccp(size.width/2, size.height/2);
        [self addChild: background];
        
        CCSpriteFrame *cframe =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"menu.png"];
        m_Cancel  = [CCSprite spriteWithSpriteFrame:cframe];
        [self addChild:m_Cancel z:5];
        [m_Cancel setScale: 0.4f];
        [m_Cancel setPosition: ccp(40*g_fx,720*g_fy)];
        [m_Cancel setOpacity:180];

        
        
        
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"menu.mp3"];
        
        
        
//        [self schedule:@"ontime" interval:1.0f/20.0f];
    }
	
	return self;
}
- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event

{
    UITouch *touch = [touches anyObject];
    CGPoint location = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    
    float x,y;
    x =location.x/g_fx;
    y =location.y/g_fy;
    if (x>0 && x<150 && y>650){
        exit(0);
    }else if(x > 225 && x < 780 && y > 0 && y < 115){
        //option
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFlipX transitionWithDuration:0.5 scene:SetupLayer.scene]];

    
    }else if (x > 225 && x < 770 && y > 500 && y < 650){
        // Tutorial
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFlipX transitionWithDuration:0.5 scene:SelectLayer.scene]];

        
    }else if (x > 320 && x < 700 && y > 650 && y < 800){
        	// Game
    }
}

@end
