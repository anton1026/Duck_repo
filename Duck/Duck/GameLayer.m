//
//  GameLayer.m
//  Duck
//
//  Created by Anton on 9/14/14.

//  Copyright (c) 2014 Anton. All rights reserved.

//

#import "GameLayer.h"
#import "Global.h"
#import "SimpleAudioEngine.h"
#import  <Foundation/Foundation.h>
#import "SelectLayer.h"

@implementation GameLayer

static GameLayer *m_gameLayer;

+(GameLayer*)  getInstance{
    return m_gameLayer;
}

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLayer *layer = [GameLayer node];
	// add layer as a child to scene
	[scene addChild: layer];
	// return the scene
	return scene;
}

-(id) init
{
    int level_ind = current_level;
	if( (self=[super init])) {
        
        m_gameLayer =self;
        
      
        
        [self setTouchEnabled:true];
        [self setAccelerometerEnabled:true];
        
        [[UIAccelerometer sharedAccelerometer]setDelegate: self];
        
		// ask director for the window size
 		CGSize size = [[CCDirector sharedDirector] winSize];
        
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"play.mp3"];
        
     //------------------initialize Game Layer ----------------------------
        m_iLoadedLevel=-1;
        m_iLoadedHunter =-1;
        m_bEnd =false;
        bPaused =false;
        
        m_huntkillAction = nil;
		m_duckheadAction = nil;
		m_iAttack = 0;
        
		m_hunterSheet1 = nil;
		m_hunterAnimation1 = nil;
        
		m_bombs = [[NSMutableArray alloc] init];
  		m_hunters =[[NSMutableArray alloc]init];
        
		m_backgrounds =[[NSMutableArray alloc]init];
		m_flowers = [[NSMutableArray alloc]init];
		m_apples = [[NSMutableArray alloc]init];
		m_bonuses = [[NSMutableArray alloc]init];
		m_freeInd = [[NSMutableArray alloc]init];
        
        
        [m_apples addObject:[[Apple_Object alloc]init]];
        [m_apples addObject:[[Apple_Object alloc]init]];
        [m_apples addObject:[[Apple_Object alloc]init]];
        
        m_rootNode = [[CCNode alloc]init];
        
        
        [self setScaleX: g_fx];
        [self setScaleY: g_fy];
        
        [self setPosition: ccp(-(1024 - size.width) / 2.0f*g_fx
                              , -(768 - size.height) / 2.0f*g_fy)];
  	    [self addChild:m_rootNode];
        
        

        CCSpriteFrame *cframe = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_stay.png"];
      	m_duckSheet = [CCSpriteBatchNode batchNodeWithTexture:[cframe texture]];
        
        //  m_duckSheet =[CCSpriteBatchNode  batchNodeWithFile:@"duck_stay.png"];
        [m_rootNode addChild:m_duckSheet z:7];
        


		// save parameters needed for ccAccelerometrChange
        
		rcDuckStay = [[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_stay.png"] rect];
        
        
		rcDuckMove = [[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_move.png"] rect];
        

        rotatedDuckStay = [[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_stay.png"] rotated];
        
        rotatedDuckMove = [[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_move.png"] rotated];
        


		// create the animation
        
 		
        NSMutableArray *frames = [[NSMutableArray alloc]init];
        m_duckStrelAnimationUp = [[CCAnimation alloc]init];
        for(int i = 1; i <19  ; i++) {
            [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"duck_strel%d.png",i]]];
        }
        m_duckStrelAnimationUp  = [CCAnimation animationWithSpriteFrames:frames delay:0.05f];
        m_duckStrelAnimationUpFast  = [CCAnimation animationWithSpriteFrames:frames delay:0.025f];
        
        [frames removeAllObjects];
        m_duckStrelAnimationVbok = [[CCAnimation alloc]init];
        for(int i = 1; i <19  ; i++) {
            [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"strelaet_pramo%d.png",i]]];
        }
        m_duckStrelAnimationVbok  = [CCAnimation animationWithSpriteFrames:frames delay:0.05f];
        m_duckStrelAnimationVbokFast  = [CCAnimation animationWithSpriteFrames:frames delay:0.025f];
		
        
		m_duckStrelActionUp = [CCAnimate actionWithAnimation: m_duckStrelAnimationUp];
		m_duckStrelActionVbok =[CCAnimate actionWithAnimation:m_duckStrelAnimationVbok];
     	m_duckStrelActionUpFast =[CCAnimate actionWithAnimation:m_duckStrelAnimationUpFast];
        m_duckStrelActionVbokFast = [CCAnimate actionWithAnimation:m_duckStrelAnimationVbokFast];
       
        [frames removeAllObjects];
        for(int i = 1; i <4  ; i++) {
            [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"duck_dyn1_%d.png",i]]];
        }
        m_duckDyn1 = [CCAnimation animationWithSpriteFrames:frames delay:0.25f];

       [frames removeAllObjects];
        for(int i = 1; i <4  ; i++) {
            [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"duck_dyn2_%d.png",i]]];
        }
        
        m_duckDyn2 = [CCAnimation animationWithSpriteFrames:frames delay:0.25f];
       [frames removeAllObjects];
        for(int i = 0; i <4  ; i++) {
            [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"duck_kill1_%d.png",i % 2+1]]];
        }
        m_duckKill1 = [CCAnimation animationWithSpriteFrames:frames delay:0.15f];
        
       [frames removeAllObjects];
        for(int i = 0; i <4  ; i++) {
            [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"duck_kill2_%d.png",i % 2+1]]];
        }
        m_duckKill2 = [CCAnimation animationWithSpriteFrames:frames delay:0.15f];

        
        
        
		// create duck lives sprites
        
        cframe =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_head.png"];
        
		m_duckLiveHead =[CCSprite spriteWithSpriteFrame:cframe];
        [m_duckLiveHead setScale:g_fx1];

      	[m_rootNode addChild:m_duckLiveHead z: 100];
        
        
		m_duckLives = 9;
		m_duckLivesSprite = [[Numbers alloc]init];
     	[m_rootNode addChild: m_duckLivesSprite z: 10];

		[m_duckLivesSprite setScale:0.7f*g_fx1];
		[m_duckLivesSprite SetNum :m_duckLives];
		[m_duckLivesSprite setVisible:true];
        
	    m_numHuntersSprite = [[Numbers alloc]init];
        [m_rootNode addChild :m_numHuntersSprite z: 10];
        [m_numHuntersSprite setScale :0.7f*g_fx1];
        [m_numHuntersSprite setVisible:true];

		// create flower animation
        [frames removeAllObjects];
        for(int i = 1; i <10  ; i++) {
            [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"ss_00%d.png",i]]];
        }
        m_flowerAnim = [CCAnimation animationWithSpriteFrames:frames delay:0.1f];
        
        
		// create duck head sprite for popup
        cframe =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_head.png"];
        
	 	m_duckheadSprite = [CCSprite spriteWithSpriteFrame:cframe];
        [m_duckheadSprite setScale:g_fx1];
        
		[m_rootNode addChild :m_duckheadSprite z:500];
     	[m_duckheadSprite setVisible :false];
        
		// create bonus head sprite for popup
        
        cframe =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"bonus4.png"];
    	m_bonusheadSprite = [CCSprite spriteWithSpriteFrame:cframe];
		[m_bonusheadSprite setScale :0.8f*g_fx1];
        
		[m_rootNode addChild :m_bonusheadSprite z:500];
 		[m_bonusheadSprite setVisible:false];
        
		// apple sheet
        
        cframe =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"apple1.png"];
        
		// m_appleSheet = CCSpriteSheet.spriteSheet(cframe.getTexture());
		// m_rootNode.addChild(m_appleSheet, 7);
        
		// create the animation
       [frames removeAllObjects];
        for(int i = 2; i <6  ; i++) {
            [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"apple%d.png",i]]];
        }
        m_appleAnimation = [CCAnimation animationWithSpriteFrames:frames delay:0.1f];

        
        cframe =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"apple1.png"];
        
		for (Apple_Object *apple in m_apples)
        {

			apple.m_appleActionAnim = [CCAnimate actionWithAnimation:m_appleAnimation];
            
		    [apple.m_appleActionAnim setTag :0];
            
			apple.m_appleActionMove = [CCMoveTo actionWithDuration:2.0f position: CGPointMake(1.0f, 1.0f)];
            [apple.m_appleActionMove setTag:0];
            
			apple.m_appleSprite = [CCSprite spriteWithSpriteFrame:cframe];
            
			[apple.m_appleSprite setScale:g_fx1];
			[m_rootNode addChild:apple.m_appleSprite z:7];
            
    		[apple.m_appleSprite setVisible:false];
		}
        
        cframe =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"shoot1.png"];
  //---------------------test---------------
        ShowButtons =1;
        
        
		m_shootSprite = [CCSprite spriteWithSpriteFrame: cframe];
	    [m_shootSprite setScale:1.5f*g_fx1];
        
		[m_shootSprite setOpacity:160];
		[m_rootNode addChild :m_shootSprite z:135];
		[m_shootSprite setVisible: (ShowButtons == 1)];
        
		m_shootSprite2 = [CCSprite spriteWithSpriteFrame:cframe];
	    [m_shootSprite2 setScale:1.5f*g_fx1];
        [m_shootSprite2 setOpacity:160];
 		[m_rootNode addChild:m_shootSprite2 z:135];
    	[m_shootSprite2 setVisible:(ShowButtons == 1)];
        
		if (_isRus){
            m_shootLabel =[CCLabelTTF labelWithString:@"Forward"
                                         dimensions: CGSizeMake(200,200)
                                         hAlignment:UITextAlignmentCenter
                                         lineBreakMode:UILineBreakModeWordWrap
                                           fontName:@"Arial"
                                           fontSize:36];
            
            

        }
     	else{
            m_shootLabel =[CCLabelTTF labelWithString:@"Forward"
                                           dimensions: CGSizeMake(200,200)
                                           hAlignment:UITextAlignmentCenter
                                        lineBreakMode:UILineBreakModeWordWrap
                                             fontName:@"Arial"
                                             fontSize:36];

        }
        
		[m_shootLabel setColor: ccBLACK];
		[m_rootNode addChild:m_shootLabel z: 136];
        
		[m_shootLabel setVisible :(ShowButtons == 1)];
        
		if (_isRus)
			m_shootLabel2 =[CCLabelTTF labelWithString:@"Up"
                                           dimensions: CGSizeMake(200,200)
                                           hAlignment:UITextAlignmentCenter
                                        lineBreakMode:UILineBreakModeWordWrap
                                             fontName:@"Arial"
                                             fontSize:36];
        
		else
            m_shootLabel2 =[CCLabelTTF labelWithString:@"Up"
                                            dimensions: CGSizeMake(200,200)
                                            hAlignment:UITextAlignmentCenter
                                         lineBreakMode:UILineBreakModeWordWrap
                                              fontName:@"Arial"
                                              fontSize:36];
        
		[m_shootLabel2 setColor: ccBLACK];
     	[m_rootNode addChild: m_shootLabel2 z: 136];
        [m_shootLabel2 setVisible: (ShowButtons == 1)];
        
		m_duckSprite = [CCSprite spriteWithTexture: [m_duckSheet texture] rect: CGRectMake(3 * 119.0f, 3 * 113.5f, 119.0f, 113.5f)];
        [m_duckSprite setScale:g_fx1 ];
        [m_duckSheet addChild :m_duckSprite z: 5];
        
        
        [self SetDuckPosX:1024.0f*3.0f/2.0f PosY:768.0f/2.0/2.0f];
        
        
		// init birds
        m_Birds =[[CBirds alloc]initWithNode:m_rootNode];
        m_Orel =[[COrel alloc] initWithNode:m_rootNode];
        
		[m_Birds InitBirds];
		[m_Orel initOrel];
        
        cframe =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"menu.png"];
        
		m_cancelSprite = [CCSprite spriteWithSpriteFrame:cframe];
        
		[m_rootNode addChild :m_cancelSprite z: 100];
		[m_cancelSprite setScale :0.4f*g_fx1];
        [m_cancelSprite setOpacity :180];
        
        
        cframe =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"pause.png"];
      	m_pauseSprite = [CCSprite spriteWithSpriteFrame:cframe];
        
		[m_rootNode addChild:m_pauseSprite z: 100];
		[m_pauseSprite setScale :0.4f*g_fx1];
		[m_pauseSprite setOpacity :180];
        
		if (_isRus){
		//	m_labelWait = CCLabel.makeLabel("Ïîäîæäèòå...", "Arial", 64);
        } else{
            m_labelWait =[CCLabelTTF labelWithString:@"Please Wait..."
                                            dimensions: CGSizeMake(200,200)
                                            hAlignment:UITextAlignmentCenter
                                         lineBreakMode:UILineBreakModeWordWrap
                                              fontName:@"Arial"
                                              fontSize:64];
        }

				
		[m_labelWait setPosition :ccp(1024 / 2 + 20, 768 / 2 + 70)];
		[self addChild :m_labelWait z:200];
		[m_labelWait setVisible:false];
        
        
 	    cframe =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"bonus4.png"];
        
        m_bonusIcon = [CCSprite spriteWithSpriteFrame:cframe];
        [m_rootNode addChild:   m_bonusIcon];
        [m_bonusIcon setScale   :0.7f*g_fx1];
        [m_bonusIcon setOpacity :200];
		[m_bonusIcon setVisible :false];
        
        
		m_visibleWidth = (float) size.width/g_fx;
        
        
        _isduckActionEnd =true;
        
	    [self ChangeLevel:level_ind];
        
		      
		
		[m_numHuntersSprite SetNum:m_NumberHunters];
        
        
        [self scheduleUpdate];
      
    }
	
	return self;
}

