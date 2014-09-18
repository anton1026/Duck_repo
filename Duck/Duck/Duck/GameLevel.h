//
//  GameLevel.h
//  Duck
//
//  Created by Anton on 9/14/14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import "cocos2d.h"
#import "GDataXMLNode.h"
#import "Global.h"

@interface GameLevel : CCLayer
{

}
@property  (nonatomic, retain) NSMutableArray *m_BackgroundItems;
@property  (nonatomic, retain) NSMutableArray *m_HunterItems;
@property  (nonatomic, retain) NSMutableArray * m_BonusItems;
@property  (nonatomic, retain) NSMutableArray *m_FlowersItems;
@property  (nonatomic, retain) Background *m_SkyBox;
@property  (nonatomic, retain) NSString *m_Descr;
@property int m_NumberHunters;
@property int m_HunterLives;
@property int m_HunterPulaCnt;   // 1 or 2

@property int m_MaxBombs;
@property int m_MinDelayBomb;
@property int m_MaxAddDelayBomb;

@property int m_PulaSpeed;

@property int m_MaxBonus;
@property int m_MinDelayBonus;
@property int m_MaxAddDelayBonus;

@property int m_MaxLives;
@property int m_MinDelayLives;
@property int m_MaxAddDelayLives;

+(CCScene *) scene;
-(id) initWithXMLFile :(NSString*) xml_file Src:(NSString*) descr;
-(void) LoadFromXML :(NSString*) xml_file;

-(void) LoadBackground :(GDataXMLElement*) backgrounditem;
-(void) LoadHunters :(GDataXMLElement*) backgrounditem;
-(void) LoadBonus  :(GDataXMLElement*) backgrounditem;
-(void) LoadFlower :(GDataXMLElement*) backgrounditem;
@end
