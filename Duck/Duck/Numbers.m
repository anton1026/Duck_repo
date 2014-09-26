//
//  Numbers.m
//  Duck
//
//  Created by Denis A on 9/16/14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import "Numbers.h"


@implementation Numbers

-(id) init
{
  if(self = [super init])
  {
    _m_Num = -1;
    
    _sprs = [[NSMutableArray alloc]init];
    
    CCSpriteFrame *cframe = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"0.png"];
    for (int i = 0; i < 5; i++)
    {
        CCSprite *sprite = [CCSprite spriteWithSpriteFrame:cframe];
        
        [self addChild :sprite z:444];

        [sprite setPosition: CGPointMake(0, 0)];
        [_sprs addObject:sprite];
    }
    
  }
  return self;
}

-(float) SetNum :(int) num
{
   if (num == _m_Num)
        return 0;
    
    _m_Num = num;
    if (_m_Num > 99999)
        _m_Num = 0;
    
    int r1 = _m_Num / 10000;
    int r2 = (_m_Num - r1*10000) / 1000;
    int r3 = (_m_Num - r1*10000 - r2*1000) / 100;
    int r4 = (_m_Num - r1*10000 - r2*1000 - r3*100) / 10;
    int r5 = (_m_Num - r1*10000 - r2*1000 - r3*100 - r4*10);
    
    CCSpriteFrame *cframe =[[CCSpriteFrame alloc]init];
    float offs = 0.0f;
    float step = 50.0f;
    
    if (r1 != 0)
    {
        cframe = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat: @"%d.png",r1]];
        [_sprs[0] setTexture: [cframe texture]];
        [_sprs[0] setTextureRect:[cframe rect]];
        [_sprs[0] setVisible:true];
        [_sprs[0] setPosition: CGPointMake(offs,0)];
    } else
    {
        [_sprs[0] setVisible :false];
    }
    
    if (r2 != 0 || r1 != 0)
    {
        cframe = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat: @"%d.png",r2]];
        [_sprs[1] setTexture: [cframe texture]];
        [_sprs[1] setTextureRect:[cframe rect]];
        [_sprs[1] setVisible:true];
        offs = offs + [_sprs[0] textureRect].size.width/2 + [_sprs[1] textureRect].size.width/2;
        [_sprs[1] setPosition:CGPointMake(offs,0)];
    }
    else
    {
        [_sprs[1] setVisible :false];
    }
    
    if (r3 != 0 || r2 != 0 || r1 != 0)
    {
        cframe = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat: @"%d.png",r3]];
        
        [_sprs[2] setTexture: [cframe texture]];
        [_sprs[2] setTextureRect:[cframe rect]];
        [_sprs[2] setVisible:true];
        offs = offs + [_sprs[1] textureRect].size.width/2 + [_sprs[2] textureRect].size.width/2;
        [_sprs[2] setPosition: CGPointMake(offs,0)];
        
    }
    else
    {
        [_sprs[2] setVisible :false];
    }
    
    if (r4 != 0 || r3 != 0 || r2 != 0 || r1 != 0)
    {
        cframe = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat: @"%d.png",r4]];
        [_sprs[3] setTexture: [cframe texture]];
        [_sprs[3] setTextureRect:[cframe rect]];
        [_sprs[3] setVisible:true];
        offs = offs + [_sprs[2] textureRect].size.width/2 + [_sprs[3] textureRect].size.width/2;
        [_sprs[3] setPosition: CGPointMake(offs,0)];
   
    }
    else
    {
       [_sprs[2] setVisible :false];
    }
    
    cframe = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat: @"%d.png",r5]];
    [_sprs[4] setTexture: [cframe texture]];
    [_sprs[4] setTextureRect:[cframe rect]];
    [_sprs[4] setVisible:true];
    offs = offs + [_sprs[3] textureRect].size.width/2 + [_sprs[4] textureRect].size.width/2;
    [_sprs[4] setPosition: CGPointMake(offs,0)];
    
    
    return offs;
}

@end