-(void) ChangeLevel:(int) level
{
    
    m_YMin = 90;
    m_YMax = 170;
    
    if (level == 1) {
         m_CurLevel = Level_Lists[0];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level1.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level1_2.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level1_3.plist"];
        
        [self LoadHunterData:1];
        
    } else if (level == 2) {
        
     
         m_CurLevel = Level_Lists[1];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level2.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level2_2.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level2_3.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level2_4.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level2_5.plist"];
        [self LoadHunterData:6];

    } else if (level == 3) {
  
         m_CurLevel = Level_Lists[2];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level3.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level3_2.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level3_3.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level3_4.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level3_5.plist"];
        
        [self LoadHunterData:3];
    } else if (level == 4) {
        
     
         m_CurLevel = Level_Lists[3];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level4.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level4_2.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level4_3.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level4_4.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level4_5.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level4_6.plist"];
        [self LoadHunterData:5];
    } else if (level == 5) {

         m_CurLevel = Level_Lists[4];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level5.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level5_2.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level5_3.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level5_4.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level5_5.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level5_6.plist"];
        [self LoadHunterData:5];

    } else if (level == 6) {

         m_CurLevel = Level_Lists[5];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level6.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level6_2.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level6_3.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level6_4.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level6_5.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level6_6.plist"];
        [self LoadHunterData:7];

  
    } else if (level == 7) {
        m_YMin = 60;
 
         m_CurLevel = Level_Lists[6];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level7.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level7_2.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level7_3.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level7_4.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level7_5.plist"];
      
        [self LoadHunterData:3];

    } else if (level == 8) {
        m_YMin = 60;
        m_YMax = 140;
        
     
        
         m_CurLevel = Level_Lists[7];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level8.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level8_2.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level8_3.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level8_4.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level8_5.plist"];
        
        [self LoadHunterData:4];

    } else if (level == 9) {

         m_CurLevel = Level_Lists[8];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level9.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level9_2.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level9_3.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level9_4.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level9_5.plist"];
        
        [self LoadHunterData:2];

    } else if (level == 10) {
        m_YMin = 60;
        m_YMax = 140;
   
         m_CurLevel = Level_Lists[9];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level10.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level10_2.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level10_3.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level10_4.plist"];
         [self LoadHunterData:1];

    }
    
    m_iLoadedLevel = level;
    
    [self BuildWorld];
    
    m_NumberHunters = m_CurLevel.m_NumberHunters;
   
    [self  SetDuckPosX:1024.0f * 3.0f / 2.0f PosY: 768.0f / 2.0f / 2.0f];
}

-(void) UnloadCurrentLevel
{
    m_skyBox = nil;
    
    for (Background *b in m_backgrounds)
        [m_rootNode removeChild:b.sprite  cleanup:true];
    
    for (Hunter *h in m_hunters)
        [m_hunterSheet1 removeChild :h.sprite cleanup:true];
    
    for (Bomb *b in m_bombs)
    {
        [m_rootNode removeChild :b.bombtype1.sprite cleanup:true];
        [m_rootNode removeChild :b.bombtype2.sprite cleanup:true];
    }
    
    for (Hunter *h in m_hunters) {
        [h.sprite removeAllChildrenWithCleanup: true];
    }
    
    [m_backgrounds removeAllObjects];
    [m_backgrounds removeAllObjects];
    [m_hunters removeAllObjects];
    [m_bombs removeAllObjects];
    
    if (m_iLoadedLevel == 1) {
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level1.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level1_2.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level1_3.plist"];
        
        [CCTextureCache purgeSharedTextureCache];
        
//        MySettings.utilReleaseTexture("Level1/level1.png");
//        MySettings.utilReleaseTexture("Level1/level1_2.png");
//        MySettings.utilReleaseTexture("Level1/level1_3.png");
    } else if (m_iLoadedLevel == 2) {
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level2.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level2_2.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level2_3.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level2_4.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level2_5.plist"];
        
        [CCTextureCache purgeSharedTextureCache];
        
//        MySettings.utilReleaseTexture("Level2/level2.png");
//        MySettings.utilReleaseTexture("Level2/level2_2.png");
//        MySettings.utilReleaseTexture("Level2/level2_3.png");
//        MySettings.utilReleaseTexture("Level2/level2_4.png");
//        MySettings.utilReleaseTexture("Level2/level2_5.png");
    } else if (m_iLoadedLevel == 3) {
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level3.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level3_2.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level3_3.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level3_4.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level3_5.plist"];
        
        [CCTextureCache purgeSharedTextureCache];
        
//        MySettings.utilReleaseTexture("Level3/level3.png");
//        MySettings.utilReleaseTexture("Level3/level3_2.png");
//        MySettings.utilReleaseTexture("Level3/level3_3.png");
//        MySettings.utilReleaseTexture("Level3/level3_4.png");
//        MySettings.utilReleaseTexture("Level3/level3_5.png");
    } else if (m_iLoadedLevel == 4) {
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level4.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level4_2.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level4_3.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level4_4.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level4_5.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level4_6.plist"];
        
        [CCTextureCache purgeSharedTextureCache];

//        MySettings.utilReleaseTexture("Level4/level4.png");
//        MySettings.utilReleaseTexture("Level4/level4_2.png");
//        MySettings.utilReleaseTexture("Level4/level4_3.png");
//        MySettings.utilReleaseTexture("Level4/level4_4.png");
//        MySettings.utilReleaseTexture("Level4/level4_5.png");
//        MySettings.utilReleaseTexture("Level4/level4_6.png");
        
    } else if (m_iLoadedLevel == 5) {
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level5.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level5_2.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level5_3.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level5_4.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level5_5.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level5_6.plist"];
        
        [CCTextureCache purgeSharedTextureCache];
        
        
    } else if (m_iLoadedLevel == 6) {
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level6.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level6_2.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level6_3.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level6_4.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level6_5.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level6_6.plist"];
        
        [CCTextureCache purgeSharedTextureCache];
        
       
    } else if (m_iLoadedLevel == 7) {
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level7.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level7_2.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level7_3.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level7_4.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level7_5.plist"];

        
        [CCTextureCache purgeSharedTextureCache];
    } else if (m_iLoadedLevel == 8) {
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level8.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level8_2.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level8_3.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level8_4.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level8_5.plist"];

        
        [CCTextureCache purgeSharedTextureCache];
    } else if (m_iLoadedLevel == 9) {
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level9.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level9_2.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level9_3.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level9_4.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level9_5.plist"];

        
        [CCTextureCache purgeSharedTextureCache];
        
    } else if (m_iLoadedLevel == 10) {
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level10.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level10_2.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level10_3.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"level10_4.plist"];
        
        [CCTextureCache purgeSharedTextureCache];
    }
    m_iLoadedLevel = -1;
}


