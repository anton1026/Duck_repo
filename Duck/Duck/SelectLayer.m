//
//  SelectLayer.m
//  Duck
//
//  Created by Denis A on 9/13/14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import "SelectLayer.h"
#import "SimpleAudioEngine.h"
#import "Global.h"
#import "MenuLayer.h"

@implementation SelectLayer
{
    CCSprite *m_menuSprite;
    CCSprite *m_selectSprite;
    CCSprite *m_Cancel;
}

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	SelectLayer *layer = [SelectLayer node];
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
        
        [self setScaleX:g_fx*g_fx1];
     //   [self setScaleY:g_fy*g_fy1];
        [self setPosition: ccp(0,0)];
      	
        m_menuSprite = [CCSprite spriteWithFile:@"selectmenu.png"];
		[m_menuSprite setPosition:ccp(1024 / 2*g_fx, 768 / 2*g_fy)];
  	    [self addChild:m_menuSprite z:1];
        
        
        
        CCSpriteFrame *cframe =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"menu.png"];
        m_Cancel  = [CCSprite spriteWithSpriteFrame:cframe];
        [self addChild:m_Cancel z:1];
        [m_Cancel setScale: 0.4f*g_fx*g_fy];
        [m_Cancel setPosition: ccp(40*g_fx,720*g_fy)];
        [m_Cancel setOpacity:180];
        
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"select.plist"];
      

        NSString *spriteName = [NSString stringWithFormat:@"Select%d.png",current_level+1];
        CCSpriteFrame *cframe1 =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:spriteName];
       
        m_selectSprite =[CCSprite spriteWithSpriteFrame:cframe1];
        [m_selectSprite setPosition:ccp((1024 / 2 + 20)*g_fx, (768/2 + 234)*g_fy)];
        [m_selectSprite setScaleY:1.05f];
        [self addChild:m_selectSprite z:2];
        
        
        
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
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFlipX transitionWithDuration:0.5 scene:MenuLayer.scene]];
        
    }else if(x > 225 && x < 780 && y > 0 && y < 115){
        //option
        
    }else if (x > 225 && x < 770 && y > 500 && y < 580){
        // Tutorial
        
    }else if (x > 320 && x < 700 && y > 580 && y < 755){
        // Game
    }
}




@end
