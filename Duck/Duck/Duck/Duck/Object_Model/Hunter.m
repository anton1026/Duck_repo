//
//  Hunter.m
//  Duck
//
//  Created by Denis A on 9/17/14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import "Hunter.h"

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