-(void) LoadHunterData :(int) type
{
    if (m_hunterSheet1 != nil) {
        [m_rootNode removeChild:m_hunterSheet1 cleanup:true];
        [m_hunterSheet1 cleanup];
         m_hunterSheet1 = nil;
    }
    
    if (m_hunterAnimation1 != nil) {
        m_hunterAnimation1 = nil;
    }
    if (m_hunterPulaAnimation1 != nil) {
        m_hunterPulaAnimation1 = nil;
    }
    
    if (m_huntkillSprite != nil) {
        [m_rootNode removeChild :m_huntkillSprite  cleanup :true];
        m_huntkillSprite = nil;
        m_huntkillAnimation = nil;
    }
    
    if (m_hunterHead != nil) {
        [m_rootNode removeChild:m_hunterHead cleanup:true];
        m_hunterHead = nil;
    }
    
    if (m_iLoadedHunter != -1) {
        NSString  *strPh =[NSString stringWithFormat:@"h%d.plist", m_iLoadedHunter];
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFrameByName:strPh];
    
    }
    
    m_iLoadedHunter = type;
    // hunter sheet
    NSString  *strPlist =[NSString stringWithFormat:@"h%d.plist", type];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:strPlist];
    
    
    NSString *strHunter = [NSString stringWithFormat:@"hunter%d.png", type];
    
    CCSpriteFrame *cframe = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:strHunter];
    m_hunterSheet1 = [CCSpriteBatchNode batchNodeWithTexture:[cframe texture]];

    m_hunterHead = [CCSprite  spriteWithSpriteFrame: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:strHunter]];
    
    [m_hunterHead setTextureRect: CGRectMake(0 * 176.0f, 0 * 161.0f, 176.0f/2,
                                              161.0f/2)];
    
    
    [m_hunterHead setScale :0.4f*g_fx1];
    [m_hunterHead setVisible :true];
    [m_rootNode addChild :m_hunterHead z:100];
    
    // hunter kill sprite and animation
    NSMutableArray *frames = [[NSMutableArray alloc]init];
    for(int i = 1; i <6  ; i++) {
        [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"hunt_kill%d.png",i]]];
    }
    m_huntkillAnimation  = [CCAnimation animationWithSpriteFrames:frames delay:0.15f];

    
    
    
    m_huntkillSprite = [CCSprite spriteWithSpriteFrame:
                        [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"hunt_kill1.png"]];
    
    [m_huntkillSprite setScale:g_fx1];
    
    [m_rootNode addChild :m_huntkillSprite z: 500];
    [m_huntkillSprite setVisible :false];
    
    
    ccTexParams params = {GL_LINEAR, GL_LINEAR, GL_CLAMP_TO_EDGE, GL_CLAMP_TO_EDGE};
    
    [[m_hunterSheet1 texture] setTexParameters: &params];
    
    [m_rootNode addChild :m_hunterSheet1  z:6];
    
    // create the hunters animation
    [frames removeAllObjects];
    for (int y = 0; y < 2; y++) {
        for (int x = 0; x < 5; x++) {
            CCSpriteFrame *frame = [CCSpriteFrame frameWithTexture:[m_hunterSheet1 texture] rect:CGRectMake(x * 176.0f, y * 161.0f, 176.0f/2, 161.0f/2) ];
            [frames addObject: frame];

        }
    }
    m_hunterAnimation1  = [CCAnimation animationWithSpriteFrames:frames delay:0.15f];
    [frames removeAllObjects];
    for (int x = 0; x < 5; x++) {
        
        CCSpriteFrame *frame = [CCSpriteFrame frameWithTexture:[m_hunterSheet1 texture] rect:CGRectMake(x * 176.0f, 3 * 161.0f, 176.0f/2, 161.0f/2) ];
        [frames addObject: frame];
    }
    m_hunterPulaAnimation1  = [CCAnimation animationWithSpriteFrames:frames delay:0.25f];

}

