//
//  SelectLayer.m
//  Duck
//
//  Created by Anton on 9/13/14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import "SelectLayer.h"
#import "SimpleAudioEngine.h"
#import "Global.h"
#import "MenuLayer.h"
#import "GameLayer.h"
#define Cancel_X (IS_IPAD ? 40 : 40)
#define Cancel_Y (IS_IPAD ? 720 : 750)

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
        [self setScaleY:g_fy*g_fy1];
        [self setPosition: ccp(0,0)];
      	
        m_menuSprite = [CCSprite spriteWithFile:@"selectmenu.png"];
		[m_menuSprite setPosition:ccp(1024 / 2*g_fx, 768 / 2*g_fy)];
  	    [self addChild:m_menuSprite z:1];
        
        
        
        CCSpriteFrame *cframe =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"menu.png"];
        m_Cancel  = [CCSprite spriteWithSpriteFrame:cframe];
        [self addChild:m_Cancel z:2];
        [m_Cancel setScale: 0.4f];
        [m_Cancel setPosition: ccp(Cancel_X*g_fx,Cancel_Y*g_fy)];
        [m_Cancel setOpacity:180];
        
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"select.plist"];
      

        NSString *spriteName = [NSString stringWithFormat:@"Select%d.png",current_level+1];
        CCSpriteFrame *cframe1 =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:spriteName];
       
        m_selectSprite =[CCSprite spriteWithSpriteFrame:cframe1];
        [m_selectSprite setPosition:ccp((1024 / 2 + 20)*g_fx, (768/2 + 234)*g_fy)];
      //  [m_selectSprite setScaleY:1.05f];
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
        //return
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionShrinkGrow transitionWithDuration:0.5 scene:MenuLayer.scene]];
        
    }else if (x > 130 && x < 230 && y > 530 && y < 650){
        //Level Down
        if(current_level >1)
             current_level--;
        
    }else if (x > 760 && x < 900 && y > 530 && y < 650){
        // Level Up
        if(current_level<10)
            current_level++;
        
    }else if (x > 270 && x < 750 && y > 550 && y < 660){
        // Game Start
       
       [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
       [[CCDirector sharedDirector] replaceScene:[CCTransitionShrinkGrow transitionWithDuration:0.5 scene:GameLayer.scene
                                               ]];

        
    }
}




@end
