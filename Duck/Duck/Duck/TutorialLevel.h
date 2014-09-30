//
//  TutorialLevel.h
//  Duck
//
//  Created by Anton on 9/13/14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import "cocos2d.h"
#import "GameLevel.h"
#import "Global.h"
@interface TutorialLevel : CCLayer
{
    
    //GameWorld m_gameWorld;
     Boolean init_flag;
	 Boolean init_flag1;
     Boolean init_flag2;
    
	CCNode *m_rootNode;
	float m_visibleWidth;
    
	CCSpriteBatchNode  *m_duckSheet;
    
    CCAnimation  *m_duckStrelAnimationUp,  *m_duckStrelAnimationVbok;
	CCAnimation  *m_duckDyn1,  *m_duckDyn2;
	CCAnimation  *m_duckKill1,  *m_duckKill2;
    
	CGPoint m_duckPos;
	CCSprite *m_duckSprite;
	
	
    CCSprite *m_huntkillSprite;
	CCAnimation *m_huntkillAnimation;
	
    CCSpriteBatchNode *m_hunterSheet1;
    
    CCAnimation *m_hunterAnimation1;
    CCAnimation *m_hunterPulaAnimation1;
    
  	NSMutableArray *m_backgrounds;
	Background *m_skyBox;
	
 	GameLevel  *m_CurLevel;
    
	CCAnimate *m_duckStrelAction;
	CCAnimate *m_duckStrelActionUp;
	CCAnimate *m_duckStrelActionVbok;
    
    CCAction *m_appleActionAnim;
    CCMoveTo *m_appleActionMove;
    
    CCSpriteBatchNode *m_appleSheet;
    
    CCSprite *m_appleSprite;
	CCAnimation *m_appleAnimation;
    
    CCSprite *m_yellowSprite;
    
	int m_YMin, m_YMax;
	
	Boolean m_bEnd;
	
	CCSprite	*m_hunterHead;
	
	CCLabelTTF	*m_lblTitle, *m_lblTitle2;
	CCLabelTTF	*m_lblTitleSh, *m_lblTitle2Sh;
    
	Boolean m_bTitle1Changed,	m_bTitle2Changed;
	NSString  *m_Title1Str, *m_Title2Str;
	
    
    CCSprite *m_Ok;
    CCSprite *m_Cancel;
	
    CCSprite *m_shootSprite;
    
	int 	m_TutorialState;
	Boolean m_Bool;
	long long   m_Time;
	
	int     m_whereShoot;
	long long	m_shootTime;
	
	int m_iLoadedHunter;
	int m_cmd;
 	CCLabelTTF *m_labelWait;
    
    float screenVec[3];
    float canVec[3];

    long long lastTicks;
    
}

//@property(nonatomic,retain) GameLayer *m_layer;

+(CCScene *) scene;

-(void) UpdateTitles;
-(void) SetTitle: (NSString*)str1 str2:(NSString*)str2;
-(void) ChangeLevel:(int) level;
-(void) SetDuckPosX :(float) x PosY:(float) y;
-(void) canonicalOrientationToScreenOrientation:(int) displayRotation;
-(void) UpdateTitles;
@end