-(void) BuildWorld
{
    // create background
    for (BackgroundItem *bi in m_CurLevel.m_BackgroundItems) {
        
        
        Background *b = [[Background alloc]init];
        
        if (bi.isSkyBox == 1) {
            b.sprite  = [CCSprite spriteWithFile:bi.texture_name];
        } else {
            
            CCSpriteFrame  *cframe = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:bi.texture_name];
            
            
            
            if (cframe != nil) {
                
                b.sprite = [CCSprite spriteWithSpriteFrame:cframe];
                
            } else {
                b.sprite = nil;
            }
        }
        
        
        if (b.sprite != nil) {
            [m_rootNode addChild : b.sprite z: bi.ZOrder];
            
            if ( bi.isSkyBox != 1) {
                
                [b.sprite setPosition : ccp(bi.x + 1536, -(bi.y) + OriginY)];
                
                [b.sprite setScaleX :bi.scale_x*g_fx1 ];
                [b.sprite setScaleY :bi.scale_y*g_fy1 ];
                
                
            } else {
                [b.sprite setPosition:ccp(bi.x + 1536, -(bi.y) +OriginY)];
                
                
                
                [b.sprite setScaleX : (WIN_SIZE_X/g_fx/1024)*g_fx1];
                [b.sprite setScaleY : (WIN_SIZE_Y/g_fy/1024)*g_fy1];
            }
            
            [m_backgrounds addObject:b];
            
            if (bi.isSkyBox == 1)
                m_skyBox = b;
        }
    }
    
    //-------------------------------------- create bonuses-------------------------------------------
    
    for (BonusItem *bi in m_CurLevel.m_BonusItems) {
        
        float xx =  bi.x + 1536;
        float yy = -bi.y + OriginY;
        
        BonusBox *b = [[BonusBox alloc ]initWithNode: m_rootNode zorder:bi.z_order ];
        [m_bonuses addObject:b];
        
        FreeInd *fi = [[FreeInd alloc]init];
        [m_freeInd addObject:fi];
        
        [b.bonus_live.sprite setPosition:ccp(xx,yy)];
        [b.bonus_shoot.sprite setPosition:ccp(xx,yy)];
        
        
         [b.bonus_live.sprite setScale :0.5f*g_fx1];
         [b.bonus_shoot.sprite setScale :0.4f*g_fx1];
        
     }
    
    
    //------------------------------ create hunters ------------------------------------------
    for (HunterItem *hi in m_CurLevel.m_HunterItems) {
        Hunter *h = [[Hunter alloc] init];
    
        h.hi = hi;
        
        int rx = random() % (int)h.hi.width;
        
        
        h.sprite =[CCSprite spriteWithTexture:[m_hunterSheet1 texture] rect:CGRectMake(0,0,253.8f/2,233.0f/2)];
        
        
        h.numLives = [CCSprite spriteWithSpriteFrame: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"0.png"]];
        
        [h.numLives setScale :0.6f*g_fx1];
        [h.sprite addChild :h.numLives z:h.hi.z_order];
        
        [h.numLives setPosition : ccp(90.0f, HUNTER_HEIGHT)];
        
        [h.numLives setOpacity:0] ;
        
        h.spriteApple = [CCSprite spriteWithSpriteFrame: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"apple1.png"]];
        
        
        [h.spriteApple setPosition : ccp(50, HUNTER_HEIGHT)];
        [h.sprite addChild :h.spriteApple z: h.hi.z_order];
        [h.spriteApple setOpacity :0];
        
        
        [m_rootNode addChild :h.sprite z: h.hi.z_order];
        
        [h.sprite setPosition: ccp((h.hi.x + OriginX * SkyScaleX + rx)*g_fx, (-(h.hi.y)
                             + OriginY + HUNTER_HEIGHT * h.hi.scale / 2)*g_fy)];
        [h.sprite setScale :h.hi.scale*g_fx1];
        
        CCSpriteFrame *cframe =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"pula.png"];

        
        for (int p = 0; p < m_CurLevel.m_HunterPulaCnt; p++) {
            
            Pula *temp = [[Pula alloc]init];
            temp.pulaSprite = [CCSprite spriteWithSpriteFrame:cframe];
            [m_rootNode addChild :temp.pulaSprite z: 8];
            temp.pula_action = [CCMoveTo actionWithDuration:100 position:ccp(0,0)];
            [h.m_pules addObject:temp];
        }
        
        
        
        hunterAction = [CCAnimate actionWithAnimation:m_hunterAnimation1];
        
        h.repeat = [CCRepeatForever actionWithAction:hunterAction];
        
        [h.sprite runAction:h.repeat];
        
        h.move_action =[CCMoveTo actionWithDuration: h.hi.width / HUNTER_SPEED position:CGPointMake(h.hi.x + OriginX * SkyScaleX + h.hi.width, -(h.hi.y) + OriginY + HUNTER_HEIGHT * h.hi.scale / 2)];
        
        
        
        
        if ( random() % 2  == 0) {
            
            [h.move_action setTag:1];
            [h.sprite setFlipX:false];
            
            if ((h.hi.width - rx) != 0)
                 h.move_action =[CCMoveTo actionWithDuration: (h.hi.width - rx) / HUNTER_SPEED position:CGPointMake(h.hi.x + OriginX * SkyScaleX + h.hi.width, -(h.hi.y) + OriginY + HUNTER_HEIGHT * h.hi.scale / 2)];
            
                
                
        } else {
            
            [h.sprite setFlipX:true];
            [h.move_action setTag:0];
            if (rx != 0){
                h.move_action =[CCMoveTo actionWithDuration: rx / HUNTER_SPEED position:CGPointMake(h.hi.x + OriginX * SkyScaleX, -(h.hi.y) + OriginY + HUNTER_HEIGHT * h.hi.scale / 2)];
        
            }else{
                h.move_action =[CCMoveTo actionWithDuration: h.hi.width / HUNTER_SPEED position:CGPointMake(h.hi.x + OriginX * SkyScaleX, -(h.hi.y) + OriginY + HUNTER_HEIGHT * h.hi.scale / 2)];
                
                
            }
        }
        
        [h.sprite runAction :h.move_action];
        
        h.strelba_action = [CCAnimate actionWithAnimation:m_hunterPulaAnimation1];
        
        h.state = 0; // walking state
        //--------------------------------------------------------------
        h.timetostay = [[NSDate date] timeIntervalSince1970]*1000 + MIN_INTERVAL_STAY + random()%(MAX_DELAY_STAY);
        
        h.timetopula = [[NSDate date] timeIntervalSince1970]*1000  + 8000  + random()%10000;
        
  
        [h SetLives:m_CurLevel.m_HunterLives];
       
        [h.numLives runAction: [CCSequence actions: [CCFadeIn actionWithDuration:0.7f],[CCFadeOut actionWithDuration:1.5f], nil]];
        [h.spriteApple runAction: [CCSequence actions: [CCFadeIn actionWithDuration:0.7f],[CCFadeOut actionWithDuration:1.5f], nil]];
        
        [m_hunters addObject:h];
    }
    
    // =================================================== create flowers ============================================
    for (FlowerItem *fi in m_CurLevel.m_FlowersItems) {
        
        Flower *f = [[Flower alloc]  init];
        
        CCSpriteFrame *cframe = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"ss_001.png"];
        
        f.sprite =[CCSprite spriteWithSpriteFrame:cframe];

      
        [m_rootNode addChild :f.sprite z:fi.z_order];
        
        float xx = fi.x + fi.width / 2 + 1536;
        float yy = -(fi.y - fi.height * 2) + OriginY;
        
        [f.sprite setPosition :ccp(xx, yy)];
        [f.sprite setScale:1.1f*g_fx1];
        f.action = [CCAnimate actionWithAnimation:m_flowerAnim];
        [m_flowers addObject:f];
        
    }
    
    // =================================================  create bombs ================================================
    for (int i = 0; i < m_CurLevel.m_MaxBombs; i++) {
        Bomb *b = [[Bomb alloc] init];
        [m_bombs addObject:b];
    }
    
    m_duckKill1Action = [CCAnimate actionWithAnimation: m_duckKill2];
    m_duckKill2Action = [CCAnimate actionWithAnimation: m_duckKill2];
    
    // ==================================== Set bomba and bonus start times ==============================================
         
    m_BombaTime = [[NSDate date] timeIntervalSince1970]*1000  + m_CurLevel.m_MinDelayBomb + random()%(m_CurLevel.m_MaxAddDelayBomb);
    m_BonusTime =[[NSDate date] timeIntervalSince1970]*1000  + m_CurLevel.m_MinDelayBomb + random()%(m_CurLevel.m_MaxAddDelayBomb);
    m_LiveTime = [[NSDate date] timeIntervalSince1970]*1000  + m_CurLevel.m_MinDelayLives + random()%(m_CurLevel.m_MaxAddDelayLives);
    
    startgametime = [[NSDate date] timeIntervalSince1970]*1000;

}
-(void) Init_Animation
{
    NSMutableArray *frames = [[NSMutableArray alloc]init];
    m_duckStrelAnimationUp = [[CCAnimation alloc]init];
    for(int i = 1; i <19  ; i++) {
        [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"duck_strel%d.png",i]]];
    }
    
    m_duckStrelAnimationUp  = [CCAnimation animationWithSpriteFrames:frames delay:0.05f];
    m_duckStrelAnimationUpFast  = [CCAnimation animationWithSpriteFrames:frames delay:0.025f];
    
    [frames removeAllObjects];
    m_duckStrelAnimationVbok = [[CCAnimation alloc]init];
    for(int i = 1; i <19  ; i++) {
        [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"strelaet_pramo%d.png",i]]];
    }
    m_duckStrelAnimationVbok  = [CCAnimation animationWithSpriteFrames:frames delay:0.05f];
    m_duckStrelAnimationVbokFast  = [CCAnimation animationWithSpriteFrames:frames delay:0.025f];
    
    
    m_duckStrelActionUp = [CCAnimate actionWithAnimation: m_duckStrelAnimationUp];
    m_duckStrelActionVbok =[CCAnimate actionWithAnimation:m_duckStrelAnimationVbok];
    m_duckStrelActionUpFast =[CCAnimate actionWithAnimation:m_duckStrelAnimationUpFast];
    m_duckStrelActionVbokFast = [CCAnimate actionWithAnimation:m_duckStrelAnimationVbokFast];
    
    [frames removeAllObjects];
    for(int i = 1; i <4  ; i++) {
        [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"duck_dyn1_%d.png",i]]];
    }
    m_duckDyn1 = [CCAnimation animationWithSpriteFrames:frames delay:0.25f];
    
    [frames removeAllObjects];
    for(int i = 1; i <4  ; i++) {
        [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"duck_dyn2_%d.png",i]]];
    }
    
    m_duckDyn2 = [CCAnimation animationWithSpriteFrames:frames delay:0.25f];
    [frames removeAllObjects];
    for(int i = 0; i <4  ; i++) {
        [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"duck_kill1_%d.png",i % 2+1]]];
    }
    m_duckKill1 = [CCAnimation animationWithSpriteFrames:frames delay:0.15f];
    
    [frames removeAllObjects];
    for(int i = 0; i <4  ; i++) {
        [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"duck_kill2_%d.png",i % 2+1]]];
    }
    m_duckKill2 = [CCAnimation animationWithSpriteFrames:frames delay:0.15f];
    
    m_duckKill1Action = [CCAnimate actionWithAnimation: m_duckKill1];
    m_duckKill2Action = [CCAnimate actionWithAnimation: m_duckKill2];

    
}
-(void) update :(ccTime) dt
{
//    static Boolean flag =false;
//    if(flag == false){
//        flag =true;
//        [self Init_Animation];
//    }
    
    [self Init_Animation];
    
    [m_duckSprite setPosition: m_duckPos];
   
    float x = 1024 / 2 - m_duckPos.x;
    float add = (m_visibleWidth - 1024) / 2;
    
    if (x > -add)
          x = -add;
    if (x < (-(1024 * 3 - (1024 + add))))
          x = -(1024 * 3 - (1024 + add));
    
    [m_rootNode setPosition: ccp(x, 0)];
    [m_cancelSprite setPosition :ccp(-x + 35 - add, 730)];
    [m_pauseSprite  setPosition :ccp(-x + 550 - add, 730)];
             
    if ([m_shootSprite visible])
    {
        [m_shootSprite setPosition : ccp(-x + 100 - add, 130)];
        [m_shootSprite2 setPosition: ccp(-x + 924 - add, 130)];
                 
        [m_shootLabel  setPosition  :ccp(-x + 100 - add, 40)];
        [m_shootLabel2 setPosition :ccp(-x  + 924 - add, 40)];
    }
             
    if (m_skyBox != nil)
    {
        [m_skyBox.sprite setPosition :CGPointMake(-x + 1024 / 2, 768 / 2)];
    }
    
    [m_duckLivesSprite setPosition:CGPointMake(-x + 940 + add, 730)];
    [m_duckLiveHead setPosition: CGPointMake(-x + 950 - 70 + add, 730)];
             
    [m_hunterHead setPosition: CGPointMake(-x + 980 - 260 + add, 735)];
    [m_numHuntersSprite setPosition: CGPointMake(-x + 980 - 230 + add, 730)];
             
    [m_bonusIcon setPosition: CGPointMake(-x + 980 - 370 + add, 730)];
             
    [m_Birds Shedule];
    [m_Orel Shedule];
    
    CGPoint pt_orel = [m_Orel GetPos];
    

    if (([m_Orel GetDir] == 1 &&  pt_orel.x < m_duckPos.x && (m_duckPos.x - pt_orel.x) < 512)
           || ( [m_Orel GetDir] == -1 && pt_orel.x > m_duckPos.x && (pt_orel.x - m_duckPos.x) < 512))
    {
                     
        if ([[NSDate date] timeIntervalSince1970]*1000 >= m_OrelWaitAttack) {
                   [m_Orel Attack :m_duckPos];
        }
        
    } else {
        m_OrelWaitAttack =[[NSDate date] timeIntervalSince1970]*1000 + 500 + random()%3000;
        
    }
             
    CGRect rcDuck = [m_duckSprite boundingBox];
    CGRect rcOrel = [m_Orel GetRect];
  
    
    if ( m_Orel.b_attack  && CGRectIntersectsRect(rcDuck, rcOrel) )
    {
        
        [m_Orel Fire];
        
        if (m_duckStrelAction != nil && _isduckActionEnd) {
            
                  [m_duckSprite runAction :m_duckKill2Action];
                   m_duckStrelAction = m_duckKill2Action;
        } else {

             [m_duckSprite runAction :m_duckKill1Action];
              m_duckStrelAction = m_duckKill1Action;
         }
        [self KillOrLiveDuck :-1];
         m_Orel.b_attack = false;
     }
             
     if (m_bEnd) {
           return;
     }
             
    
    
    // all hunters killed?
      Boolean bAllHuntersKilled = (m_NumberHunters == 0);
    
      [m_numHuntersSprite SetNum :m_NumberHunters];
             
      // end game, if all hunters killed
     if (bAllHuntersKilled) {
             m_bEnd = true;
                 
    //             MySettings.getInstance().openLevels = MySettings.getInstance().currentLevel + 2;
            
           if ( openLevels > 10 )
                 openLevels = 10;
  //-------------------------------------------------------------------------------------
//                 CCScene scene = CCScene.node();
//                 YouWinLayer winLayer = new YouWinLayer();
//                 winLayer.SetSeconds((SystemClock.uptimeMillis() - startgametime) / 1000);
//                 scene.addChild(winLayer);
//                 CCDirector.sharedDirector().replaceScene(
//                                                          CCShrinkGrowTransition.transition(1.0f, scene));
         
         
               return;
           }
             
             // end game, if lives 0
             if (m_duckLives <= 0) {
                 m_bEnd = true;
                 
                 [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
                 [[CCDirector sharedDirector] replaceScene:[CCTransitionShrinkGrow transitionWithDuration:0.5 scene:SelectLayer.scene
                                                            ]];

                 
//                 CCScene scene = CCScene.node();
//                 scene.addChild(new SelectLayer());
//                 CCDirector.sharedDirector().replaceScene(
//                                                          CCShrinkGrowTransition.transition(1.0f, scene));
//                 return;
             }
             
    [self updateFlowers:dt];
    [self updateHunters:dt offx:x];
    
    
     // êîíòðîëü âûõîäà ÿáëîêà çà ãðàíèöû ýêðàíà
    for (Apple_Object *apple in m_apples)
    {
        
      if (apple.m_appleActionMove!= nil)
      {
          CGPoint pt = apple.m_appleSprite.position;
         if ((pt.x + x) < -300) {
                        [apple.m_appleSprite stopAllActions];
                        [apple.m_appleSprite setVisible :false];
                        [apple.m_appleActionMove setTag:0];
         } else if ((pt.x + x) > (1024+ 350)) {
                        [apple.m_appleSprite stopAllActions];
                        [apple.m_appleSprite setVisible :false];
                        [apple.m_appleActionMove setTag:0];

             
         } else if ((pt.y) > (768 + 100)) {
             [apple.m_appleSprite stopAllActions];
             [apple.m_appleSprite setVisible :false];
             [apple.m_appleActionMove setTag:0];
             

         } else if ((pt.y) < (-100)) {
             [apple.m_appleSprite stopAllActions];
             [apple.m_appleSprite setVisible :false];
             [apple.m_appleActionMove setTag:0];
             
         }
       }
     }
             
             // Dispatch apples moves
    [self updateApples:dt];
    [self updateBombs :dt];
    
     // dispatch bonuses
    [self updateBonuses:dt];
    
    


             
    if (m_cmd == 0) {
             m_cmd = 1;
     } else if (m_cmd == 1) {
          m_cmd = -1;
        // [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        // [[CCDirector sharedDirector] replaceScene:[CCTransitionShrinkGrow transitionWithDuration:0.5 scene:SelectLayer.scene]];
         
//             CCScene scene = CCScene.node();
//                 scene.addChild(new SelectLayer());
//                 CCDirector.sharedDirector().replaceScene(
//                                                          CCShrinkGrowTransition.transition(1.0f, scene));
     }
             
             // if animation kill hunter end, then hide sprite
     if (m_huntkillAction != nil)
             if ([m_huntkillAction isDone]) {
                 [m_huntkillSprite setVisible:false];
                 
                 [m_huntkillSprite setTextureRect:[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"hunt_kill1.png"] rect] rotated:[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"hunt_kill1.png"] rotated] untrimmedSize:[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"hunt_kill1.png"] rect].size];
                 
                 
    }
}
         
