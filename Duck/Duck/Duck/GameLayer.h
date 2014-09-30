//
//  GameLayer.h
//  Duck
//
//  Created by Anton on 9/14/14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import "cocos2d.h"

//#import "GameWorld.h"

#import "GameLevel.h"
#import "CBirds.h"
#import "COrel.h"
#import "Numbers.h"
#import "Global.h"



//----------------------------------------------------------------//

@interface GameLayer : CCLayer<UIAccelerometerDelegate>
{
    
  
   
	//GameWorld *m_gameWorld;
    
    
    Boolean bPaused;
  	CCNode *m_rootNode;
	float m_visibleWidth;
    
	CCSpriteBatchNode *m_duckSheet;
  
    
	CCAnimation *m_duckStrelAnimationUp, *m_duckStrelAnimationVbok;
	CCAnimation *m_duckStrelAnimationUpFast, *m_duckStrelAnimationVbokFast;
	CCAnimation *m_duckDyn1, *m_duckDyn2;
    
	CCAnimation *m_duckKill1, *m_duckKill2;
	CCAnimate *m_duckKill1Action, *m_duckKill2Action;
    
	CCAnimation *m_flowerAnim;
    
	CGPoint m_duckPos;
    
	CCSprite *m_duckSprite;
    
	CCSprite *m_cancelSprite;
	CCSprite *m_pauseSprite;
    
	int m_duckLives;
	CCSprite *m_duckLiveHead;
	Numbers  *m_duckLivesSprite;
    
	CCSprite *m_duckheadSprite;
	CCAction *m_duckheadAction;
    
	CCSprite *m_bonusheadSprite;
	CCAction *m_bonusheadAction;
    
    CCSprite *m_huntkillSprite;
	CCAnimation *m_huntkillAnimation;
	CCAnimate *m_huntkillAction;
    
    CCAnimate *hunterAction;

    
	CCSpriteBatchNode *m_hunterSheet1;

  	CCAnimation *m_hunterAnimation1;
	CCAnimation *m_hunterPulaAnimation1;
    
    
    CCAnimation *m_appleAnimation;
    
	NSMutableArray *m_apples;
    NSMutableArray *m_bombs;
    
    NSMutableArray *m_bonuses;
    NSMutableArray *m_freeInd;
    
	long long startgametime;
    long long m_BonusTime, m_BombaTime;
	long long m_LiveTime;
	
    NSMutableArray *m_hunters;
    NSMutableArray *m_backgrounds;
    NSMutableArray *m_flowers;
    
	Background *m_skyBox;
    
    GameLevel *m_CurLevel;
    
	CCAnimate *m_duckStrelAction;
	CCAnimate *m_duckStrelActionUp;
	CCAnimate *m_duckStrelActionVbok;
	CCAnimate *m_duckStrelActionUpFast;
	CCAnimate *m_duckStrelActionVbokFast;
    
//   	CCAction *m_duckStrelAction;
//   	CCAction *m_duckStrelActionUp;
//   	CCAction *m_duckStrelActionVbok;
//   	CCAction *m_duckStrelActionUpFast;
//   	CCAnimate *m_duckStrelActionVbokFast;
    
	CCSpriteBatchNode *m_BackgroundSprites;
  
    
    
    
	CBirds *m_Birds;
    COrel *m_Orel;
    
	int m_YMin, m_YMax;
    
	Boolean m_bEnd;
    
    Numbers *m_numHuntersSprite;
	CCSprite *m_hunterHead;
	CCSprite *m_bonusIcon;
    
	CCSprite *m_shootSprite, *m_shootSprite2;
	CCLabelTTF *m_shootLabel, *m_shootLabel2;
    
	int m_iLoadedLevel;
	int m_iLoadedHunter;
    
	int m_cmd;
    
	CCLabelTTF *m_labelWait;
    
	long long m_OrelWaitAttack;
    
	int m_iAttack; // 0 - basic, 1 - multiattack, 2 - fastattack, 3 -
    // powerattack
	long long m_AttackTime;
    
	int m_NumberHunters;
	
    
    float screenVec[3];
    float canVec[3];
    
    CGRect rcDuckStay, rcDuckMove;
    Boolean rotatedDuckStay, rotatedDuckMove;
    
    long long lastTicks;

    Boolean _isduckActionEnd;
    
    Boolean  _isPulaActionDone;
    Boolean _isHunterActionDone;
    Boolean _isStrelbaActionDone;
    Boolean _isBonusActionDone;
    Boolean _isBonusLiveActionDone;
    Boolean _ishunterkillActionDone;
    CCAnimate *bonusaction;
    CCAnimate *bonusLiveaction;
}
+(CCScene *) scene;
+(GameLayer*) getInstance;
//-(id) initWithLevel :(int) level_ind;

-(void) ChangeLevel:(int) level;
-(void) BuildWorld;
-(void) LoadHunterData :(int) type;


-(void) updateApples :(float)dt;
-(void) updateBombs :(float) dt;
-(void) updateBonuses :(float)dt;
-(void) updateFlowers :(float)dt;
-(void) updateHunters :(float)dt offx:(float) offx_s;

-(void) canonicalOrientationToScreenOrientation:(int) displayRotation;
-(void) SetDuckPosX :(float) x PosY:(float) y;
-(void) targetMoveFinished;
-(void) targetPulaActionFinished;
-(void) targetHunterActionFinished;
-(void) targetStrelbaActionFinished;
-(void) targetBonusFinished;
-(void) targetBonusLiveFinished;
-(void)targetHuntKillActionFinished;
@end
