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

#define  HUNTER_HEIGHT  162;
#define  HUNTER_SPEED   100;
#define  MIN_INTERVAL_STAY  7000;
#define  MAX_DELAY_STAY     7000;
#define  OriginX  512;
#define  OriginY  384;
#define  SkyScaleX  3;
#define  SkyScaleY  1;


@interface Pula : NSObject
  @property(nonatomic, retain) CCMoveTo *pula_action;
  @property (nonatomic,retain)  CCSprite *pulaSprite;
@end
@implementation Pula
@end


@interface Hunter : NSObject

//@property HunterItem *hi;
@property (nonatomic,retain)CCMoveTo *move_action;
@property (nonatomic,retain)CCSprite *sprite;
@property (nonatomic,retain)CCRepeatForever *repeat;
@property (nonatomic,retain)CCAnimate *strelba_action;
@property int state;
@property int lives;
@property long timetostay;
@property long timetomove;

@property long timetopula;
@property long killedtime;
@property NSMutableArray *m_pules;
@property (nonatomic,retain)CCSprite *spriteApple;
@property (nonatomic,retain)CCSprite *numLives;

-(void) SetLives:(int) l;
@end

@implementation Hunter

-(void) SetLives:(int) l
{
    _lives = l;
    if (_numLives != nil) {
        CCSpriteFrame *cframe;
        
        cframe = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"%d.png",_lives]];
        
        
        [_numLives setTexture :[cframe texture] ];
        [_numLives setTextureRect :[cframe rect]];

        
    }
    
}
-(id) init
{
    if(self =[super init]){
        _m_pules =[[NSMutableArray alloc]init];
        _numLives =nil;
    }
    return  self;
}

@end


@interface Background : NSObject
  @property (nonatomic,retain)CCSprite *sprite;
@end


@interface BombType : NSObject
  @property (nonatomic,retain)CCSprite *sprite;
  @property (nonatomic,retain)CCAnimate *action;
@end
@implementation BombType
-(id)init
{
    if(self =[super init]){
        _sprite =nil;
        _action =nil;
    }
    return self;
}

@end


@interface Bomb : NSObject

  @property (nonatomic,retain) BombType  *bombtype1;
  @property (nonatomic,retain) BombType  *bombtype2;
  @property int type;
  @property int m_BombaState;

  -(id)initWithNode :(CCNode*) rootNode;
@end


@implementation Bomb
-(id)initWithNode :(CCNode*) rootNode
{
    if(self = [super init]){
        
        _type =0;
        _m_BombaState =0;
        _bombtype1 = [[BombType alloc] init];
        _bombtype2 = [[BombType alloc] init];
        
        CCSpriteFrame *cframe =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"bomb1.png"];
        _bombtype1.sprite = [CCSprite spriteWithSpriteFrame:cframe];
        
        NSMutableArray *frames = [[NSMutableArray alloc]init];
        for(int i = 1; i <5  ; i++) {
            if(i==1)
                [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"bomb.png",i]]];
            else
               [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"bomb%d.png",i]]];
        }
        
        CCAnimation *BombaAnimation = [CCAnimation animationWithFrames:frames delay:0.1f];
        
//        _bombtype1.sprite addAnimation(BombaAnimation);
        _bombtype1.action = [CCAnimate actionWithAnimation:BombaAnimation];
        
        [rootNode addChild: _bombtype1.sprite z:5];
        
        [_bombtype1.sprite setVisible:false];
        [_bombtype1.sprite setScale:0.7f];
        
        
        cframe =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"tnt1.png"];
        _bombtype2.sprite = [CCSprite spriteWithSpriteFrame:cframe];
        

        for(int i = 2; i <4  ; i++) {
                [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"tnt%d.png",i]]];
        }
        BombaAnimation = [CCAnimation animationWithFrames:frames delay:0.1f];

        
//        _bombtype2.sprite addAnimation(BombaAnimation);
        
        _bombtype2.action = [CCAnimate actionWithAnimation:BombaAnimation];
        [rootNode addChild : _bombtype2.sprite z: 5];
        [_bombtype2.sprite setVisible :false];
        [_bombtype2.sprite setScale :0.7f];
        
    }
    return self;
}
@end

@interface  BonusBoxLive : NSObject

@property(nonatomic,retain) CCSprite  *sprite;
@property(nonatomic,retain) CCAnimate *action;
-(id) initWithNode :(CCNode *)rootNode zorder:(int) zi;