-(void) updateFlowers :(float)dt
{
   for (Flower *f in m_flowers)
   {
       CGPoint pt = [f.sprite position];
       float dist = ccpDistance(pt, m_duckPos);
       if (dist < 200) {
             if (f.action.target == nil || [f.action isDone]) {
                 [f.sprite runAction:f.action];
                 [f.action setTag :1];
              } else {
                  if ([f.action elapsed] > 0.5f
                             && [f.action elapsed] < 0.65f
                             && abs(m_duckPos.x - pt.x + 40) < 70
                             && abs(m_duckPos.y - pt.y) < 160) {
                             // f.sprite.stopAction(f.action);
                             if (m_duckStrelAction != nil
                                 && _isduckActionEnd ) {
                                 [m_duckSprite runAction :m_duckKill2Action];
                                 m_duckStrelAction = m_duckKill2Action;
                             } else {
                                 
                                 [m_duckSprite runAction :m_duckKill1Action];
                                 m_duckStrelAction = m_duckKill1Action;
                             }
                             if ([f.action tag] == 1) {
                                 [self KillOrLiveDuck :-1];
                                 [f.action setTag:0];
                             }
                   }
              }
       }
   }
}
-(void) updateApples :(float)dt
{
   if (m_iAttack != 0) {
          if (([[NSDate date] timeIntervalSince1970]*1000  - m_AttackTime) > 10000) {
              m_iAttack = 0;
              [m_bonusIcon setVisible:false];
           }
   }
             
   for (Apple_Object *apple in m_apples)
   {

        if ((apple.m_appleActionAnim != nil)
            && ([apple.m_appleActionAnim isDone]) && ([apple.m_appleActionAnim tag]==1)){
            
               [apple.m_appleSprite stopAllActions];
               [apple.m_appleSprite setVisible:false];
                     
            [apple.m_appleSprite setTextureRect: [[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"apple1.png"] rect] rotated:[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"apple1.png"] rotated] untrimmedSize:[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"apple1.png"] rect].size];
            
                [apple.m_appleActionAnim setTag:0];
                [apple.m_appleActionMove setTag:0];
            
        } else if (
                   ([apple.m_appleSprite visible]  && (apple.m_appleActionAnim == nil))
                   
                   || ([apple.m_appleSprite visible] && (apple.m_appleActionAnim != nil)
                   && ([apple.m_appleActionAnim tag]==0))) {
                                
                CGPoint pt =[apple.m_appleSprite position];
                                    
               // check for bombs intersection
                Boolean bBombaIntersect = false;
                for (Bomb *b in m_bombs)
                {
                   if (b.m_BombaState == 1) {
                       
                         BombType *bt;
                         if (b.type == 1)
                            bt = b.bombtype1;
                         else
                            bt = b.bombtype2;
                       
                         CGRect rc = CGRectMake(
                             [bt.sprite position].x - [bt.sprite boundingBox].size.width/2,
                             [bt.sprite position].y - [bt.sprite boundingBox].size.height/2,
                             [bt.sprite boundingBox].size.width,
                             [bt.sprite boundingBox].size.height);
                       
                         if (CGRectContainsPoint(rc, pt)) {
                             [apple.m_appleSprite stopAction:apple.m_appleActionMove];
                             [apple.m_appleActionAnim setTag:1];
                             [apple.m_appleSprite runAction: apple.m_appleActionAnim];
                             [bt.sprite runAction :bt.action];
                             b.m_BombaState = 3;
                             bBombaIntersect = true;
                          }
                    }
                 }
                                    
                // check for bonus intersection
                Boolean bBonusIntersect = false;
                       
        if (!bBombaIntersect) {
           for (BonusBox *bb  in m_bonuses) {
              if (bb.m_BonusState == 1) {
                 if (bb.m_type == 1) {
                      CGRect rc = CGRectMake( [bb.bonus_live.sprite position].x - [bb.bonus_live.sprite boundingBox].size.width/2,
                                             [bb.bonus_live.sprite position].y - [bb.bonus_live.sprite boundingBox].size.height/2,
                                             [bb.bonus_live.sprite boundingBox].size.width,
                                             [bb.bonus_live.sprite boundingBox].size.height
                                             );
                      
                      
                      if (CGRectContainsPoint(rc, pt)) {
                          [apple.m_appleSprite stopAction:apple.m_appleActionMove];
                          [apple.m_appleActionAnim setTag:1];
                          [apple.m_appleSprite runAction: apple.m_appleActionAnim];
                          [bb.bonus_live.sprite runAction :bb.bonus_live.action];
                          bb.m_BonusState = 2;
                          bBombaIntersect = true;
                          
                      
                          [m_duckheadSprite  setPosition:ccp([bb.bonus_live.sprite position].x,
                                                             [bb.bonus_live.sprite position].y)];
                          
                          [m_duckheadSprite setVisible: true];
                          [m_duckheadSprite setOpacity:  255];
                          
                          
                          
                          
                          CCFiniteTimeAction *action1 = [CCJumpTo actionWithDuration:2 position:CGPointMake([bb.bonus_live.sprite position].x,[bb.bonus_live.sprite position].y +30) height:3 jumps:6];
                          
                          CCFiniteTimeAction *action2 = [CCFadeOut actionWithDuration:1];
                          m_duckheadAction = [CCSequence actions:action1,action2,nil];
                          
                          [m_duckheadSprite runAction:m_duckheadAction];
                     }
                 } else if (bb.m_type == 2) {
                     CGRect rc = CGRectMake([bb.bonus_shoot.sprite position].x - [bb.bonus_shoot.sprite boundingBox].size.width/2,
                                            [bb.bonus_shoot.sprite position].y - [bb.bonus_shoot.sprite boundingBox].size.height/2,
                                            [bb.bonus_shoot.sprite boundingBox].size.width,
                                            [bb.bonus_shoot.sprite boundingBox].size.height);
                     
                      if (CGRectContainsPoint(rc, pt)) {
                     
                                      // make shoot
                             m_iAttack = random()%3 + 1;
                             m_AttackTime = [[NSDate date] timeIntervalSince1970]*1000;
                             [m_bonusIcon setVisible :true];
                          
                             [apple.m_appleSprite stopAction:apple.m_appleActionMove];
                             [apple.m_appleActionAnim setTag:1];
                             [apple.m_appleSprite runAction: apple.m_appleActionAnim];
                             [bb.bonus_shoot.sprite runAction :bb.bonus_shoot.action];
                             bb.m_BonusState = 2;
                             bBonusIntersect = true;
                          
                          [m_bonusheadSprite setPosition: CGPointMake([bb.bonus_shoot.sprite position].x, [bb.bonus_shoot.sprite position].y)];
                          
                          [m_bonusheadSprite setVisible :true];
                          [m_bonusheadSprite setOpacity :255];
                          
                          
                          
                          CCFiniteTimeAction *action1 = [CCJumpTo actionWithDuration:2 position:CGPointMake([bb.bonus_shoot.sprite position].x,[bb.bonus_shoot.sprite position].y +30) height:3 jumps:6];
                          
                          CCFiniteTimeAction *action2 = [CCFadeOut actionWithDuration:1];
                          m_bonusheadAction = [CCSequence actions:action1,action2,nil];
                          
                          [m_bonusheadSprite runAction:m_bonusheadAction];
                      }
                 }
             }
          }
        }
                       
        if ((!bBombaIntersect) && (!bBonusIntersect))
            
            for (Hunter *h in m_hunters) {
                 if (h.state == -1)
                    continue;
                    CGRect rc = CGRectMake( [h.sprite position].x- 30*h.hi.scale,
                                           (768.0f - [h.sprite position].y)-40*h.hi.scale, 60*h.hi.scale,80*h.hi.scale);
                
                    if (CGRectContainsPoint(rc, pt)) {
                        
                         [apple.m_appleSprite stopAction:apple.m_appleActionMove];
                         [apple.m_appleActionAnim setTag:1];
                         [apple.m_appleSprite runAction: apple.m_appleActionAnim];
                         [h.sprite stopAction: h.move_action];
                         [h.sprite stopAction:h.repeat];
                        
                         int xp = random() % 4 ;
                        
                         [h.sprite setTextureRect:CGRectMake(xp * 176.0f,2 * 161.0f, 176.0f, 161.0f) rotated:false untrimmedSize:CGRectMake(xp * 176.0f,2 * 161.0f, 176.0f, 161.0f).size];
                        
                         h.timetomove = [[NSDate date] timeIntervalSince1970]*1000+ 150;
                        
                        if (h.state == 3) {
                            [h.sprite stopAction :h.strelba_action];
                            h.timetopula = [[NSDate date] timeIntervalSince1970]*1000 + 8000 + random()%10000;
                         }
                         h.state = 1;
                        // h.lives--;
                         if (m_iAttack == 3) {
                             [h SetLives:0];
                         } else {
                             [h SetLives: h.lives - 1];
                         }
                        
                         // killed hunter
                        if (h.lives == 0) {
                            
                             [h.sprite setTextureRect: CGRectMake(0 * 176.0f,                                                                                        3 * 161.0f, 176.0f, 161.0f) rotated:false untrimmedSize:CGRectMake(0 * 176.0f,                                                                                        3 * 161.0f, 176.0f, 161.0f).size];
                            
                              h.state = -1; // killed state
                            
                              h.killedtime = [[NSDate date] timeIntervalSince1970]*1000   + 1000 + random()%6000;
                              h.timetomove =[[NSDate date] timeIntervalSince1970]*1000+ 1000;
                                                    
                              m_NumberHunters--;
                          
                            [h.sprite runAction: [CCFadeOut actionWithDuration:0.7f]];
                                                    
                            [m_huntkillSprite setPosition: CGPointMake( [h.sprite position].x,[h.sprite position].y)];
                            if (m_huntkillAction == nil)
                                m_huntkillAction = [CCAnimate actionWithAnimation:m_huntkillAnimation];
                            
                            [m_huntkillSprite runAction :m_huntkillAction];
                            [m_huntkillSprite setVisible:true];
                        } else {
                            
                            [h.numLives runAction:[CCSequence actions:                                                                                     [CCFadeIn actionWithDuration:0.7f], [CCFadeOut actionWithDuration:1.5f],nil]];
                            
                            [h.spriteApple runAction:[CCSequence actions:                                                                                     [CCFadeIn actionWithDuration:0.7f], [CCFadeOut actionWithDuration:1.5f],nil]];
                            
                         }
                      }
                    }
                 }
             }
    }
         
-(void) updateBombs :(float) dt
{
   // static
    int first_free = -1;
    
    [self Init_Animation];
    
    
    for (int i = 0; i < m_bombs.count; i++) {
        if ([m_bombs[i] type] == 0) {
                first_free = i;
                 break;
         }
    }
    
    long long curTicks =[[NSDate date] timeIntervalSince1970]*1000;
    
    if (first_free != -1 && curTicks > m_BombaTime) {
        
         Bomb *freeBomb = m_bombs[first_free];
         if (random()%2 == 0) {
             freeBomb.type = 1;
             [freeBomb.bombtype1.sprite setTextureRect:[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"bomb1.png"] rect]];
             
              [freeBomb.bombtype1.sprite setPosition : CGPointMake(random()%3000+50,random() %(192-30) + 60)];
              [freeBomb.bombtype1.sprite setVisible :true];
          } else {
              freeBomb.type = 2;
              [freeBomb.bombtype2.sprite setTextureRect:[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"tnt1.png"] rect]];
              
              [freeBomb.bombtype1.sprite setPosition : CGPointMake(random()%3000+50,random() %(192-30) + 60)];
              [freeBomb.bombtype1.sprite setVisible :true];
              
          }
        
          freeBomb.m_BombaState = 1;
          m_BombaTime = [[NSDate date] timeIntervalSince1970]*1000+ m_CurLevel.m_MinDelayBomb + random()%(m_CurLevel.m_MaxAddDelayBomb);
   }
   CGRect rcDuck = [m_duckSprite boundingBox];
   for (Bomb *b in m_bombs) {
       // Bomba already exists, but animate not
      if (b.m_BombaState == 1) {
          CGRect rcBomb;
          if (b.type == 1)
              rcBomb = [b.bombtype1.sprite boundingBox];
          else
              rcBomb = [b.bombtype2.sprite boundingBox];
          
          if(CGRectIntersectsRect(rcDuck, rcBomb)){
                if (m_duckStrelAction != nil && _isduckActionEnd) {
                    
                    m_duckStrelAction = [CCAnimate actionWithAnimation:m_duckDyn2];
                    
                    CCCallFuncN* actionForTargetMoveDidFinish = [CCCallFuncN actionWithTarget:self selector:@selector(targetMoveFinished)];
                    _isduckActionEnd =false;
                    [m_duckSprite runAction:[CCSequence actions:m_duckStrelAction,actionForTargetMoveDidFinish,nil]];

           
                } else {
                    m_duckStrelAction = [CCAnimate actionWithAnimation:m_duckDyn1];
                    
                    CCCallFuncN* actionForTargetMoveDidFinish = [CCCallFuncN actionWithTarget:self selector:@selector(targetMoveFinished)];
                    _isduckActionEnd =false;
                    [m_duckSprite runAction:[CCSequence actions:m_duckStrelAction,actionForTargetMoveDidFinish,nil]];
                    
                }
                         
//----------------------bomb action --------------------------------------
                         
                if (b.type == 1)
                    [b.bombtype1.sprite runAction :b.bombtype1.action];
                else
                    [b.bombtype2.sprite runAction :b.bombtype2.action];
              
                b.m_BombaState = 2;
          }
      }
      // Bomba already exists and animated finish, with kill
      else if (b.m_BombaState == 2) {
           BombType *bt;
           if (b.type == 1)
                  bt = b.bombtype1;
           else
                  bt = b.bombtype2;
          
           if ([bt.action isDone]) {
               [bt.action stop];
               [bt.sprite setVisible :false];
               [self KillOrLiveDuck:-1];
                b.m_BombaState = 0;
                b.type = 0;
               if (first_free == -1) {
                    m_BombaTime =[[NSDate date] timeIntervalSince1970]*1000 + m_CurLevel.m_MinDelayBomb + random()% m_CurLevel.m_MaxAddDelayBomb;
                }
           }
      }
      // Bomba already exists and animated finish, without kill
      else if (b.m_BombaState == 3) {
           BombType *bt;
           if (b.type == 1)
               bt = b.bombtype1;
           else
               bt = b.bombtype2;
           if ([bt.action isDone]) {
               [bt.action stop];
               [bt.sprite setVisible:false];
                b.m_BombaState = 0;
                b.type = 0;
                if (first_free == -1) {
                      m_BombaTime = [[NSDate date] timeIntervalSince1970]*1000 + m_CurLevel.m_MinDelayBomb + random()% m_CurLevel.m_MaxAddDelayBomb;
                }
           }
       }
   }
}
         
