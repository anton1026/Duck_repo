//
//  SetupLayer.m
//  Duck
//
//  Created by Anton on 9/13/14.
//  Copyright (c) 2014 Anton. All rights reserved.
//
#import "Global.h"
#import "SetupLayer.h"
#import "SimpleAudioEngine.h"
#import "GameLevel.h"
#import "MenuLayer.h"

#define OriginY    384

@implementation SetupLayer{
    NSMutableArray *m_backgroundItems;
    
}

//float g_fx,g_fy,g_fx1,g_fy1;
//bool flag_retain=false;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	SetupLayer *layer = [SetupLayer node];
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
     	
        
        m_iLoadedHunter = -1;
		
        [self setTouchEnabled:true];
        [self setAccelerometerEnabled:true];

        
		m_bEnd = false;
		
		m_thumbLeftRight = [[Thumb alloc]init];
        
		m_thumbLeftRight.m_Value = 50;
        
		m_thumbUpDown = [[Thumb alloc]init];

		m_thumbUpDown.m_Value = 50;
		
		m_hunterSheet1 = nil;
		m_hunterAnimation1 = nil;
        
		m_backgrounds = [[NSMutableArray alloc]init];
		
		m_duckPos = CGPointZero;
        
		
        
        m_rootNode = [[CCNode alloc]init];
        
        [self setScaleX : g_fx];
        [self setScaleY : g_fy];
   	    [self setPosition: ccp(-(1024-size.width)/2.0f, -(768-size.height)/2.0)];
      
        [self addChild:m_rootNode];
        
        CCSpriteFrame *cframe = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_stay.png"];
     	m_duckSheet = [CCSpriteBatchNode batchNodeWithTexture:[cframe texture]]  ;
    	[m_rootNode addChild:m_duckSheet z:7];
        
        
		// create the animation
        NSMutableArray *frames = [[NSMutableArray alloc]init];
        for(int i = 1; i <19  ; i++) {
            [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"duck_strel%d.png",i]]];
        }
        m_duckStrelAnimationUp  = [CCAnimation animationWithSpriteFrames:frames delay:0.05f];
        
        for(int i = 1; i <19  ; i++) {
            [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"strelaet_pramo%d.png",i]]];
        }
        m_duckStrelAnimationVbok  = [CCAnimation animationWithSpriteFrames:frames delay:0.05f];

        
        for(int i = 1; i <4  ; i++) {
            [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"duck_dyn1_%d.png",i]]];
        }
        m_duckDyn1 = [CCAnimation animationWithSpriteFrames:frames delay:0.25f];
        
        
        for(int i = 1; i <4  ; i++) {
            [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"duck_dyn2_%d.png",i]]];
        }
        m_duckDyn2 = [CCAnimation animationWithSpriteFrames:frames delay:0.25f];
        
        for(int i = 0; i <4  ; i++) {
            [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"duck_kill1_%d.png",i % 2+1]]];
        }
        m_duckKill1 = [CCAnimation animationWithSpriteFrames:frames delay:0.15f];
        
        for(int i = 0; i <4  ; i++) {
            [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"duck_kill2_%d.png",i % 2+1]]];
        }
        m_duckKill2 = [CCAnimation animationWithSpriteFrames:frames delay:0.15f];
        
        m_duckSprite = [CCSprite spriteWithTexture: [m_duckSheet texture] rect: CGRectMake(3*119.0f, 3*113.5f, 119.0f, 113.5f)];
        [m_duckSprite setScale:g_fx1];
        [m_rootNode addChild:m_duckSprite z:5];
		[self SetDuckPosX :1024.0f*3.0f/ 2.0f PosY: 768.0f/2.0f/2.0f];

        
        cframe = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"ok.png"];
       
		m_Ok = [CCSprite spriteWithSpriteFrame:cframe ];
	//	[m_Ok setScale:g_fx1];
		[m_Ok setOpacity:160];
        [m_rootNode addChild:m_Ok z: 100];
		

        cframe = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"cancel.png"];
		m_Cancel = [CCSprite spriteWithSpriteFrame:cframe ];
	//	[m_Cancel setScale:g_fx1];
		[m_Cancel setOpacity:160];
        [m_rootNode addChild:m_Cancel z: 100];
        

        cframe = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"check.png"];
		m_Check = [CCSprite spriteWithSpriteFrame:cframe ];
     	[m_Check setScale:1.6f*g_fx1];
		[m_Check setOpacity:160];
        [m_Check setVisible:(ShowButtons==1)];
   		[m_rootNode addChild:m_Check z: 100];

        
        cframe = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"uncheck.png"];
		m_Uncheck = [CCSprite spriteWithSpriteFrame:cframe ];
		[m_Uncheck setScale:1.6f*g_fx1];
		[m_Uncheck setOpacity:160];
        [m_Uncheck setVisible:(ShowButtons==0)];
		[m_rootNode addChild:m_Uncheck z: 100];
		
				
		if (_isRus){
            
        }
			//m_lblCheck = CCLabel.makeLabel("Ïîêàçûâàòü êíîïêè ñòðåëüáû", "Arial", 36);
		else
            m_lblCheck =[CCLabelTTF labelWithString:@"Show the firing buttons"
                                          dimensions: [m_rootNode boundingBox].size
                                          hAlignment:UITextAlignmentCenter
                                       lineBreakMode:UILineBreakModeWordWrap
                                            fontName:@"Arial"
                                            fontSize:36*g_fy];
        
        [m_lblCheck setColor:ccBLACK];
		[self addChild :m_lblCheck z:401];
		[m_lblCheck setVisible:true];

        
	    
	    
        [m_rootNode addChild :m_thumbLeftRight z: 400];
  	    [m_thumbLeftRight setVisible:true];
        [m_thumbLeftRight setScale:g_fx1];
  	    [m_thumbLeftRight setPosition :ccp(WIN_SIZE_X / 2,WIN_SIZE_Y / 2)];
         
	    m_thumbLeftRight.m_Value = LeftRightKef;
        [m_thumbLeftRight update];
        
        
        
        
        [m_rootNode addChild :m_thumbUpDown z: 400];
  	    [m_thumbUpDown setVisible:true];
        [m_thumbUpDown setScale:g_fx1];
  	    [m_thumbUpDown setPosition :ccp(WIN_SIZE_X/2,WIN_SIZE_Y/ 2)];
        
	    m_thumbUpDown.m_Value = UpDownKef;
        [m_thumbUpDown update];
        [m_thumbUpDown setVisible:false];
        
        

	    
	    //m_lblLeftRight = CCLabel.makeLabel("Âëåâî   -   Âïðàâî", "Arial", 42);
		if (_isRus)
        {
        }
			//m_lblLeftRight = CCLabel.makeLabel("×óâñòâèòåëüíîñòü", "Arial", 42);
		else
            m_lblLeftRight =[CCLabelTTF labelWithString:@"Sensitivity"
                                         dimensions: [m_rootNode boundingBox].size
                                         hAlignment:UITextAlignmentCenter
                                      lineBreakMode:UILineBreakModeWordWrap
                                           fontName:@"Arial"
                                           fontSize:42*g_fy];

	    [m_lblLeftRight setColor:ccBLACK];
	    [m_rootNode addChild :m_lblLeftRight z:401];
	    [m_lblLeftRight setVisible:true];
	    
		if (_isRus)
        {
            
        }
			//m_lblUpDown = CCLabel.makeLabel("Ââåðõ   -   Âíèç", "Arial", 42);
		else
            m_lblUpDown =[CCLabelTTF labelWithString:@"Up   -   Down"
                                             dimensions: [m_rootNode boundingBox].size
                                             hAlignment:UITextAlignmentCenter
                                          lineBreakMode:UILineBreakModeWordWrap
                                               fontName:@"Arial"
                                               fontSize:42*g_fy];
        
	    [m_lblUpDown setColor:ccBLACK];
	    [m_rootNode addChild :m_lblUpDown z:401];
	    [m_lblUpDown setVisible:false];

	       
		if (_isRus)
        {
        }
		//	m_lblTitle = CCLabel.makeLabel("Íàñòðîéêè", "Arial", 100);
		else
            m_lblTitle =[CCLabelTTF labelWithString:@"Setup"
                                          dimensions:[m_rootNode boundingBox].size
                                          hAlignment:UITextAlignmentCenter
                                       lineBreakMode:UILineBreakModeWordWrap
                                            fontName:@"Arial"
                                            fontSize:80*g_fy];
        
	    [m_lblTitle setColor:ccWHITE];
	    [m_rootNode addChild :m_lblTitle z:401];
	    [m_lblTitle setVisible:true];


		m_visibleWidth = (float)WIN_SIZE_X/ g_fx;
		[self ChangeLevel:1];
        
		[self scheduleUpdate];

        
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"play.mp3"];
        
    }
	
	return self;
}
-(void) ChangeLevel:(int) level
{
    
    //m_BonusBox.sprite.setVisible( false );
    //m_BonusState = 0;
    //m_BonusTime = SystemClock.uptimeMillis() + MIN_DELAY_BONUS + random.nextInt(MIN_DELAY_BONUS);
    
    m_YMin = 90;
    m_YMax = 170;
    
    m_CurLevel = Level_Lists[0];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level1.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level1_2.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level1_3.plist"];
    [self LoadHunterData:1];
    
    [self  BuildWorld];
    
    [self SetDuckPosX:1024.0f * 3.0f / 2.0f PosY:768.0f/2.0f/2.0f];
    
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
    for(int i = 1; i <6  ; i++) {
        [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"hunt_kill%d.png",i]]];
    }
    m_huntkillAnimation  = [CCAnimation animationWithFrames:frames delay:0.15f];
    
    m_huntkillSprite = [CCSprite spriteWithSpriteFrame:    [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"hunt_kill1.png"]];
    [m_rootNode addChild :m_huntkillSprite z: 500];
    [m_huntkillSprite setVisible :false];
    
    
    ccTexParams params = {GL_LINEAR, GL_LINEAR, GL_CLAMP_TO_EDGE, GL_CLAMP_TO_EDGE};
    
    [[m_hunterSheet1 texture] setTexParameters: &params];
    
    [m_rootNode addChild :m_hunterSheet1  z:6];
    
    // create the hunters animation
    for (int y = 0; y < 2; y++) {
        for (int x = 0; x < 5; x++) {
            CCSpriteFrame *frame = [CCSpriteFrame frameWithTexture:[m_hunterSheet1 texture] rect:CGRectMake(x * 176.0f, y * 161.0f, 176.0f, 161.0f) ];
            [frames addObject: frame];
        }
    }
    m_hunterAnimation1  = [CCAnimation animationWithFrames:frames delay:0.15f];
    
    for (int x = 0; x < 5; x++) {
        
        CCSpriteFrame *frame = [CCSpriteFrame frameWithTexture:[m_hunterSheet1 texture] rect:CGRectMake(x * 176.0f, 3 * 161.0f, 176.0f, 161.0f) ];
        [frames addObject: frame];
    }
    m_hunterPulaAnimation1  = [CCAnimation animationWithFrames:frames delay:0.25f];
    
    
    
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
-(void)BuildWorld
{
    
    for (BackgroundItem *bi in m_CurLevel.m_BackgroundItems) {
        
        Background *b = [[Background alloc]init];
        
        if (bi.isSkyBox == 1) {
            b.sprite  = [CCSprite spriteWithTexture:bi.texture_name];
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

-(void) update:(ccTime)dt
{
    [m_duckSprite setPosition :ccp(m_duckPos.x,m_duckPos.y)];
    
    
    float x = 1024 / 2 - m_duckPos.x;
    float add = (m_visibleWidth - 1024) / 2;
    
    if (x > -add)
        x = -add;
    if (x < (-(1024 * 3 - (1024 + add))))
        x = -(1024 * 3 - (1024 + add));
    [m_rootNode setPosition: ccp(x, 0)];
    

    
    
    
    [m_Ok setPosition:ccp(-x+1200-add, 70)];
    [m_Cancel setPosition:ccp(-x+1050-add, 70)];
    
    
    [m_Check setPosition:ccp(-x+140-add, 260)];
    [m_Uncheck setPosition:ccp(-x+140-add, 260)];
    
    [m_lblCheck setPosition:ccp(-x+450-add, 265)];
    
    
    [m_thumbLeftRight setPosition:ccp(-x+300-add, 450)];
    [m_thumbUpDown setPosition:ccp(-x+950-add, 450)];
    
    [m_lblLeftRight setPosition:ccp(-x+300-add, 550)];
    
    [m_lblUpDown setPosition:ccp(-x+950-add, 550)];
    
    [m_lblTitle setPosition:ccp(-x+650-add, 700)];
    
    if (m_skyBox != nil)
    {
        [m_skyBox.sprite setPosition:ccp(-x+1024/2, 768 / 2)];
    }
    
    if (m_bEnd)
    {
        return;
    }
}
- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event

{
    UITouch *touch = [touches anyObject];
    CGPoint location = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    
    float x,y;
    x =location.x/g_fx;
    y =location.y/g_fy;
    
    
    if ((x > 50) && (x < 250) && y > 350)
    {
        m_thumbLeftRight.m_Value-=5;
        [m_thumbLeftRight update];
        
    }
    
    if ((x > 250) && (x < 500) && y > 350)
    {
        m_thumbLeftRight.m_Value+=5;
        [m_thumbLeftRight update];
        
    }
    
    if ((x > 500) && (x < 750) && y > 350)
    {
        m_thumbLeftRight.m_Value-=5;
        [m_thumbLeftRight update];
        
    }
    
    if ((x > 750) && (x < 950) && y > 350)
    {
        m_thumbLeftRight.m_Value+=5;
        [m_thumbLeftRight update];

        
    }
    // check/uncheck
    if ((x > 50) && (x < 500) && y < 330 && y > 170)
    {
        if ( [m_Check visible] )
        {
            [m_Check setVisible:false];
            [m_Uncheck setVisible:true];
        }
        else
        {
            [m_Check setVisible:true];
            [m_Uncheck setVisible:false];
        }
        
    }
    
    if ((x > 870) && (x < 1050) && y > 0 && y < 150)
    {
        LeftRightKef = m_thumbLeftRight.m_Value;
        UpDownKef = m_thumbUpDown.m_Value;
        
//        DuckActivity.prefs.edit().putInt("LeftRightKef", MySettings.getInstance().LeftRightKef).commit();
//        DuckActivity.prefs.edit().putInt("UpDownKef", MySettings.getInstance().UpDownKef).commit();
        
        if ( [m_Check  visible] )
        {
            //DuckActivity.prefs.edit().putInt("ShowButtons", 1).commit();
            ShowButtons = 1;
        }
        else
        {
           // DuckActivity.prefs.edit().putInt("ShowButtons", 0).commit();
            ShowButtons = 0;
        }
        
        
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionShrinkGrow transitionWithDuration:0.5 scene:MenuLayer.scene]];
        
    }
    if ((x > 750) && (x < 870) && y > 0 && y < 150)
    {
        
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionShrinkGrow transitionWithDuration:0.5 scene:MenuLayer.scene]];
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
    
    accelY = -accelY;
    if (accelY < 0)
        accelY = 0;
    accelY =accelY - 5;
    
    
    CGPoint p = m_duckPos;
    
    p.y -= (accelY) *1.0f*kef * m_thumbLeftRight.m_Value/ 25.0f;
    p.x -= (accelX) *1.5f*kef *  m_thumbLeftRight.m_Value/ 25.0f;
   //	else
    //	return;
    
    // change duck position
    
   //	p.y -= accelX*1.5f; // ï¿½ ï¿½ï¿½ï¿½ï¿½
    
   
    //p.y -= (accelY + (MySettings.getInstance().UpDownKef - 50.0) / 25.0)
    //				* 1.0f * kef; // ï¿½ ï¿½ï¿½ï¿½ï¿½
	//	p.x -= (accelX - (MySettings.getInstance().LeftRightKef - 50.0) / 50.0)
    //		* 1.5f * kef;
    
    if (accelX < -0.3f)
    {
        if (m_duckStrelAction != nil)
        {
            if ([m_duckStrelAction isDone])
            {
                [m_duckSprite setTextureRect:[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_move.png"] rect] rotated:[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_move.png"] rotated] untrimmedSize:[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_move.png"] rect].size];
                // m_duckSprite.setTextureRect(CGRect.make(4*119.0f,
                // 3*113.5f, 119.0f, 113.5f), false);
                [m_duckSprite setFlipX :false];

            }
        }
        else
        {
            [m_duckSprite setTextureRect:[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_move.png"] rect] rotated:[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_move.png"] rotated] untrimmedSize:[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_move.png"] rect].size];
            // m_duckSprite.setTextureRect(CGRect.make(4*119.0f,
            // 3*113.5f, 119.0f, 113.5f), false);
            [m_duckSprite setFlipX :false];
        }
    }
    else if (accelX > 0.3f)
    {
        //p.x += accelY*1.5f*kef;
        if (m_duckStrelAction != nil)
        {
            if ([m_duckStrelAction isDone])
            {
                [m_duckSprite setTextureRect:[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_move.png"] rect] rotated:[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_move.png"] rotated] untrimmedSize:[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_move.png"] rect].size];
                // m_duckSprite.setTextureRect(CGRect.make(4*119.0f,
                // 3*113.5f, 119.0f, 113.5f), false);
                [m_duckSprite setFlipX :true];

                
            }
        }
        else
        {
            [m_duckSprite setTextureRect:[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_move.png"] rect] rotated:[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_move.png"] rotated] untrimmedSize:[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_move.png"] rect].size];
            // m_duckSprite.setTextureRect(CGRect.make(4*119.0f,
            // 3*113.5f, 119.0f, 113.5f), false);
            [m_duckSprite setFlipX :true];
            
        }
    }
    else if (abs(accelX) < 0.3f)
    {
        //p.x += accelY*2.5f;
        if (m_duckStrelAction != nil)
        {
            if ([m_duckStrelAction isDone])
                [m_duckSprite setTextureRect:[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_stay.png"] rect] rotated:[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_stay.png"] rotated] untrimmedSize:[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_stay.png"] rect].size];
            
                 //m_duckSprite.setTextureRect(CGRect.make(3*119.0f, 3*113.5f, 119.0f, 113.5f), false);
        }
        else
        {
            [m_duckSprite setTextureRect:[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_stay.png"] rect] rotated:[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_stay.png"] rotated] untrimmedSize:[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_stay.png"] rect].size];
            //m_duckSprite.setTextureRect(CGRect.make(3*119.0f, 3*113.5f, 119.0f, 113.5f), false);
        }
    }

    
    
    
    
    
    [self SetDuckPosX :p.x PosY:p.y];
    
    
}



@end
