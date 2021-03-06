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
    
	Boolean _isActionEnd;
    Boolean _isAtackEnd;
	CCRepeatForever *repeat_action;
    CCAnimation *OrelAnimation;
    CCAnimation *AttackAnimation;
    
}
@property (nonatomic, retain) CCSprite *sprite;
@property (nonatomic, retain) CCAnimate *anim_action, *anim_attack;
@property (nonatomic, retain) CCMoveTo *move_action;
@property  Boolean b_attack, b_attack_anim;


-(id) initWithNode : (CCNode *) rootNode;
-(void) initOrel;

-(void) Shedule;
-(void) SetInitState;
-(CGPoint) GetPos;
-(int) GetDir;
-(void) Attack :(CGPoint) duckPos;
-(void) Fire;
-(CGRect) GetRect;
-(void)targetMoveFinished;
-(void) targetAttackFinished;

@end