-(void) updateBonuses :(float)dt
{
   int first_free = -1;
   int i = 0;
   int cnt_bonuses = 0;
   int k = 0;
   for (BonusBox *bb in m_bonuses) {
      if (bb.m_type == 2) {
            cnt_bonuses++;
       } else if (bb.m_type == 0) {
           FreeInd *temp = m_freeInd[k];
           temp.m_ind =i;
            k++;
       }
       i++;
   }
             
   if (k > 0) {
       FreeInd *temp = m_freeInd[random()%k];
       first_free = temp.m_ind;
   }
             
    long long curTicks =[[NSDate date] timeIntervalSince1970]*1000;
   if (cnt_bonuses >= m_CurLevel.m_MaxBonus) {
       m_BonusTime = m_CurLevel.m_MinDelayBonus + random()%(m_CurLevel.m_MaxAddDelayBonus);
       
   } else if (first_free != -1 && curTicks > m_BonusTime) {
       BonusBox *temp =m_bonuses[first_free];
       temp.m_type =2;
       
      [temp.bonus_shoot.sprite setDisplayFrame:  [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"bonus1.png"]];
        
        
       [temp.bonus_shoot.sprite setVisible:true];
       temp.m_BonusState = 1;
       
       m_BonusTime = curTicks + m_CurLevel.m_MinDelayBonus + random()%(m_CurLevel.m_MaxAddDelayBonus);
   }
   i = 0;
   cnt_bonuses = 0;
   first_free = -1;
   k = 0;
   for (BonusBox *bb in m_bonuses) {
       if (bb.m_type == 1) {
              cnt_bonuses++;
        } else if (bb.m_type == 0) {
            FreeInd *temp =m_freeInd[k];
            temp.m_ind = i;
            k++;
        }
        i++;
   }
    
   if (k > 0) {
        FreeInd *temp =m_freeInd[random()%k];
         first_free = temp.m_ind;
   }
             
   if (cnt_bonuses >= m_CurLevel.m_MaxLives) {
         m_LiveTime = [[NSDate date] timeIntervalSince1970]*1000 + m_CurLevel.m_MinDelayLives + random()%(m_CurLevel.m_MaxAddDelayLives);
    } else if (first_free != -1 && curTicks > m_LiveTime) {
        BonusBox *temp =m_bonuses[first_free];
     
        temp.m_type = 1;
        [temp.bonus_live.sprite  setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"box1.png"]];
        
        [temp.bonus_live.sprite setVisible:true];
         temp.m_BonusState = 1;
         m_LiveTime = curTicks + m_CurLevel.m_MinDelayLives + random()%(m_CurLevel.m_MaxAddDelayLives);
    }
             
    for (BonusBox *bb in m_bonuses) {
        // Bonus already exists and animated finish
        if (bb.m_BonusState == 2) {
             if (bb.m_type == 1) {
                 if ([bb.bonus_live.action isDone]) {
                     [bb.bonus_live.action stop];
                     [bb.bonus_live.sprite setVisible:true];
                     [self KillOrLiveDuck:1];
                     
                      bb.m_BonusState = 0;
                      bb.m_type = 0;
                     if (curTicks > m_BonusTime){
                        m_BonusTime = [[NSDate date] timeIntervalSince1970]*1000+ m_CurLevel.m_MinDelayBonus + random()%(m_CurLevel.m_MaxAddDelayBonus);
                         
                     }
                 }
              } else if (bb.m_type == 2) {
                      if ([bb.bonus_shoot.action isDone]) {
                          [bb.bonus_shoot.action stop];
                          [bb.bonus_shoot.sprite setVisible:false];
                          bb.m_BonusState = 0;
                          bb.m_type = 0;
                         
                          if (curTicks > m_LiveTime)
                          {
                            m_LiveTime = [[NSDate date] timeIntervalSince1970]*1000 + m_CurLevel.m_MinDelayLives+ random()%(m_CurLevel.m_MaxAddDelayLives);
                          }
                          
                     }
            }
       }
   }
}
         