@end

@implementation BonusBoxLive
-(id) initWithNode :(CCNode *)rootNode zorder:(int) zi
{
 if(self=[super init]){
    CCSpriteFrame *cframe =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"box1.png"];
    _sprite = [CCSprite spriteWithSpriteFrame:cframe];
    
    NSMutableArray *frames = [[NSMutableArray alloc]init];
    for(int i = 2; i <4  ; i++) {
        [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"box%d.png",i]]];
    }
    CCAnimation *BonusAnimation = [CCAnimation animationWithFrames:frames delay:0.1f];

//    _sprite addAnimation(BonusAnimation);
    
    _action = [CCAnimate actionWithAnimation:BonusAnimation];
    [rootNode addChild :_sprite z: zi];
    [_sprite setVisible:false];
  }
    return self;
}

@end

@interface BonusBoxShoot : NSObject

@property(nonatomic,retain) CCSprite  *sprite;
@property(nonatomic,retain) CCAnimate *action;
-(id) initWithNode :(CCNode *)rootNode zorder:(int) zi;
@end

@implementation  BonusBoxShoot
-(id) initWithNode :(CCNode *)rootNode zorder:(int) zi
{
  if(self =[super init]){
    CCSpriteFrame *cframe =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"bonus1.png"];
    _sprite = [CCSprite spriteWithSpriteFrame:cframe];
    
    NSMutableArray *frames = [[NSMutableArray alloc]init];
    for(int i = 2; i <4  ; i++) {
        [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"bonus%d.png",i]]];
    }
    CCAnimation *BonusAnimation = [CCAnimation animationWithFrames:frames delay:0.1f];
    
    //    _sprite addAnimation(BonusAnimation);
    
    _action = [CCAnimate actionWithAnimation:BonusAnimation];
    [rootNode addChild :_sprite z: zi];
    [_sprite setVisible:false];
  }
    return self;
}

@end

@interface BonusBox  : NSObject

@property (nonatomic,retain) BonusBoxLive *bonus_live;
@property (nonatomic,retain) BonusBoxShoot *bonus_shoot;
@property int m_type;
@property int m_BonusState;
-(id) initWithNode :(CCNode *)rootNode zorder:(int) zi;
@end

@implementation BonusBox

-(id) initWithNode :(CCNode *)rootNode zorder:(int) zi
{
    _bonus_live =  [[BonusBoxLive alloc]init];
    _bonus_shoot = [[BonusBoxShoot alloc]init];
    [_bonus_live initWithNode:rootNode zorder:zi];
    [_bonus_shoot initWithNode:rootNode zorder:zi];
    _m_type =0;
    _m_BonusState =0;
}

@end

@interface Flower : NSObject

@property(nonatomic,retain) CCSprite  *sprite;
@property(nonatomic,retain) CCAnimate *action;

@end
@implementation Flower

-(id)init
{
    if(self =[super init]){
        _sprite =nil;
        _action =nil;
    }
}

@end


@interface Apple_Object: NSObject
{
    
}
@property (nonatomic,retain) CCSprite *m_appleSprite;
@property (nonatomic,retain) CCAction *m_appleActionAnim;
@property (nonatomic,retain) CCMoveTo *m_appleActionMove;

@end

@implementation Apple_Object{
    
}
-(id) init
{
    if(self =[super init]){
        self.m_appleSprite =nil;
        self.m_appleActionAnim =nil;
        self.m_appleActionMove =nil;

    }
    return self;

}
@end

@interface FreeInd :NSObject
@property int m_ind;
@end
@implementation FreeInd
@end






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

