//
//  Hunter.h
//  Duck
//
//  Created by Denis A on 9/17/14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "HunterItem.h"
@interface Hunter : NSObject

@property (nonatomic,retain) HunterItem *hi;
@property (nonatomic,retain) CCMoveTo *move_action;
@property (nonatomic,retain) CCMoveTo *pula_action;

@property (nonatomic,retain) CCSprite *sprite;
@property (nonatomic,retain)  CCSprite *pulaSprite;

@property (nonatomic,retain) CCRepeatForever *repeat;
@property (nonatomic,retain) CCAnimate *strelba_action;
@property int state;
@property int lives;
@property long long timetostay;
@property long long timetomove;

@property long long timetopula;
@property long long  killedtime;
@property (nonatomic,retain) NSMutableArray *m_pules;
@property (nonatomic,retain) CCSprite *spriteApple;
@property (nonatomic,retain) CCSprite *numLives;

-(void) SetLives:(int) l;
@end