-(void) updateHunters :(float)dt offx:(float) offx_s
{

    int num_live_hunters = 0;
    for (Hunter *h in m_hunters) {
        if (h.state != -1)
              num_live_hunters++;
    }
    
    for (Hunter *h in m_hunters) {
        if (h.state == -1) // killed hunter
         {                                           //SystemClock.uptimeMillis()
           if (m_NumberHunters > num_live_hunters  && ([[NSDate date] timeIntervalSince1970]*1000  > h.killedtime)) {
                 int rx = random()% (int) h.hi.width;
                 [h.sprite setPosition: ccp(h.hi.x + OriginX * SkyScaleX + rx,
                                              -(h.hi.y) + OriginY + HUNTER_HEIGHT * h.hi.scale
                                              / 2)];
                         
                 
                h.state = 0; // walking state
                [h SetLives :m_CurLevel.m_HunterLives];// hi.lives;
                h.timetostay = [[NSDate date] timeIntervalSince1970]*1000+ MIN_INTERVAL_STAY + random()%MAX_DELAY_STAY;
                h.timetopula = [[NSDate date] timeIntervalSince1970]*1000 + 8000 + random()%10000;
                  
                  
               h.timetomove = 0;
               [h.sprite runAction:[CCFadeIn actionWithDuration:0.7f]];
               [h.numLives runAction:[CCFadeIn actionWithDuration:0.7f]];
               [h.spriteApple runAction:[CCFadeIn actionWithDuration:0.7f]];
               [h.sprite runAction:h.repeat];
               
               [h.numLives runAction:[CCSequence actions:[CCFadeIn actionWithDuration:0.7f], [CCFadeOut actionWithDuration:1.5f],nil]];

               [h.spriteApple runAction:[CCSequence actions:[CCFadeIn actionWithDuration:0.7f], [CCFadeOut actionWithDuration:1.5f],nil]];
                  
                  
                  
               [h.move_action setDuration :(h.hi.width / HUNTER_SPEED)];
                         
                  if (random()%2 == 0) {
                      [h.move_action setTag:1];
                      [h.sprite setFlipX:false];
                      
                      if ((h.hi.width - rx) != 0){
                          [h.move_action initWithDuration:((h.hi.width - rx)/ HUNTER_SPEED) position:ccp(h.hi.x + OriginX * SkyScaleX + h.hi.width, -(h.hi.y)                                                                                                 + OriginY + HUNTER_HEIGHT * h.hi.scale / 2)];
                      }
                      
                      [h.move_action initWithDuration:(h.hi.width / HUNTER_SPEED) position:ccp(h.hi.x + OriginX * SkyScaleX + h.hi.width, -(h.hi.y)                                                                                                 + OriginY + HUNTER_HEIGHT * h.hi.scale / 2)];
                      
                     
                      
                  } else {
                      [h.sprite setFlipX:true];
                      [h.move_action setTag:0];
                      if (rx != 0){
                          [h.move_action initWithDuration:(rx / HUNTER_SPEED) position:ccp(h.hi.x + OriginX * SkyScaleX, -(h.hi.y) + OriginY                                                                                           + HUNTER_HEIGHT * h.hi.scale / 2)];
                      }
                      
                      [h.move_action initWithDuration:(h.hi.width / HUNTER_SPEED) position:ccp(h.hi.x + OriginX * SkyScaleX, -(h.hi.y) + OriginY                                                                                           + HUNTER_HEIGHT * h.hi.scale / 2)];
                      
                      
                      
                  }
                      
                  [h.sprite runAction:h.move_action];
            } else {
                 continue;
            }
         }
                 
         if (h.state == 0) {
            if ([h.move_action isDone]) {
                if ([h.move_action tag] == 1) {
                    [h.sprite setFlipX:true];
                    
                    [h.move_action initWithDuration:(h.hi.width / HUNTER_SPEED) position:ccp(h.hi.x + OriginX * SkyScaleX, -(h.hi.y) + OriginY                                                                                            + HUNTER_HEIGHT * h.hi.scale / 2)];
                    
                    [h.move_action setTag:0];
                    [h.sprite runAction :h.move_action];
                    
                }else {
                    [h.sprite setFlipX:false];
                    [h.move_action initWithDuration:(h.hi.width / HUNTER_SPEED) position:ccp(h.hi.x + OriginX * SkyScaleX + h.hi.width, -(h.hi.y)                                                                                            + OriginY + HUNTER_HEIGHT * h.hi.scale / 2)];
                    
                    [h.move_action setTag:1];
                    [h.sprite runAction:h.move_action];
                }
            }
                     
            long long curTicks = [[NSDate date] timeIntervalSince1970]*1000;
            if (curTicks > h.timetostay) {
                [h.sprite stopAction: h.move_action];
                [h.sprite stopAction:h.repeat];
                [h.sprite setTextureRect:CGRectMake(0 * 176.0f, 3 * 161.0f, 176.0f, 161.0f) rotated:false untrimmedSize:CGRectMake(0 * 176.0f, 3 * 161.0f, 176.0f, 161.0f).size];
                 
                 h.state = 2; // stay state
                 h.timetomove = [[NSDate date] timeIntervalSince1970]*1000 + 2000 + random()%8000;
              
                
            }
                     
            if (curTicks > h.timetopula) {
                [h.sprite stopAction:h.move_action];
                [h.sprite stopAction:h.repeat];
                [h.sprite setTextureRect:CGRectMake(0 * 176.0f, 3 * 161.0f, 176.0f, 161.0f) rotated:false untrimmedSize:CGRectMake(0 * 176.0f, 3 * 161.0f, 176.0f, 161.0f).size];
                h.state = 3;
                [h.sprite runAction:h.strelba_action];
             }
        } // stay state
        else if (h.state == 2) {
             
            long long curTicks =[[NSDate date] timeIntervalSince1970]*1000;
              if (curTicks > h.timetomove) {
                    if ([h.move_action tag] == 0)
                        [h.move_action setDuration:(([h.sprite position].x - (h.hi.x + OriginX
                                                                       * SkyScaleX))
                                          / HUNTER_SPEED)];
                  
                     else if ([h.move_action tag] == 1)
                         [h.move_action setDuration:((h.hi.x + OriginX * SkyScaleX
                                                        + h.hi.width - [h.sprite position].x)
                                                       / HUNTER_SPEED)];
                         
                      [h.sprite runAction:h.move_action];
                      [h.sprite runAction:h.repeat];
                      h.state = 0; // stay state
                      h.timetostay = [[NSDate date] timeIntervalSince1970]*1000 + MIN_INTERVAL_STAY + random() % MAX_DELAY_STAY;
               }
             
               if (curTicks > h.timetopula) {
                
                   [h.sprite stopAction: h.move_action];
                   [h.sprite stopAction: h.repeat];
                   [h.sprite setTextureRect:CGRectMake(0 * 176.0f, 3 * 161.0f, 176.0f, 161.0f) rotated:false untrimmedSize:CGRectMake(0 * 176.0f, 3 * 161.0f, 176.0f, 161.0f).size];
                   h.state = 3;
                   [h.sprite runAction:h.strelba_action];
                }
             
       } else if (h.state == 3) {
                // first pula
               if ([h.strelba_action isDone]) {
                   
                   Hunter *temp = h.m_pules[0];
                   
                   [temp.pulaSprite setPosition:[h.sprite position]];
                   CGPoint p =ccpSub(m_duckPos, [h.sprite position]);
                   ccpNormalize(p);
                   
           
                   CGPoint end_point = ccp(m_duckPos.x + p.x * 1000, m_duckPos.y + p.y * 1000);
                   
                   
                   float dist_puli = ccpDistance([h.sprite position], end_point);
                         // h.pula_action = CCMoveTo.action(dist_puli / PULA_SPEED,
                         // CGPoint.ccp(duck_pos.x+p.x*1000, duck_pos.y+p.y*1000));
                         
                   [temp.pulaSprite setFlipX: [h.sprite position].x >m_duckPos.x];
                   
                   [temp.pula_action  initWithDuration:dist_puli/ (float) m_CurLevel.m_PulaSpeed position:ccp(m_duckPos.x + p.x
                                                                                                              * 1000, m_duckPos.y + p.y * 1000)];
                  
                   
                   
                   CCCallFuncN* actionForTargetMoveDidFinish = [CCCallFuncN actionWithTarget:self selector:@selector(targetPulaActionFinished)];
                   _isPulaActionDone =false;
                   [temp.pulaSprite  runAction:[CCSequence actions:temp.pula_action,actionForTargetMoveDidFinish,nil]];
                   
                 //  [temp.pulaSprite runAction :temp.pula_action];
                   
                   [temp.pulaSprite setVisible:true];
                         
                   h.timetopula = [[NSDate date] timeIntervalSince1970]*1000  + 300;
                   if (m_CurLevel.m_HunterPulaCnt > 1) {
                           h.state = 4;
                   } else {
                     if ([h.move_action tag] == 0)
                         [h.move_action setDuration:(([h.sprite position].x - (h.hi.x + OriginX                                                                           * SkyScaleX))/ HUNTER_SPEED)];
                       
                      else if ([h.move_action tag] == 1)
                          [h.move_action setDuration:((h.hi.x + OriginX * SkyScaleX + h.hi.width - [h.sprite position].x                                                          ) / HUNTER_SPEED)];
                             
                       h.timetopula =[[NSDate date] timeIntervalSince1970]*1000  + 8000 + random()%10000;
                       
                       [h.sprite runAction: h.move_action];
                       [h.sprite runAction:  h.repeat];
                       h.state = 0;
                  }
               }
                     
    }// second pula
    else if (h.state == 4) {
        long long curTicks = [[NSDate date] timeIntervalSince1970]*1000 ;//SystemClock.uptimeMillis();
        
        if (curTicks > h.timetopula) {
            Hunter *temp =h.m_pules[1];
            [temp.pulaSprite setPosition :[h.sprite position]];
            
            CGPoint p = ccpSub(m_duckPos, [h.sprite position]);
            ccpNormalize(p);
            
            CGPoint end_point = ccp(m_duckPos.x + p.x * 1000, m_duckPos.y + p.y * 1000);
            
           float dist_puli =ccpDistance([h.sprite position], end_point);
                         // h.pula_action = CCMoveTo.action(dist_puli / PULA_SPEED,
                         // CGPoint.ccp(duck_pos.x+p.x*1000, duck_pos.y+p.y*1000));
                         
            [temp.pulaSprite setFlipX:([h.sprite position].x > m_duckPos.x)];
                         
            [temp.pula_action  initWithDuration:(dist_puli / (float) m_CurLevel.m_PulaSpeed) position:ccp(m_duckPos.x + p.x * 1000, m_duckPos.y + p.y * 1000)];
            
            [temp.pulaSprite runAction : temp.pula_action];
            
            [temp.pulaSprite setVisible:true];
                         
            if ([h.move_action tag] == 0)
                [h.move_action setDuration:(([h.sprite position].x - (h.hi.x + OriginX                                                                       * SkyScaleX))     / HUNTER_SPEED)];
            else if ([h.move_action tag] == 1)
                [h.move_action setDuration:((h.hi.x + OriginX * SkyScaleX + h.hi.width - [h.sprite position].x)                                                       / HUNTER_SPEED)];
            

             h.timetopula =  [[NSDate date] timeIntervalSince1970]*1000 +8000 + random()%10000;
            
             [h.sprite runAction:h.move_action];
             [h.sprite runAction:h.repeat];
                h.state = 0;
           }
    } else if (h.state == 1) {
       long long curTicks =[[NSDate date] timeIntervalSince1970]*1000 ;// SystemClock.uptimeMillis();
          if (curTicks > h.timetomove) {
               if ([h.move_action tag] == 0)
                   [h.move_action setDuration:(([h.sprite position].x - (h.hi.x +OriginX                                                                     * SkyScaleX))/ HUNTER_SPEED)];
              
               else if ([h.move_action tag] == 1)
                   [h.move_action setDuration:((h.hi.x + OriginX * SkyScaleX
                                                        + h.hi.width - [h.sprite position].x)
                                                       / HUNTER_SPEED)];
                         
              [h.sprite runAction:h.move_action];
              [h.sprite runAction:h.repeat];
              h.state = 0; // stay state
              h.timetostay = [[NSDate date] timeIntervalSince1970]*1000 + MIN_INTERVAL_STAY + random()%MAX_DELAY_STAY;
            }
          }
                 
                 // ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½
                 // ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
   for (int p = 0; p < m_CurLevel.m_HunterPulaCnt; p++) {
       Hunter *temp =h.m_pules[p];
       
      // if (![temp.pula_action isDone] && [temp.pulaSprite visible]) {
         if (!_isPulaActionDone && [temp.pulaSprite visible]) {
             CGPoint pt = [temp.pulaSprite position];
                         
           [temp.pulaSprite setScale:(768 - pt.y) * 0.002f];
           
           
                         
            CGRect rc = CGRectMake(m_duckPos.x - 35,(768.0f - m_duckPos.y) - 50, 70, 100);
           
           if (CGRectContainsPoint(rc, CGPointMake(pt.x, 768.0f - pt.y))) {
               
               
               [temp.pulaSprite  stopAction: temp.pula_action];
               
               [temp.pulaSprite setVisible :false];

                [self KillOrLiveDuck :-1];
                             
                if (m_duckStrelAction != nil && _isduckActionEnd) {
                    
                    [m_duckSprite runAction:m_duckKill2Action];
                    m_duckStrelAction = m_duckKill2Action;
                    
                } else {
                    [m_duckSprite runAction:m_duckKill1Action];
                    m_duckStrelAction = m_duckKill1Action;
                }
                             
            }
                         // Ð¿Ñ€Ð¸ Ð²Ñ‹Ñ…Ð¾Ð´Ðµ Ð¿ÑƒÐ»Ð¸ Ð·Ð° Ð³Ñ€Ð°Ð½Ð¸Ñ†Ñ‹
                         // Ñ�ÐºÑ€Ð°Ð½Ð° - ÑƒÐ±Ð¸Ñ€Ð°ÐµÐ¼ ÐµÐµ
        if ((pt.x + offx_s) < -300) {
                [temp.pulaSprite stopAction : temp.pula_action ];
            
            [temp.pulaSprite setVisible:false];
            
        } else if ((pt.x + offx_s) > (1024 + 350)) {
             [temp.pulaSprite stopAction : temp.pula_action ];
             [temp.pulaSprite setVisible:false];
            
        } else if ((pt.y) > (768+ 100)) {
              [temp.pulaSprite stopAction : temp.pula_action ];
              [temp.pulaSprite setVisible:false];
        } else if ((pt.y) < (-100)) {
            [temp.pulaSprite stopAction : temp.pula_action ];
            [temp.pulaSprite setVisible:false];        }
        }
      }
   }
 }
-(void)targetPulaActionFinished
{
    _isPulaActionDone =true;
}
         
