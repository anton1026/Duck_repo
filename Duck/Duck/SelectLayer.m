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
#import "Numbers.h"
#import "GameLayer.h"
#define Cancel_X (IS_IPAD ? 40 : 40)
#define Cancel_Y (IS_IPAD ? 720 : 720)

@implementation SelectLayer
{
    CCSprite *m_menuSprite;
    CCSprite *m_selectSprite;
    CCSprite *m_Cancel;
    
   
	CCLabelTTF *m_labelX, *m_labelY;
	CCLabelTTF *m_labelWait;
	
	//CCScene scene;
	
    Numbers *numHunters, *numBonuses;
	
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
        
        [self setScaleX:g_fx];
        [self setScaleY:g_fy];
        
        
        [self setPosition: ccp(-(1024 - size.width)*g_fx / 2.0f
                               , -(768 - size.height)*g_fy / 2.0f)];
        
        
        
      	
        m_menuSprite = [CCSprite spriteWithFile:@"selectmenu.png"];
        [m_menuSprite setScaleX:g_fx1];
        [m_menuSprite setScaleY:g_fy1];
        
		[m_menuSprite setPosition:ccp(1024 / 2, 768 / 2)];
  	    [self addChild:m_menuSprite z:1];
        
        
        
        CCSpriteFrame *cframe =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"menu.png"];
        m_Cancel  = [CCSprite spriteWithSpriteFrame:cframe];
        [self addChild:m_Cancel z:2];
        [m_Cancel setScale: 0.4f*g_fx1];
        [m_Cancel setPosition: ccp(Cancel_X,Cancel_Y)];
        [m_Cancel setOpacity:180];
        
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"select.plist"];
      

        NSString *spriteName = [NSString stringWithFormat:@"Select%d.png",current_level];
        CCSpriteFrame *cframe1 =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:spriteName];
       
        m_selectSprite =[CCSprite spriteWithSpriteFrame:cframe1];
        [m_selectSprite setPosition:ccp((1024 / 2 + 20), (768/2 + 234))];
        
        [m_selectSprite setScaleX:g_fx1];
        [m_selectSprite setScaleY:g_fy1];
        
        [self addChild:m_selectSprite z:0];
        
        
        
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"menu.mp3"];
        
        numHunters = [[Numbers alloc]init];
		[self addChild:numHunters z: 10];
		[numHunters setScale:0.8f*g_fx1];
		[numHunters setPosition: CGPointMake((1024 / 2 + 20 - 120), (768/2 + 234 - 350))];
        
		[numHunters setVisible :true];
		GameLevel *level = Level_Lists[current_level];
		[numHunters SetNum:level.m_NumberHunters];
        
		numBonuses = [[Numbers alloc]init];
		[self addChild :numBonuses  z:10];
		[numBonuses setScale:0.8f*g_fx1];
		[numBonuses setPosition: CGPointMake((1024 / 2 + 20 + 70), (768/2 + 234 - 350))];
		[numBonuses setVisible:true];
		[numBonuses SetNum:level.m_MaxBombs];
        
        
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
        if(current_level >1){
             current_level--;
        
        [self removeChild:m_selectSprite cleanup:true];
        
        NSString *spriteName = [NSString stringWithFormat:@"Select%d.png",current_level];
        CCSpriteFrame *cframe1 =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:spriteName];
        
        m_selectSprite =[CCSprite spriteWithSpriteFrame:cframe1];
        [m_selectSprite setPosition:ccp((1024 / 2 + 20), (768/2 + 234))];
            [m_selectSprite setScaleX:g_fx1];
            [m_selectSprite setScaleY:g_fy1];
            
        if (current_level > openLevels)
           [m_selectSprite setOpacity:100];
            [self addChild: m_selectSprite z:0];
        
            GameLevel *level = Level_Lists[current_level-1];
            [numHunters SetNum:level.m_NumberHunters];
            [numBonuses SetNum:level.m_MaxBombs];
        }

    }else if (x > 800 && x < 950 && y > 530 && y < 650){
        // Level Up
        if(current_level<10){
            current_level++;
        [self removeChild:m_selectSprite cleanup:true];
        
        NSString *spriteName = [NSString stringWithFormat:@"Select%d.png",current_level];
        CCSpriteFrame *cframe1 =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:spriteName];
        
        m_selectSprite =[CCSprite spriteWithSpriteFrame:cframe1];
        [m_selectSprite setPosition:ccp((1024 / 2 + 20), (768/2 + 234))];
            
        [m_selectSprite setScaleX:g_fx1];
        [m_selectSprite setScaleY:g_fy1];
        
        if (current_level > openLevels)
            [m_selectSprite setOpacity:100];
        [self addChild: m_selectSprite z:0];
        
        
        GameLevel *level = Level_Lists[current_level-1];
        [numHunters SetNum:level.m_NumberHunters];
        [numBonuses SetNum:level.m_MaxBombs];
        }

        
    }else if (x > 270 && x < 750 && y > 550 && y < 660){
        // Game Start
       
       [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
       [[CCDirector sharedDirector] replaceScene:[CCTransitionShrinkGrow transitionWithDuration:0.5 scene:GameLayer.scene
                                               ]];

        
    }
}




@end
