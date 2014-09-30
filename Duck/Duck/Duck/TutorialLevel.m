//
//  TutorialLevel.m
//  Duck
//
//  Created by Anton on 9/13/14.
//  Copyright (c) 2014 Anton. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "TutorialLevel.h"
#import "SimpleAudioEngine.h"
#import "MenuLayer.h"
#define OriginY 384


@implementation TutorialLevel
{
    
}

float g_fx,g_fy,g_fx1,g_fy1;
bool flag_retain=false;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	TutorialLevel *layer = [TutorialLevel node];
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
        WIN_SIZE_X =size.width;
        WIN_SIZE_Y =size.height;
     	//CCSprite *background;
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"play.mp3"];
        
  //--------------------------test module -----------------------------------------------------------
//        
//        NSMutableArray *frames =[NSMutableArray array];
////          NSMutableArray *frames =[[NSMutableArray alloc]init];
//        m_duckStrelAnimationVbok = [[CCAnimation alloc] init];
//        
//        for (int i = 1; i < 19; i++) {
//
//                  NSString *strFilename;
//                  strFilename = [NSString stringWithFormat:@"strelaet_pramo%d.png", i];
//            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:strFilename];
//            [frames addObject:frame];
////                  [m_duckStrelAnimationVbok addSpriteFrameWithFilename:strFilename];
//         }
//        m_duckStrelAnimationVbok = [CCAnimation  animationWithSpriteFrames:frames delay:0.05f];
////         [m_duckStrelAnimationVbok setDelayPerUnit:1.0f];
//        
//        [self setScaleX:g_fx];
//        [self setScaleY:g_fy];
//        
//        CCSpriteFrame *cframe =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_stay.png"];
//        CCSprite *test = [CCSprite spriteWithSpriteFrame:cframe];
//        [test setPosition:ccp(512*g_fx,384*g_fy)];
//        
//        [self addChild: test];
//       
//        CCAnimate *animate = [CCAnimate actionWithAnimation:m_duckStrelAnimationVbok];
//        CCRepeatForever *repeat = [CCRepeatForever actionWithAction:animate];
//        [test runAction: animate];
  //---------------------------------------------------------------------------------------------------------
        
        
        m_iLoadedHunter = -1;
		m_cmd = -1;
	    [self setTouchEnabled:true];
        [self setAccelerometerEnabled:true];
        [[UIAccelerometer sharedAccelerometer]setDelegate: self];
        
		m_bEnd = false;
        
		m_lblTitle = nil;
		m_lblTitle2 = nil;
		m_hunterSheet1 = nil;
		m_hunterAnimation1 = nil;
        
		m_backgrounds = [[NSMutableArray alloc]init];
        m_duckPos = CGPointZero;
        
		
		m_rootNode = [CCNode node];
 
        [self setScaleX:g_fx];
        [self setScaleY:g_fy];
        [self setPosition: ccp(-(1024-size.width)/2.0f*g_fx , -(768-size.height)/2.0f*g_fy )];
  	    [self addChild:m_rootNode];
        
		// duck sheet
        
        CCSpriteFrame *cframe = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_stay.png"];
      	m_duckSheet = [CCSpriteBatchNode batchNodeWithTexture:[cframe texture]];
        
      //  m_duckSheet =[CCSpriteBatchNode  batchNodeWithFile:@"duck_stay.png"];
        [m_rootNode addChild:m_duckSheet z:7];
        
        
        // create the animation
        
        
        NSMutableArray *frames =[NSMutableArray array];
        m_duckStrelAnimationUp = [[CCAnimation alloc] init];
        for (int i = 1; i < 19; i++) {
            
            NSString *strFilename;
            strFilename = [NSString stringWithFormat:@"duck_strel%d.png", i];
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:strFilename];
            [frames addObject:frame];
        }
        m_duckStrelAnimationUp = [CCAnimation  animationWithSpriteFrames:frames delay:0.05f];

        
       [frames removeAllObjects];
        m_duckStrelAnimationVbok = [[CCAnimation alloc] init];
        
        for (int i = 1; i < 19; i++) {
            NSString *strFilename;
            strFilename = [NSString stringWithFormat:@"strelaet_pramo%d.png", i];
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:strFilename];
            [frames addObject:frame];
            
        }
        m_duckStrelAnimationVbok = [CCAnimation  animationWithSpriteFrames:frames delay:0.05f];
        
       
        m_duckStrelActionUp =   [CCAnimate actionWithAnimation:m_duckStrelAnimationUp];
		m_duckStrelActionVbok = [CCAnimate actionWithAnimation:m_duckStrelAnimationVbok];
        
        
        cframe  =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"apple1.png"];
        m_appleSheet = [CCSpriteBatchNode batchNodeWithTexture: [cframe texture]];
		[m_rootNode addChild:m_appleSheet z:7];
		
		// create the animation
        
        [frames removeAllObjects];
         m_appleAnimation = [[CCAnimation alloc] init];
        for(int i = 2; i <6  ; i++) {
            NSString *strFilename;
            strFilename = [NSString stringWithFormat:@"apple%d.png", i];
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:strFilename];
            [frames addObject:frame];
        }
        m_appleAnimation = [CCAnimation animationWithSpriteFrames:frames delay:0.1f];
        
       m_appleActionAnim = [CCAnimate actionWithAnimation:m_appleAnimation];
       [m_appleActionAnim setTag :0];
       m_appleActionMove = [CCMoveTo actionWithDuration:2.0f position: ccp(1.0f, 1.0f)];
        
        
       [frames removeAllObjects];
         m_duckDyn1 = [[CCAnimation alloc] init];
        for(int i = 1; i <4  ; i++) {
            NSString *strFilename;
            strFilename = [NSString stringWithFormat:@"duck_dyn1_%d.png", i];
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:strFilename];
            [frames addObject:frame];
           
        }
        m_duckDyn1 = [CCAnimation animationWithSpriteFrames:frames delay:0.25f];
        
        
        
        [frames removeAllObjects];
         m_duckDyn2 = [[CCAnimation alloc] init];
        for(int i = 1; i <4  ; i++) {
            NSString *strFilename;
            strFilename = [NSString stringWithFormat:@"duck_dyn2_%d.png", i];
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:strFilename];
            [frames addObject:frame];
            
        }
        m_duckDyn2 = [CCAnimation animationWithSpriteFrames:frames delay:0.25f];
        
        
        [frames removeAllObjects];
         m_duckKill1 = [[CCAnimation alloc] init];
        for(int i = 0; i <4  ; i++) {
            NSString *strFilename;
            strFilename = [NSString stringWithFormat:@"duck_kill1_%d.png", i%2+1];
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:strFilename];
            [frames addObject:frame];
            
        }
        m_duckKill1 = [CCAnimation animationWithSpriteFrames:frames delay:0.15f];
        
        
        [frames removeAllObjects];
        m_duckKill2 = [[CCAnimation alloc] init];
        for(int i = 0; i <4  ; i++) {
            NSString *strFilename;
            strFilename = [NSString stringWithFormat:@"duck_kill2_%d.png", i%2+1];
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:strFilename];
            [frames addObject:frame];
       
        }
        m_duckKill2 = [CCAnimation animationWithSpriteFrames:frames delay:0.15f];
        
        


     
        m_duckSprite =  [CCSprite spriteWithTexture: [m_duckSheet texture] rect: CGRectMake(3*119.0f, 3*113.5f, 119.0f, 113.5f)];
        [m_duckSprite setScale:g_fx1];
        
        [m_duckSheet addChild:m_duckSprite z:5];
    
      
        
     	[self SetDuckPosX :1024.0f*3.0f/ 2.0f PosY: 768.0f/2.0f/2.0f];
	    
        
		
        
		cframe =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"apple1.png"];
     	m_appleSprite = [CCSprite spriteWithSpriteFrame:cframe];
     	[m_appleSheet addChild:m_appleSprite z: 5];
		[m_appleSprite setVisible:false];
     
        
        
        
        
        cframe =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"shoot1.png"];
        m_shootSprite = [CCSprite spriteWithSpriteFrame:cframe];
        
