//
//  COrel.m
//  Duck
//
//  Created by Anton on 9/14/14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import "COrel.h"

@implementation COrel
{
    
}
-(id) initWithNode : (CCNode *) rootNode
{
    m_rootNode =rootNode;

//    m_random = random;
    
    _anim_action = nil;
    _b_attack = false;
    _b_attack_anim = false;
}
-(void) initOrel
{
    
    CCAnimation *OrelAnimation =[[CCAnimation alloc]init];
    
    CCSpriteFrame *frame =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"pt_000.png"];
    
    [OrelAnimation  addSpriteFrame:frame];
    
    frame =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"pt_001.png"];
    [OrelAnimation  addSpriteFrame:frame];
    
    frame =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"pt_002.png"];
    [OrelAnimation  addSpriteFrame:frame];
    
    frame =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"pt_003.png"];
    [OrelAnimation  addSpriteFrame:frame];
    
    frame =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"pt_004.png"];
    [OrelAnimation  addSpriteFrame:frame];
    
    frame =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"pt_005.png"];
    [OrelAnimation  addSpriteFrame:frame];
    
    frame =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"pt_006.png"];
    [OrelAnimation  addSpriteFrame:frame];
    
    frame =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"pt_007.png"];
    [OrelAnimation  addSpriteFrame:frame];
    
    frame =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"pt_008.png"];
    [OrelAnimation  addSpriteFrame:frame];
    
    
    [OrelAnimation setDelayPerUnit:0.15f];

    
    CCAnimation *AttackAnimation = [[CCAnimation alloc]init];
    //.animation("orel_attack", 0.07f);
    frame =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"aa_002.png"];
    [AttackAnimation  addSpriteFrame:frame];

    frame =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"aa_003.png"];
    [AttackAnimation  addSpriteFrame:frame];

    frame =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"aa_004.png"];
    [AttackAnimation  addSpriteFrame:frame];

    frame =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"aa_005.png"];
    [AttackAnimation  addSpriteFrame:frame];

    
    _anim_attack =[CCAnimate actionWithAnimation:AttackAnimation];
    
    
    frame =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"pt_000.png"];
    _sprite = [CCSprite spriteWithSpriteFrame:frame];
    
    [m_rootNode addChild :_sprite z: 500];
    
    
//    CCRepeatForever *repeat_action = [CCRepeatForever actionWithAction:anim_action];
//    [sprite runAction:repeat_action];
//    
//    CCMoveTo *move_act =  [CCMoveTo actionWithDuration:1.0f position:ccp(1.0f,1.0f)];
//    [move_actions addObject:move_act];

   //------------------------------------------------
      //sprite.addAnimation(OrelAnimation);
      //sprite.addAnimation(AttackAnimation);
    
    
    [_sprite setScale:0.9f];
    
    _anim_action = [CCAnimate actionWithAnimation:OrelAnimation];
    
    repeat_action = [CCRepeatForever actionWithAction:_anim_action];
    [_sprite runAction:repeat_action];
    
    _move_action =  [CCMoveTo actionWithDuration:1.0f position: ccp(1.0f, 1.0f)];
   
    [self SetInitState];
}

-(void) Shedule
{
    if ( _b_attack_anim )
    {
        if ( [_anim_attack isDone] )
        {
            [_sprite stopAction:_anim_attack];
            [_sprite runAction :repeat_action];
            
            _b_attack = false;
            _b_attack_anim = false;
            
            [self SetInitState];
        }
    }
    else
    {
        if ([_move_action isDone])
        {
            if ( _b_attack )
            {
                [_sprite runAction :_anim_attack];
                _b_attack_anim = true;
            }
            else
                [self SetInitState];
        }
    }
    
}

-(void) SetInitState
{
    int init_pos, end_pos;
    int nRandom = random() %2;
    if (nRandom == 0)
    {
        init_pos = -100;
        end_pos = 3300;
    }
    else
    {
        init_pos = 3300;
        end_pos = -100;
    }
    
    int init_high1 = random()%220 + 500;
    int init_high2 = random()%220 + 500;
    
    [_sprite setVisible :true];
    
    if (init_pos < 0)
        [_sprite setFlipX: false];
    else
        [_sprite setFlipX: true];
    
    [_sprite setPosition :ccp(init_pos, init_high1 + random()%80)];
    
    CGPoint end_point = CGPointMake (end_pos - 0*40, init_high2+random()%80);
    
    float bird_dist = ccpDistance([_sprite position], end_point);
    
    
    [_move_action setDuration : (bird_dist / 120.0f)];
    [_move_action setEndPoint :end_point];
    [_sprite runAction:_move_action];
   

}

-(CGPoint) GetPos
{
    return [_sprite position];
}

-(int) GetDir
{
    if (_b_attack )
        return 0;
    
    if ( _sprite.flipX )
        return -1;
    else
        return 1;
}

-(void) Attack :(CGPoint) duckPos
{
    
    int sdvig_x = random()%80 - 40;
    int sdvig_y = random()%50 - 25;
    
    CGPoint end_point = CGPointMake(duckPos.x + sdvig_x, duckPos.y + sdvig_y);
    
    float bird_dist = ccpDistance([_sprite position],  end_point);

    [_sprite stopAction:repeat_action];
    [_sprite stopAction:_move_action];
    CCSpriteFrame *tempFrame = [[CCSpriteFrameCache sharedSpriteFrameCache ] spriteFrameByName:@"aa_002.png"];

    [_sprite setTextureRect:[tempFrame rect]  rotated:[tempFrame rotated] untrimmedSize:[tempFrame rect].size];
    
    
    
    [_move_action setDuration :(bird_dist / 500.0f)];
    [_move_action setEndPoint:end_point];
    [_sprite runAction :_move_action];
    _b_attack = true;
}

-(void) Fire
{
    if ( _b_attack )
    {
        [_sprite stopAction:_move_action];
        [_sprite runAction :_anim_attack];
        _b_attack_anim = true;
    }
}

-(CGRect) GetRect
{
    return [_sprite boundingBox] ;
}

@end