-(id) initWithLevel :(int) level_ind
{
	if( (self=[super init])) {
        
        m_gameLayer =self;
        
        [self setTouchEnabled:true];
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
        
	//	m_hunterSheet1 = nil;
		m_hunterAnimation1 = nil;
        
		m_bombs = [[NSMutableArray alloc] init];
  		m_hunters =[[NSMutableArray alloc]init];
        
		m_backgrounds =[[NSMutableArray alloc]init];
		m_flowers = [[NSMutableArray alloc]init];
		m_apples = [[NSMutableArray alloc]init];
		m_bonuses = [[NSMutableArray alloc]init];
		m_freeInd = [[NSMutableArray alloc]init];
        
        
        m_rootNode = [[CCNode alloc]init];
        
        [self setScale: g_fx*g_fy];
        [self setPosition: ccp(-(1024 - size.width) / 2.0f
                              * g_fx, -(768 - size.height) / 2.0f* g_fy)];
  	    [self addChild:m_rootNode];
        
        CCSpriteFrame *cframe = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_stay.png"];
//---------------------------------------------------------------------------------------
        
     	m_duckSheet = [CCSprite spriteWithTexture: [cframe texture]]  ;
		[m_rootNode addChild:m_duckSheet z:7];
        

        

		// save parameters needed for ccAccelerometrChange
        
		rcDuckStay = [[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_stay.png"] rect];
        
        
		rcDuckMove = [[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_move.png"] rect];
        

        rotatedDuckStay = [[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_stay.png"] rotated];
        
        rotatedDuckMove = [[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_move.png"] rotated];
        


		// create the animation
        
 		//m_duckStrelAnimationUp = [[CCAnimation  alloc] init];
        NSMutableArray *frames = [[NSMutableArray alloc]init];
        for(int i = 1; i <19  ; i++) {
            [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"duck_strel%d.png",i]]];
        }
        m_duckStrelAnimationUp  = [CCAnimation animationWithFrames:frames delay:0.05f];
        
        m_duckStrelAnimationUpFast  = [CCAnimation animationWithFrames:frames delay:0.025f];
        
        
        for(int i = 1; i <19  ; i++) {
            [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"strelaet_pramo%d.png",i]]];
        }
        m_duckStrelAnimationVbok  = [CCAnimation animationWithFrames:frames delay:0.05f];
        
        m_duckStrelAnimationVbokFast  = [CCAnimation animationWithFrames:frames delay:0.025f];
		
        
		m_duckStrelActionUp = [CCAnimate actionWithAnimation: m_duckStrelAnimationUp];
		m_duckStrelActionVbok =[CCAnimate actionWithAnimation:m_duckStrelAnimationVbok];
        
        
		m_duckStrelActionUpFast =[CCAnimate actionWithAnimation:m_duckStrelAnimationUpFast];
        m_duckStrelActionVbokFast = [CCAnimate actionWithAnimation:m_duckStrelAnimationVbokFast];
       
        
        for(int i = 1; i <4  ; i++) {
            [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"duck_dyn1_%d.png",i]]];
        }
        m_duckDyn1 = [CCAnimation animationWithFrames:frames delay:0.25f];

        
        for(int i = 1; i <4  ; i++) {
            [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"duck_dyn2_%d.png",i]]];
        }
        m_duckDyn2 = [CCAnimation animationWithFrames:frames delay:0.25f];

        for(int i = 0; i <4  ; i++) {
            [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"duck_kill1_%d.png",i % 2]]];
        }
        m_duckKill1 = [CCAnimation animationWithFrames:frames delay:0.15f];

        for(int i = 0; i <4  ; i++) {
            [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"duck_kill2_%d.png",i % 2]]];
        }
        m_duckKill2 = [CCAnimation animationWithFrames:frames delay:0.15f];

        
        
        
		// create duck lives sprites
        cframe =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_head.png"];
        
		m_duckLiveHead =[CCSprite spriteWithSpriteFrame:cframe];
		[m_rootNode addChild:m_duckLiveHead z: 100];
        
		m_duckLives = 9;
//		m_duckLivesSprite = new Numbers();
//		[m_rootNode addChild: m_duckLivesSprite z: 10];
        
//		m_duckLivesSprite.setScale(0.7f);
//		m_duckLivesSprite.SetNum(m_duckLives);
//		m_duckLivesSprite.setVisible(true);
        