//        if(density >1.1)
//           [m_shootSprite setScale:2];
//        else
           [m_shootSprite setScale:1.5f*g_fx1];
        
        
		[m_shootSprite setOpacity:160];
  		[m_rootNode addChild :m_shootSprite z:155];
        [m_shootSprite setVisible:true];
      	m_whereShoot = 0;
        
		
	    cframe =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"ok.png"];
        m_Ok = [CCSprite spriteWithSpriteFrame:cframe];
		[m_rootNode addChild:m_Ok z:100];
        [m_Ok setScale:0.8f];
        [m_Ok setOpacity:180];
        [m_Ok setVisible:false];
        
		
        cframe =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"menu.png"];
        m_Cancel = [CCSprite spriteWithSpriteFrame:cframe];
		[m_rootNode addChild:m_Cancel z:100];
        [m_Cancel setScale:0.4f*g_fx1];
        [m_Cancel setOpacity:180];

        
        cframe =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"yellow.png"];
        m_yellowSprite = [CCSprite spriteWithSpriteFrame:cframe];
    	[m_rootNode addChild:m_yellowSprite z:99];
        [m_yellowSprite setScale:6.0f*g_fx1];
        [m_yellowSprite setOpacity:200];

			
		
			
		if (_isRus){
            
        }
//			m_labelWait = CCLabelTTF makeLabel("Ïîäîæäèòå...", "Arial", 64);
		else
            m_labelWait =[CCLabelTTF labelWithString:@"Please Wait..."
                                          dimensions: [m_rootNode boundingBox].size
                                          hAlignment:UITextAlignmentCenter
                                       lineBreakMode:UILineBreakModeWordWrap
                                            fontName:@"Arial"
                                            fontSize:50*g_fy];

        [m_labelWait setPosition :CGPointMake((1024 / 2 + 20)*g_fx, (768 / 2 + 70)*g_fy)];
		[self addChild :m_labelWait z:200];
		[m_labelWait setVisible:false];

		
	       
	    
		if (_isRus)
        {
            
        }
			
		else
            m_lblTitle =[CCLabelTTF labelWithString:@"Turn the phone to the left"
                                          dimensions: [m_rootNode boundingBox].size
                                          hAlignment:UITextAlignmentCenter
                                       lineBreakMode:UILineBreakModeWordWrap
                                            fontName:@"Arial"
                                            fontSize:40];
        
        

		
		[m_lblTitle setColor: ccBLACK];
        [m_rootNode addChild: m_lblTitle z: 401];
		[m_lblTitle setVisible:true];
		
        
        m_lblTitleSh =[CCLabelTTF labelWithString:@"Íàêëîíèòå òåëåôîí âëåâî"
                                     dimensions:  [m_rootNode boundingBox].size
                                     hAlignment:UITextAlignmentCenter
                                  lineBreakMode:UILineBreakModeWordWrap
                                       fontName:@"Courier"
                                       fontSize:40];


        [m_lblTitleSh setColor: ccBLACK];
		[m_rootNode addChild: m_lblTitleSh z: 400];
		[m_lblTitleSh setVisible:false];

		
		if (_isRus)
        {
			//m_lblTitle2 = CCLabel.makeLabel("äëÿ äâèæåíèÿ óòêè âëåâî", "Courier", 54);
        }
		else
            m_lblTitle2 =[CCLabelTTF labelWithString:@"to duck moved to the left"
                                         dimensions:  [m_rootNode boundingBox].size
                                         hAlignment:UITextAlignmentCenter
                                      lineBreakMode:UILineBreakModeWordWrap
                                           fontName:@"Courier"
                                           fontSize:40];

        [m_lblTitle2 setColor: ccBLACK];
		[m_rootNode addChild: m_lblTitle2 z: 401];
		[m_lblTitle2 setVisible:true];
		
        
        m_lblTitle2Sh =[CCLabelTTF labelWithString:@"äëÿ äâèæåíèÿ óòêè âëåâî"
                                       dimensions:  [m_rootNode boundingBox].size
                                       hAlignment:UITextAlignmentCenter
                                    lineBreakMode:UILineBreakModeWordWrap
                                         fontName:@"Courier"
                                         fontSize:40];
        
        
        [m_lblTitle2Sh setColor: ccBLACK];
		[m_rootNode addChild: m_lblTitle2Sh z: 400];
		[m_lblTitle2Sh setVisible:false];
        
        
		
        m_TutorialState = 0;
        lastTicks =0;
        
        
		m_Bool = false;
        

        
		m_Time = [[NSDate date] timeIntervalSince1970]*1000;//SystemClock.uptimeMillis();
		m_shootTime =[[NSDate date] timeIntervalSince1970]*1000;// SystemClock.uptimeMillis();
		
		m_visibleWidth = (float)size.width / g_fx;
       
	  
        [self ChangeLevel:1];
 
        [self scheduleUpdate];
   
        
   }
	
	return self;
}