-(void)  KillOrLiveDuck :(int) inc
{
   if (inc > 0) {
       m_duckLives++;
       if (m_duckLives >= 99)
             m_duckLives = 99;
       } else {
             m_duckLives--;
                // if (m_duckLives <= 0)
                // m_duckLives = 9;
       }
             
    [m_duckLivesSprite SetNum:m_duckLives];
             
             /*
              * for (int i = 0; i < 10; i++) { if (i == m_duckLives)
              * m_duckLiveNums[i].setVisible(true); else
              * m_duckLiveNums[i].setVisible(false); }
              */
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event

{
    UITouch *touch = [touches anyObject];
    CGPoint location = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    
    float x,y;
    x =location.x/g_fx;
    y =location.y/g_fy;
    
   [self Init_Animation];
    
    // Exit
    if ((x > 0) && (x < 100) && y > 650)
    {
        [[CCDirector sharedDirector] resume];
        m_cmd = 0;
        [m_labelWait setVisible:true];
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionShrinkGrow transitionWithDuration:0.5 scene:SelectLayer.scene]];
        return;
    } else if ((x > 550) && (x < 650) && y > 650) {
       if (!bPaused) {
            [m_pauseSprite setTextureRect:[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"play.png"] rect] rotated:[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"play.png"] rotated] untrimmedSize:[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"play.png"] rect].size];
            
        
            
            [[CCDirector sharedDirector] pause];
            bPaused = true;
        } else {
             [m_pauseSprite setTextureRect:[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"pause.png"] rect] rotated:[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"pause.png"] rotated] untrimmedSize:[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"pause.png"] rect].size];
            
            [[CCDirector sharedDirector] resume];
            
            bPaused = false;
        }
        
        return;
    } else if (bPaused) {
        return;
    }
    
    if (m_duckStrelAction != nil)
        if (!_isduckActionEnd)
            return;
    
    for (Apple_Object *apple in m_apples) {
        if ([apple.m_appleActionMove tag] == 1
            && !([apple.m_appleActionMove elapsed]>=apple.m_appleActionMove.duration ))
            return;
    }
    
    if ((x > 512) && (x < 1024)) {
        if (m_iAttack == 2)
            m_duckStrelAction = m_duckStrelActionUpFast;
        else
            m_duckStrelAction = m_duckStrelActionUp;
        
        
        CCCallFuncN* actionForTargetMoveDidFinish = [CCCallFuncN actionWithTarget:self selector:@selector(targetMoveFinished)];
        _isduckActionEnd =false;
        [m_duckSprite runAction:[CCSequence actions:m_duckStrelAction,actionForTargetMoveDidFinish,nil]];

        //[m_duckSprite runAction :m_duckStrelAction ];
        
        int i = 0;
        for (Apple_Object *apple in m_apples) {
            [apple.m_appleSprite setPosition: CGPointMake(m_duckPos.x,
                                                        m_duckPos.y)];
            
            float rotation = 0;
            
            if (i == 0)
                rotation = 0;
            else if (i == 1)
                rotation = (float) (M_PI / 5);
            else
                rotation = -(float) (M_PI / 5);
            
            CGPoint pt = CGPointMake(0.0f, 1.0f);
            CGPoint pt2 = CGPointMake(0.0f, 1.0f);
            
            pt2.x = (float) (pt.x * cos(rotation) - pt.y
                             * sin(rotation));
            pt2.y = (float) (pt.x * sin(rotation) + pt.y
                             * cos(rotation));
            
            pt2.x *= 1800.0f;
            pt2.y *= 1800.0f;
            
            if (m_iAttack == 3) {
                [apple.m_appleSprite setScale:1.3f];
            } else {
                [apple.m_appleSprite setScale:1.0f];
            }
            
            if (m_iAttack == 2) {
             
                [apple.m_appleActionMove initWithDuration:1.0f position:CGPointMake(m_duckPos.x
                                                                                    + pt2.x, m_duckPos.y + pt2.y)];
                
            } else {
                [apple.m_appleActionMove initWithDuration:2.0f position:CGPointMake(m_duckPos.x
                                                                                    + pt2.x, m_duckPos.y + pt2.y)];
                

            }
            
            [apple.m_appleSprite runAction :apple.m_appleActionMove];
            [apple.m_appleSprite setVisible:true];
            [apple.m_appleActionMove setTag:1];
            
            if (m_iAttack != 1)
                break;
            i++;
        }
        
    }
    
    else if ((x > 0) && (x < 512)) {
        
        if (m_iAttack == 2)
            m_duckStrelAction = m_duckStrelActionVbokFast;
        else
            m_duckStrelAction = m_duckStrelActionVbok;
        
        CCCallFuncN* actionForTargetMoveDidFinish = [CCCallFuncN actionWithTarget:self selector:@selector(targetMoveFinished)];
        _isduckActionEnd =false;
        [m_duckSprite runAction:[CCSequence actions:m_duckStrelAction,actionForTargetMoveDidFinish,nil]];
        
        for (Apple_Object *apple in m_apples) {
            [apple.m_appleSprite setPosition :CGPointMake(m_duckPos.x,
                                                        m_duckPos.y)];
            
            float rotation;
            
            if ([m_duckSprite flipX])
                rotation = (float) (M_PI / 2);
            else
                rotation = -(float) (M_PI / 2);
            
            CGPoint pt = CGPointMake(0.0f, 1.0f);
            CGPoint pt2 = CGPointMake(0.0f, 1.0f);
            pt2.x = (float) (pt.x * cos(rotation) - pt.y
                             * sin(rotation));
            pt2.y = (float) (pt.x * sin(rotation) + pt.y
                             * cos(rotation));
            
            pt2.x *= 1800.0f;
            pt2.y *= 1800.0f;
            
            if (m_iAttack == 3) {
                [apple.m_appleSprite setScale :1.3f];
            } else {
                [apple.m_appleSprite setScale :1.0f];
            }
            
            if (m_iAttack == 2) {
                [apple.m_appleActionMove initWithDuration:1.0f position:CGPointMake(m_duckPos.x
                                                                                    + pt2.x, m_duckPos.y + pt2.y)];
               
            } else {
                [apple.m_appleActionMove initWithDuration:2.0f position:CGPointMake(m_duckPos.x
                                                                                    + pt2.x, m_duckPos.y + pt2.y)];

            }
            
            [apple.m_appleSprite runAction :apple.m_appleActionMove];
            [apple.m_appleSprite setVisible :true];
            [apple.m_appleActionMove setTag:1];
            break;
        }
    }

}
-(void)targetMoveFinished
{
    _isduckActionEnd =true;
}

-(void) canonicalOrientationToScreenOrientation:(int) displayRotation
{
    int axisSwap[4][4] = {
        {  1,  -1,  0,  1  },     // ROTATION_0
        {-1,  -1,  1,  0  },     // ROTATION_90
        {-1,    1,  0,  1  },     // ROTATION_180
        {  1,    1,  1,  0  }  }; // ROTATION_270
    
    
    
    
    screenVec[0]  =  (float) axisSwap[displayRotation][0] * canVec[ axisSwap[displayRotation][2] ];
    screenVec[1]  =  (float) axisSwap[displayRotation][1] * canVec[ axisSwap[displayRotation][3] ];
    screenVec[2]  =  canVec[2];
}

-(void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    
    
    float accelX;
    float accelY;
    float accelZ;
    
//    static Boolean first_flag =false;
//    if(!first_flag){
//        first_flag =true;
//        [self Init_Animation];
//    }
// 
    if (bExit)
    {
        return;
    }
    
    
    if (lastTicks == 0 )
    {
        lastTicks = [[NSDate date] timeIntervalSince1970]*1000;
        return;
    }
    long long  dt = [[NSDate date] timeIntervalSince1970]*1000 - lastTicks;
    
    if (dt < 20)
        return;
    
    lastTicks =[[NSDate date] timeIntervalSince1970]*1000;
    
    
    double kef = (double)dt / 10.0;
    // double kef =25.8f;
    
    canVec[0] = acceleration.x;
    canVec[1] = acceleration.y;
    canVec[2] = acceleration.z;
    
    
    [self canonicalOrientationToScreenOrientation:1];
    
    // MySettings.getInstance().canonicalOrientationToScreenOrientation(MySettings.getInstance().rotationIndex, canVec, screenVec);
    
    accelX =screenVec[0];
    accelY =screenVec[1];
    accelZ= screenVec[2];
    
    
    
    
    //    acceleration.x = screenVec[0];
    //    acceleration.y = screenVec[1];
    //    acceleration.z = screenVec[2];
    
	//	else
    //	return;
    
    // change duck position
    
    CGPoint p = m_duckPos;
    
	//	p.y -= accelX*1.5f; // ï¿½ ï¿½ï¿½ï¿½ï¿½
    
    accelY = -accelY;
   // if (accelY < 0)
   //     accelY = 0;
   // accelY =accelY - 5;
    
    //p.y -= (accelY + (MySettings.getInstance().UpDownKef - 50.0) / 25.0)
    //				* 1.0f * kef; // ï¿½ ï¿½ï¿½ï¿½ï¿½
	//	p.x -= (accelX - (MySettings.getInstance().LeftRightKef - 50.0) / 50.0)
    //		* 1.5f * kef;
    
    
    p.y -= (accelY) *1.0f*kef * LeftRightKef/ 25.0f;
    p.x -= (accelX) *1.5f*kef *  LeftRightKef/ 25.0f;
    
    if (accelX < -0.3f) {
        if (m_duckStrelAction != nil) {
            if (_isduckActionEnd ) {
              
                [m_duckSprite setTextureRect:rcDuckMove rotated:rotatedDuckMove untrimmedSize:rcDuckMove.size];
                // m_duckSprite.setTextureRect(CGRect.make(4*119.0f,
                // 3*113.5f, 119.0f, 113.5f), false);
                [m_duckSprite setFlipX :false];
            }
        } else {

            [m_duckSprite setTextureRect:rcDuckMove rotated:rotatedDuckMove untrimmedSize:rcDuckMove.size];
            // m_duckSprite.setTextureRect(CGRect.make(4*119.0f, 3*113.5f,
            // 119.0f, 113.5f), false);
            [m_duckSprite setFlipX :false];
        }
    } else if (accelX > 0.3f) {
        // p.x += accelY*1.5f*kef;
            if (m_duckStrelAction != nil) {
              if (_isduckActionEnd) {
          
               
                [m_duckSprite setTextureRect:rcDuckMove rotated:rotatedDuckMove untrimmedSize:rcDuckMove.size];
                // m_duckSprite.setTextureRect(CGRect.make(4*119.0f, 3*113.5f,
                // 119.0f, 113.5f), false);
                [m_duckSprite setFlipX :true];
              }
            
            } else {
            
               [m_duckSprite setTextureRect:rcDuckMove rotated:rotatedDuckMove untrimmedSize:rcDuckMove.size];
                // m_duckSprite.setTextureRect(CGRect.make(4*119.0f, 3*113.5f,
               // 119.0f, 113.5f), false);
               [m_duckSprite setFlipX :true];
            }
        
    }else if( abs(accelX) < 0.3f) {
        // p.x += accelY*2.5f;
           if (m_duckStrelAction != nil) {
            
//                if([m_duckStrelAction isDone]){
               if(_isduckActionEnd){
                   [m_duckSprite setTextureRect:rcDuckStay rotated:rotatedDuckStay untrimmedSize:rcDuckStay.size];
                
                }
           
            } else {
               [m_duckSprite setTextureRect:rcDuckStay rotated:rotatedDuckStay untrimmedSize:rcDuckStay.size];
            // m_duckSprite.setTextureRect(CGRect.make(3*119.0f, 3*113.5f,
            // 119.0f, 113.5f), false);
           }
       
        
    }

   

    [self SetDuckPosX :p.x PosY:p.y];
    
  
}

-(void) SetDuckPosX :(float) x PosY:(float) y

{
    m_duckPos.x = x;
    m_duckPos.y = y;
    
    if (m_duckPos.y > m_YMax)
        m_duckPos.y = m_YMax;
    if (m_duckPos.y < m_YMin)
        m_duckPos.y = m_YMin;
    
    
    if (m_duckPos.x < 60)
        m_duckPos.x = 60;
    if (m_duckPos.x > 1024*3-20)
        m_duckPos.x = 1024*3-20;
}


@end