//		m_numHuntersSprite = new Numbers();
//		m_rootNode.addChild(m_numHuntersSprite, 10);
//		m_numHuntersSprite.setScale(0.7f);
//		m_numHuntersSprite.setVisible(true);
        
		// create flower animation
        
        for(int i = 1; i <10  ; i++) {
            [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"ss_00%d.png",i]]];
        }
        m_flowerAnim = [CCAnimation animationWithFrames:frames delay:0.1f];
        
        
		// create duck head sprite for popup
        cframe =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"duck_head.png"];
        
	 	m_duckheadSprite = [CCSprite spriteWithSpriteFrame:cframe];
		[m_rootNode addChild :m_duckheadSprite z:500];
     	[m_duckheadSprite setVisible :false];
        
		// create bonus head sprite for popup
        
        cframe =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"bonus4.png"];
    	m_bonusheadSprite = [CCSprite spriteWithSpriteFrame:cframe];
		[m_bonusheadSprite setScale :0.8f];
        
		[m_rootNode addChild :m_bonusheadSprite z:500];
 		[m_bonusheadSprite setVisible:false];
        
		// apple sheet
        cframe =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"apple1.png"];
        
		// m_appleSheet = CCSpriteSheet.spriteSheet(cframe.getTexture());
		// m_rootNode.addChild(m_appleSheet, 7);
        
		// create the animation
        
        for(int i = 2; i <6  ; i++) {
            [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"apple%d.png",i]]];
        }
        m_appleAnimation = [CCAnimation animationWithFrames:frames delay:0.1f];

        
        cframe =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"apple1.png"];
        
		for (Apple_Object *apple in m_apples)
        {

			apple.m_appleActionAnim = [CCAnimate actionWithAnimation:m_appleAnimation];
            
		    [apple.m_appleActionAnim setTag :0];
            
			apple.m_appleActionMove = [CCMoveTo actionWithDuration:2.0f position:ccp(1.0f, 1.0f)];
            [apple.m_appleActionMove setTag:0];
            
			apple.m_appleSprite = [CCSprite spriteWithSpriteFrame:cframe];
            
			
			[m_rootNode addChild:apple.m_appleSprite z:7];
    		[apple.m_appleSprite setVisible:false];
		}
        
        cframe =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"shoot1.png"];
        
		m_shootSprite = [CCSprite spriteWithSpriteFrame: cframe];
		if ( density > 1.1 )
			[m_shootSprite setScale:2] ;
		else
			[m_shootSprite setScale:1.5f];
        
		[m_shootSprite setOpacity:160];
		[m_rootNode addChild :m_shootSprite z:135];
		[m_shootSprite setVisible: (ShowButtons == 1)];
        
		m_shootSprite2 = [CCSprite spriteWithSpriteFrame:cframe];
		if ( density > 1.1 )
			[m_shootSprite2 setScale:2];
		else
			[m_shootSprite2 setScale:1.5f];
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
        
		m_duckSprite = [CCSprite spriteWithTexture: [m_duckSheet texture] rect:                                    CGRectMake(3 * 119.0f, 3 * 113.5f, 119.0f, 113.5f)];
        
        [m_duckSheet addChild :m_duckSprite z: 5];
        
//		[self SetDuckPos(1024.0f * 3.0f / 2.0f, 768.0f / 2.0f / 2.0f);
        
		// init birds
		[m_Birds InitBirds];
		[m_Orel initOrel];
        
        cframe =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"menu.png"];
        
		m_cancelSprite = [CCSprite spriteWithSpriteFrame:cframe];
        
		[m_rootNode addChild :m_cancelSprite z: 100];
		[m_cancelSprite setScale :0.4f];
        [m_cancelSprite setOpacity :180];
        
        cframe =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"pause.png"];
      	m_pauseSprite = [CCSprite spriteWithSpriteFrame:cframe];
        
		[m_rootNode addChild:m_pauseSprite z: 100];
		[m_pauseSprite setScale :0.4f];
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

			//m_labelWait = CCLabel.makeLabel("Please Wait...", "Arial", 64);
		
		[m_labelWait setPosition :ccp(1024 / 2 + 20, 768 / 2 + 70)];
		[self addChild :m_labelWait z:200];
		[m_labelWait setVisible:false];
        
 	    cframe =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"bonus4.png"];
        m_bonusIcon = [CCSprite spriteWithSpriteFrame:cframe];
		[m_rootNode addChild :m_bonusIcon z: 100];
		[m_bonusIcon setScale :0.7f];
		[m_bonusIcon setOpacity :200];
		[m_bonusIcon setVisible :false];
        
        
		m_visibleWidth = (float) size.width/g_fx;
        

	    [self ChangeLevel:level_ind];
        
		      
		
//		m_numHuntersSprite.SetNum(m_NumberHunters);
        
        
        [self scheduleUpdate];
        [self setTouchEnabled:true];
        [self setAccelerometerEnabled:true];
    }
	
	return self;
}

-(void) ChangeLevel:(int) level
{
    
}


@end