-(void) Init_sprite
{
    
    NSMutableArray *frames =[NSMutableArray array];
    m_duckStrelAnimationUp = [[CCAnimation alloc] init];
    for (int i = 1; i < 19; i++) {
        
        NSString *strFilename;
        strFilename = [NSString stringWithFormat:@"duck_strel%d.png", i];
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:strFilename];
        [frames addObject:frame];
    }
    m_duckStrelAnimationUp = [CCAnimation  animationWithSpriteFrames:frames delay:0.05f];
    
    
    [frames removeAllObjects];
    m_duckStrelAnimationVbok = [[CCAnimation alloc] init];
    
    for (int i = 1; i < 19; i++) {
        NSString *strFilename;
        strFilename = [NSString stringWithFormat:@"strelaet_pramo%d.png", i];
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:strFilename];
        [frames addObject:frame];
        
    }
    m_duckStrelAnimationVbok = [CCAnimation  animationWithSpriteFrames:frames delay:0.05f];
    
    
    m_duckStrelActionUp =   [CCAnimate actionWithAnimation:m_duckStrelAnimationUp];
    m_duckStrelActionVbok = [CCAnimate actionWithAnimation:m_duckStrelAnimationVbok];
    
    
    // create the animation
    
    [frames removeAllObjects];
    m_appleAnimation = [[CCAnimation alloc] init];
    for(int i = 2; i <6  ; i++) {
        NSString *strFilename;
        strFilename = [NSString stringWithFormat:@"apple%d.png", i];
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:strFilename];
        [frames addObject:frame];
    }
    
    m_appleAnimation = [CCAnimation animationWithSpriteFrames:frames delay:0.1f];
    m_appleActionAnim = [CCAnimate actionWithAnimation:m_appleAnimation];
    [m_appleActionAnim setTag :0];
    m_appleActionMove = [CCMoveTo actionWithDuration:2.0f position: ccp(1.0f, 1.0f)];
    
    
    [frames removeAllObjects];
    m_duckDyn1 = [[CCAnimation alloc] init];
    for(int i = 1; i <4  ; i++) {
        NSString *strFilename;
        strFilename = [NSString stringWithFormat:@"duck_dyn1_%d.png", i];
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:strFilename];
        [frames addObject:frame];
        
    }
    m_duckDyn1 = [CCAnimation animationWithSpriteFrames:frames delay:0.25f];
    
    
    
    [frames removeAllObjects];
    m_duckDyn2 = [[CCAnimation alloc] init];
    for(int i = 1; i <4  ; i++) {
        NSString *strFilename;
        strFilename = [NSString stringWithFormat:@"duck_dyn2_%d.png", i];
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:strFilename];
        [frames addObject:frame];
        
    }
    m_duckDyn2 = [CCAnimation animationWithSpriteFrames:frames delay:0.25f];
    
    
    [frames removeAllObjects];
    m_duckKill1 = [[CCAnimation alloc] init];
    for(int i = 0; i <4  ; i++) {
        NSString *strFilename;
        strFilename = [NSString stringWithFormat:@"duck_kill1_%d.png", i%2+1];
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:strFilename];
        [frames addObject:frame];
        
    }
    m_duckKill1 = [CCAnimation animationWithSpriteFrames:frames delay:0.15f];
    
    
    [frames removeAllObjects];
    m_duckKill2 = [[CCAnimation alloc] init];
    for(int i = 0; i <4  ; i++) {
        NSString *strFilename;
        strFilename = [NSString stringWithFormat:@"duck_kill2_%d.png", i%2+1];
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:strFilename];
        [frames addObject:frame];
        
    }
    m_duckKill2 = [CCAnimation animationWithSpriteFrames:frames delay:0.15f];
    
}

