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
    int m_init_cnt;
}
@property (nonatomic,retain) NSMutableArray *sprites;
@property (nonatomic,retain) CCAnimate *anim_action;
@property (nonatomic,retain) NSMutableArray *move_actions;

-(id) initWithNode : (CCNode *) rootNode;
-(void) InitBirds;
-(void) Shedule;
-(void) SetInitState;
@end
