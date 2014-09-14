//
//  CBirds.h
//  Duck
//
//  Created by Anton on 9/14/14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@interface CBirds : NSObject
{
    CCNode *m_rootNode;
//	 Random 	m_random;
	int m_init_cnt;
    
	NSMutableArray *sprites;

	CCAnimate *anim_action;
	NSMutableArray *move_actions;

}

-(id) initWithNode : (CCNode *) rootNode;
-(void) InitBirds;
-(void) Shedule;
-(void) SetInitState;
@end