-(void) UpdateTitles
{
    if ( m_bTitle1Changed )
    {
        [m_lblTitle setString :m_Title1Str];
        [m_lblTitleSh setString :m_Title1Str];
        m_bTitle1Changed = false;
    }
    if ( m_bTitle2Changed )
    {
        if ([m_Title2Str length] != 0)
        {
            [m_lblTitle2 setString:m_Title2Str];
            [m_lblTitle2Sh setString:m_Title2Str];
        }
        m_bTitle2Changed = false;
    }
}
-(void) SetTitle: (NSString*)str1 str2:(NSString*)str2
{
    m_Title1Str = str1;
    m_bTitle1Changed = true;
    
    m_Title2Str = str2;
    m_bTitle2Changed = true;
	
    if ( [str2 length] != 0)
    {
        [m_lblTitle2 setVisible:true];

    }
    else
    {
        [m_lblTitle2 setVisible:false];

    }
}
-(void) ChangeLevel:(int) level
{
    
    //m_BonusBox.sprite.setVisible( false );
    //m_BonusState = 0;
    //m_BonusTime = SystemClock.uptimeMillis() + MIN_DELAY_BONUS + random.nextInt(MIN_DELAY_BONUS);
    
    m_YMin = 60;
    m_YMax = 140;
    m_CurLevel = Level_Lists[9];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level10.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level10_2.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level10_3.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level10_4.plist"];
 //   [self LoadHunterData:1];
    [self BuildWorld];
    
    [self SetDuckPosX :1024.0f * 3.0f / 2.0f PosY: 768.0f/2.0f/2.0f];
    
}
-(void) LoadHunterData:(int) type
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
    m_hunterSheet1 = [CCSpriteBatchNode  batchNodeWithTexture:[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:strHunter] texture]];
    m_hunterHead = [CCSprite  spriteWithSpriteFrame: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:strHunter]];
    [m_hunterHead setTextureRect: CGRectMake(0 * 176.0f, 0 * 161.0f, 176.0f,
                                             161.0f)];
    [m_hunterHead setScale :0.4f*g_fx1];
    [m_hunterHead setVisible :true];
    [m_rootNode addChild :m_hunterHead z:100];
    

    
    // hunter kill sprite and animation
    
    NSMutableArray *frames = [[NSMutableArray alloc]init];
    [frames removeAllObjects];
    m_huntkillAnimation = [[CCAnimation alloc] init];

    for(int i = 1; i <6  ; i++) {
        NSString *strFilename;
        strFilename = [NSString stringWithFormat:@"hunt_kill%d.png", i];
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:strFilename];
        [frames addObject:frame];

    }
    m_huntkillAnimation  = [CCAnimation animationWithSpriteFrames:frames delay:0.15f];
    
    m_huntkillSprite = [CCSprite spriteWithSpriteFrame:    [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"hunt_kill1.png"]];
    [m_rootNode addChild :m_huntkillSprite z: 500];
    [m_huntkillSprite setVisible :false];
  
    
    ccTexParams params = {GL_LINEAR, GL_LINEAR, GL_CLAMP_TO_EDGE, GL_CLAMP_TO_EDGE};
    
    [[m_hunterSheet1 texture] setTexParameters: &params];
    
    [m_rootNode addChild :m_hunterSheet1  z:6];
   
    // create the hunters animation
    [frames removeAllObjects];
    m_hunterAnimation1 = [[CCAnimation alloc] init];
    
    for (int y = 0; y < 2; y++) {
        for (int x = 0; x < 5; x++) {
            
            CCSpriteFrame *frame = [CCSpriteFrame frameWithTexture:[m_hunterSheet1 texture] rect:CGRectMake(x * 176.0f, y * 161.0f, 176.0f, 161.0f) ];
            [frames addObject: frame];
        }
    }
    m_hunterAnimation1  = [CCAnimation animationWithSpriteFrames:frames delay:0.15f];
    
    [frames removeAllObjects];
    m_hunterPulaAnimation1 = [[CCAnimation alloc] init];
    for (int x = 0; x < 5; x++) {
        
        CCSpriteFrame *frame = [CCSpriteFrame frameWithTexture:[m_hunterSheet1 texture] rect:CGRectMake(x * 176.0f, 3 * 161.0f, 176.0f, 161.0f) ];
        [frames addObject: frame];
    }
    m_hunterPulaAnimation1  = [CCAnimation animationWithSpriteFrames:frames delay:0.25f];
    

    
}
-(void)BuildWorld
{

    for (BackgroundItem *bi in m_CurLevel.m_BackgroundItems) {
      
      Background *b = [[Background alloc]init];
    
    if (bi.isSkyBox == 1) {
        b.sprite  = [CCSprite spriteWithFile:bi.texture_name];  ///---------------------------------checking------------
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
            
            //[b.sprite setScaleX : (WIN_SIZE_X/g_fx/1024)*g_fx1];
            [b.sprite setScaleX : g_fx1];
            [b.sprite setScaleX : g_fy1];
        }
        
        [m_backgrounds addObject:b];
        
        if (bi.isSkyBox == 1)
            m_skyBox = b;
    }
   }
    
    
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
-(void) update:(ccTime) dt
{
    if(!init_flag){
        init_flag =true;
        
        [self Init_sprite];
    }
    [m_duckSprite setPosition:m_duckPos];
  
   

    
    float x = 1024 / 2 - m_duckPos.x;
    float add = (m_visibleWidth - 1024) / 2;
    
    if (x > -add)
        x = -add;
    if (x < (-(1024 * 3 - (1024 + add))))
        x = -(1024 * 3 - (1024 + add));
    [m_rootNode setPosition: ccp(x, 0)];

    [m_Cancel  setPosition :ccp(-x + 35 - add, 730)];
    [m_yellowSprite  setPosition :ccp(-x+600-add, 685)];
    
    if ( m_whereShoot == 1 )
    {
        [m_shootSprite setPosition : ccp(-x + 100 - add, 130)];

    }
    else if ( m_whereShoot == 2 )
    {
        [m_shootSprite setPosition :ccp(-x + 890 - add, 130)];

       
    }
    
    if ( m_whereShoot != 0 )
    {
        if ( [m_shootSprite visible] )
        {
           if ( ([[NSDate date] timeIntervalSince1970]*1000 - m_shootTime) > 700 )
         
            {
                [m_shootSprite setVisible:false];
                m_shootTime = [[NSDate date] timeIntervalSince1970]*1000;
            }
        }
        else
        {
            if (([[NSDate date] timeIntervalSince1970]*1000- m_shootTime) > 700 )
            {
                [m_shootSprite setVisible:true];
                m_shootTime = [[NSDate date] timeIntervalSince1970]*1000;
            }
			
        }
    }
    else
    {
        if ( [m_shootSprite visible] )
        {
            [m_shootSprite setVisible:false];
        }
    }
    
    
    

    if ( [m_lblTitle2 visible])
    {
        [ m_lblTitle setPosition :CGPointMake(-x+650-add, 700+20)];
        [ m_lblTitleSh setPosition:CGPointMake(-x+653-add, 697+20)];
        [ m_lblTitle2 setPosition:CGPointMake(-x+650-add, 640+20)];
        [ m_lblTitle2Sh setPosition:CGPointMake(-x+653-add, 637+20)];
    }
    else
    {
        [ m_lblTitle setPosition :CGPointMake(-x+650-add, 700-15)];
        [ m_lblTitleSh setPosition:CGPointMake(-x+653-add, 697-15)];

        [m_Ok setPosition:CGPointMake(-x+450-add, 700-10)];
    }
    
    
    if (m_appleActionMove != nil)
    {
        CGPoint pt = [m_appleSprite position];
        if ((pt.x+x) < -300)
        {
            [m_appleSprite stopAllActions];
            [m_appleSprite setVisible :false];
        }
        else if ((pt.x+x) > (1024+350))
        {
            [m_appleSprite stopAllActions];
            [m_appleSprite setVisible :false];
        }
        else if ((pt.y) > (768+100))
        {
            [m_appleSprite stopAllActions];
            [m_appleSprite setVisible :false];
        }
        else if ((pt.y) < (-100))
        {
            [m_appleSprite stopAllActions];
            [m_appleSprite setVisible :false];
        }
    }
    
    if ( m_TutorialState == 1 )
    {
        if (([[NSDate date] timeIntervalSince1970]*1000 - m_Time) > 2000)
        {
            m_TutorialState = 2;
            m_Time = [[NSDate date] timeIntervalSince1970]*1000;
            m_Bool = false;
            if (_isRus)

                [self SetTitle :@"Íàêëîíèòå òåëåôîí âïðàâî" str2: @"äëÿ äâèæåíèÿ óòêè âïðàâî"];
            else
                [self SetTitle :@"Turn the phone to the right" str2: @"to move to the right duck"];
            [m_Ok setVisible:false];
        }
    }
    else if ( m_TutorialState == 3 )
    {
        if (([[NSDate date] timeIntervalSince1970]*1000 - m_Time) > 2000)
        {
            m_TutorialState = 4;
            m_Time = [[NSDate date] timeIntervalSince1970]*1000;
            m_Bool = false;
            if (_isRus)
                [self SetTitle: @"Íàêëîíèòå òåëåôîí îò ñåáÿ" str2: @"äëÿ äâèæåíèÿ óòêè ââåðõ"];
            else
                [self SetTitle: @"Turn the phone away from you" str2: @"to move up a duck"];
            [m_Ok setVisible:false];
        }
    }
    else if ( m_TutorialState == 5 )
    {
      if (([[NSDate date] timeIntervalSince1970]*1000 - m_Time) > 2000)
       {
            m_TutorialState = 6;
            m_Time = [[NSDate date] timeIntervalSince1970]*1000;
            m_Bool = false;
            if (_isRus)

                [self SetTitle :@"Íàêëîíèòå òåëåôîí ê ñåáå" str2: @"äëÿ äâèæåíèÿ óòêè âíèç"];
            else
                [self SetTitle :@"Tilt the phone to move himself" str2: @"to move duck down" ];
            [m_Ok setVisible:false];
        }
    }
    else if ( m_TutorialState == 7 )
    {
       if (([[NSDate date] timeIntervalSince1970]*1000 - m_Time) > 2000)
        {
            m_TutorialState = 8;
            m_Time = [[NSDate date] timeIntervalSince1970]*1000;
            m_Bool = false;
            
            if (_isRus)
                [self SetTitle :@"Íàæìèòå íà ëåâóþ ÷àñòü ýêðàíà" str2: @"äëÿ ñòðåëüáû ïåðåä ñîáîé"];
            else
                [self SetTitle :@"Touch the left side of the screen" str2: @"to fire forward" ];
         

            m_whereShoot = 1;
            m_shootTime = [[NSDate date] timeIntervalSince1970]*1000;
           
            [m_Ok setVisible:false];
        }
    }
    else if ( m_TutorialState == 9 )
    {
        if (([[NSDate date] timeIntervalSince1970]*1000 - m_Time) > 2000)
        {
            m_TutorialState = 10;
            m_Time = [[NSDate date] timeIntervalSince1970]*1000;
            m_Bool = false;
            
            if (_isRus)
                [self SetTitle :@"Íàæìèòå íà ïðàâóþ ÷àñòü ýêðàíà" str2: @"äëÿ ñòðåëüáû ââåðõ"];
            else
                [self SetTitle :@"Touch the right side of the screen" str2: @"to fire up" ];
            
            
            m_whereShoot = 2;
            m_shootTime = [[NSDate date] timeIntervalSince1970]*1000;
            [m_Ok setVisible:false];
        }
   
    }
    else if ( m_TutorialState == 11 )
    {
        if (([[NSDate date] timeIntervalSince1970]*1000 - m_Time) > 2000)
        {
            m_TutorialState = 12;
            m_Time = [[NSDate date] timeIntervalSince1970]*1000;
            m_Bool = false;
            
            if (_isRus)
                [self SetTitle :@"Ïîçäðàâëÿåì! Âû óñïåøíî ïðîøëè"str2: @ "îáó÷åíèå è ìîæåòå ïðèñòóïèòü ê èãðå"];
            else
                [self SetTitle :@"Congratulations!"str2: @ "You can start playing" ];
            
            
            m_whereShoot = 0;
            [m_shootSprite setVisible:false];
            [m_Ok setVisible:false];

            
        }
    }
    
    [self UpdateTitles];
    
    if (m_skyBox != nil)
    {
        [m_skyBox.sprite setPosition: ccp(-x+1024/2, 768 / 2)];
    }
    
    if (m_bEnd)
    {
        return;
    }
    
    if (m_cmd == 0)
    {
        m_cmd = 1;
    }
    else if (m_cmd == 1)
    {
        m_cmd = -1;
       [[CCDirector sharedDirector] replaceScene:[CCTransitionShrinkGrow transitionWithDuration:0.5 scene:MenuLayer.scene]];
    }
    
}
- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
              
