//
//  BonusBox.m
//  Duck
//
//  Created by Denis A on 9/17/14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import "BonusBox.h"

@implementation BonusBox

-(id) initWithNode :(CCNode *)rootNode zorder:(int) zi
{
    if(self =[super init])
    {
        _bonus_live =  [[BonusBoxLive alloc]init];
        _bonus_shoot = [[BonusBoxShoot alloc]init];
        [_bonus_live initWithNode:rootNode zorder:zi];
        [_bonus_shoot initWithNode:rootNode zorder:zi];
        _m_type =0;
        _m_BonusState =0;
    }
    return self;
}

@end
