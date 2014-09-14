//
//  COrel.h
//  Duck
//
//  Created by  Anton on 9/14/14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface COrel : NSObject
{
    CCNode *m_rootNode;
    
//	private Random 	m_random;
    
	
	CCSprite *sprite;
	CCAnimate *anim_action, *anim_attack;
    
	CCMoveTo *move_action;
	Boolean b_attack, b_attack_anim;
	CCRepeatForever *repeat_action;
    
}

-(id) initWithNode : (CCNode *) rootNode;
-(void) initOrel;

-(void) Shedule;
-(void) SetInitState;
-(CGPoint) GetPos;
-(int) GetDir;
-(void) Attack :(CGPoint) duckPos;
-(void) Fire;
-(CGRect) GetRect;
@end