{
     UITouch *touch = [touches anyObject];
     CGPoint location = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    
    
     float x,y;
     x =location.x/g_fx;
     y =location.y/g_fy;
    
    if ((x > 0) && (x < 100) && y > 650)
    {
        
        m_cmd = 0;
        [m_labelWait setVisible:true];
        return;
    }


    if(!init_flag1){
        init_flag1 =true;
        [self Init_sprite];
    }

    //if (m_duckStrelAction != nil)
    //    if (![m_duckStrelAction isDone] )
    //        return;
   
    
    if ( m_TutorialState >= 10 )
		if ((x > 512) && (x < 1024))
		{
           
            NSMutableArray *frames =[NSMutableArray array];
            m_duckStrelAnimationUp = [[CCAnimation alloc] init];
            for (int i = 1; i < 19; i++) {
                
                NSString *strFilename;
                strFilename = [NSString stringWithFormat:@"duck_strel%d.png", i];
                CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:strFilename];
                [frames addObject:frame];
            }
            m_duckStrelAnimationUp = [CCAnimation  animationWithSpriteFrames:frames delay:0.05f];
            
			m_duckStrelActionUp =[CCAnimate actionWithAnimation:m_duckStrelAnimationUp];
            
            m_duckStrelAction = m_duckStrelActionUp;
			[m_duckSprite runAction:m_duckStrelAction];
            
            
            for(int i = 2; i <6  ; i++) {
                NSString *strFilename;
                strFilename = [NSString stringWithFormat:@"apple%d.png", i];
                CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:strFilename];
                [frames addObject:frame];
            }
            
            m_appleAnimation = [CCAnimation animationWithSpriteFrames:frames delay:0.1f];
            m_appleActionAnim = [CCAnimate actionWithAnimation:m_appleAnimation];
            [m_appleActionAnim setTag :0];
            m_appleActionMove = [CCMoveTo actionWithDuration:2.0f position: ccp(1.0f, 1.0f)];
			
			[m_appleSprite setPosition: m_duckPos];
            
			float rotation = 0;
			CGPoint pt = CGPointMake(0.0f, 1.0f);
			CGPoint pt2 = CGPointMake(0.0f, 1.0f);
			pt2.x = (float) (pt.x*cos(rotation) - pt.y*sin(rotation));
			pt2.y = (float) (pt.x*sin(rotation) + pt.y*cos(rotation));
			
			pt2.x *= 1800.0f;
			pt2.y *= 1800.0f;
            
            
            
		    [ m_appleActionMove initWithDuration:2.0f position:CGPointMake(m_duckPos.x+pt2.x, m_duckPos.y+pt2.y)];
            
			[m_appleSprite runAction :m_appleActionMove];
			[m_appleSprite setVisible :true];
			
			if ( m_TutorialState == 10 )
			{
				m_TutorialState = 11;
			    m_Time = [[NSDate date] timeIntervalSince1970]*1000;
				
				if (_isRus)
					[self SetTitle:@"Îòëè÷íî!" str2: @""];
				else
					[self SetTitle:@"Fine!" str2: @""];
				[m_Ok  setVisible :true];
			}
		}
    
    if ( m_TutorialState >=8  )
		if ((x > 0) && (x < 512))
		{
			
            
			m_duckStrelAction = m_duckStrelActionVbok;
			[m_duckSprite runAction :m_duckStrelAction];
			
			[m_appleSprite setPosition: m_duckPos];
            
			float rotation;
			
			if ([m_duckSprite flipX ])
				rotation = (float) (M_PI / 2);
			else
				rotation = -(float) (M_PI / 2);
            
			CGPoint pt = CGPointMake(0.0f, 1.0f);
			CGPoint pt2 = CGPointMake(0.0f, 1.0f);
			pt2.x = (float) (pt.x*cos(rotation) - pt.y*sin(rotation));
			pt2.y = (float) (pt.x*sin(rotation) + pt.y*cos(rotation));
			
			pt2.x *= 1800.0f;
			pt2.y *= 1800.0f;
            
		    
            [ m_appleActionMove initWithDuration:2.0f position:ccp(m_duckPos.x+pt2.x, m_duckPos.y+pt2.y)];
             
			[m_appleSprite runAction :m_appleActionMove];
			[m_appleSprite setVisible:true];
			
			if ( m_TutorialState == 8 )
			{
				m_TutorialState = 9;
				m_Time = [[NSDate date] timeIntervalSince1970]*1000;
				
				if (_isRus)
					[self SetTitle:@"Îòëè÷íî!" str2: @""];
				else
                     [self SetTitle:@"Fine!" str2: @""];
				[m_Ok setVisible:true];
			}
		}
    
   
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
    
//    accelY = -accelY;
//    if (accelY < 0)
//        accelY = 0;
//        accelY =accelY - 5;
    
    //p.y -= (accelY + (MySettings.getInstance().UpDownKef - 50.0) / 25.0)
    //				* 1.0f * kef; // ï¿½ ï¿½ï¿½ï¿½ï¿½
	//	p.x -= (accelX - (MySettings.getInstance().LeftRightKef - 50.0) / 50.0)
    
    if(!init_flag2 ){
        init_flag2 =true;
        [self Init_sprite];
    }
    
    
    p.y -= (accelY) *1.0f*kef * LeftRightKef/ 25.0f;
    p.x -= (accelX) *1.5f*kef *  LeftRightKef/ 25.0f;
   
    
    if (accelY > 0.3f)
    {
        if ( m_TutorialState == 4)
        {
            m_Bool = false;
        }
        else if ( m_TutorialState == 6)
        {
            if ( m_Bool == false)
            {
                m_Time = [[NSDate date] timeIntervalSince1970]*1000;
                m_Bool = true;
            }
            else
            {
                if (([[NSDate date] timeIntervalSince1970]*1000 - m_Time) > 1000)
                {
                    m_TutorialState = 7;
                    m_Time = [[NSDate date] timeIntervalSince1970]*1000;
                    
                    if (_isRus)
                        [self SetTitle: @"Îòëè÷íî!" str2:@""];
                    else
                        [self SetTitle: @"Fine!" str2:@""];
                    
                    [m_Ok setVisible :true];
                }
            }
        }
		
    }
    else if (accelY < -0.3f)
    {
        if ( m_TutorialState == 4)
        {
            if ( m_Bool == false)
            {
                m_Time = [[NSDate date] timeIntervalSince1970]*1000;
                m_Bool = true;
            }
            else
            {
                if (([[NSDate date] timeIntervalSince1970]*1000 - m_Time) > 1000)
                {
                    m_TutorialState = 5;
                    m_Time = [[NSDate date] timeIntervalSince1970]*1000;
                    
                    if (_isRus)
                        [self SetTitle: @"Îòëè÷íî!" str2:@""];
                    else
                        [self SetTitle: @"Fine!" str2:@""];
                    
                    [m_Ok setVisible :true];
				}
            }
        }
        if ( m_TutorialState == 6)
        {
            m_Bool = false;
        }
		
    }
    else
    {
        if ( m_TutorialState == 4)
        {
            m_Bool = false;
        }
        else if ( m_TutorialState == 6)
        {
            m_Bool = false;
        }
    }
    
    if (accelX < -0.3f)
    {
        if ( m_TutorialState == 0)
        {
            m_Bool = false;
        }
        else if ( m_TutorialState == 2)
        {
            if ( m_Bool == false)
            {
                m_Time = [[NSDate date] timeIntervalSince1970]*1000;
                m_Bool = true;
            }
            else
            {
                if (([[NSDate date] timeIntervalSince1970]*1000 - m_Time) > 1000)
                {
                    m_TutorialState = 3;
                    m_Time = [[NSDate date] timeIntervalSince1970]*1000;
                    
                    if (_isRus)
                        [self SetTitle:@"Îòëè÷íî!" str2:@""];
                    else
                        [self SetTitle:@"Fine!" str2:@""];
                    [m_Ok setVisible:true];
                }
            }
        }
        
        if (m_duckStrelAction != nil)
        {
      //      if ([m_duckStrelAction isDone])
            {
                [m_duckSprite setTextureRect: [[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_move.png"] rect] rotated:[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_move.png"] rotated] untrimmedSize:[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_move.png"] rect].size];
                
                [m_duckSprite setFlipX:false];
            }
        }
        else
        {
            [m_duckSprite setTextureRect: [[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_move.png"] rect] rotated:[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_move.png"] rotated] untrimmedSize:[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_move.png"] rect].size];
            
            [m_duckSprite setFlipX:false];
            
        }
    }
    else if (accelX > 0.3f)
    {
        if ( m_TutorialState == 0)
        {
            if ( m_Bool == false)
            {
                m_Time = [[NSDate date] timeIntervalSince1970]*1000;
                m_Bool = true;
            }
            else
            {
                if (([[NSDate date] timeIntervalSince1970]*1000 - m_Time) > 1000)
                {
                    m_TutorialState = 1;
                    m_Time = [[NSDate date] timeIntervalSince1970]*1000;
                    
                    if (_isRus)
                        [self SetTitle:@"Îòëè÷íî!" str2:@""];
                    else
                        [self SetTitle:@"Fine!" str2:@""];
                    [m_Ok setVisible:true];
                }
            }
        }
        else if ( m_TutorialState == 2)
        {
            m_Bool = false;
            
        }
        //p.x += accelY*1.5f*kef;
        
        if (m_duckStrelAction != nil)
        {
           // if ([m_duckStrelAction isDone])
            {
                [m_duckSprite setTextureRect: [[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_move.png"] rect] rotated:[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_move.png"] rotated] untrimmedSize:[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_move.png"] rect].size];
                
                [m_duckSprite setFlipX:true];
                
            }
        }
        else
        {
            [m_duckSprite setTextureRect: [[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_move.png"] rect] rotated:[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_move.png"] rotated] untrimmedSize:[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_move.png"] rect].size];
            
            [m_duckSprite setFlipX:true];
        }
    }
    else if (abs(accelX) < 0.3f)
    {
        if ( m_TutorialState == 0)
        {
            m_Bool = false;
        }
        else if ( m_TutorialState == 2)
        {
            m_Bool = false;
        }
        
        //p.x += accelY*2.5f;
        if (m_duckStrelAction != nil)
        {
      //      if ([m_duckStrelAction isDone] )
                [m_duckSprite setTextureRect: [[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_stay.png"] rect] rotated:[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_stay.png"] rotated] untrimmedSize:[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_stay.png"] rect].size];
            
        }
        else
        {
            [m_duckSprite setTextureRect: [[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_stay.png"] rect] rotated:[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_stay.png"] rotated] untrimmedSize:[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_stay.png"] rect].size];
            
        }
    }
    
   
    [self SetDuckPosX :p.x PosY:p.y];
    
    
    
}



@end
