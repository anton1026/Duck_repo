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
    
    anim_action = nil;
    b_attack = false;
    b_attack_anim = false;
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

    
    anim_attack =[CCAnimate actionWithAnimation:AttackAnimation];
    
    
    frame =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"pt_000.png"];
    sprite = [CCSprite spriteWithSpriteFrame:frame];
    
    [m_rootNode addChild :sprite z: 500];
    
    
//    CCRepeatForever *repeat_action = [CCRepeatForever actionWithAction:anim_action];
//    [sprite runAction:repeat_action];
//    
//    CCMoveTo *move_act =  [CCMoveTo actionWithDuration:1.0f position:ccp(1.0f,1.0f)];
//    [move_actions addObject:move_act];

   //------------------------------------------------
      //sprite.addAnimation(OrelAnimation);
      //sprite.addAnimation(AttackAnimation);
    
    
    [sprite setScale:0.9f];
    
    anim_action = [CCAnimate actionWithAnimation:OrelAnimation];
    
    repeat_action = [CCRepeatForever actionWithAction:anim_action];
    [sprite runAction:repeat_action];
    
    move_action =  [CCMoveTo actionWithDuration:1.0f position: ccp(1.0f, 1.0f)];
   
    [self SetInitState];
}

-(void) Shedule
{
    if ( b_attack_anim )
    {
        if ( [anim_attack isDone] )
        {
            [sprite stopAction:anim_attack];
            [sprite runAction :repeat_action];
            
            b_attack = false;
            b_attack_anim = false;
            
            [self SetInitState];
        }
    }
    else
    {
        if ([move_action isDone])
        {
            if ( b_attack )
            {
                [sprite runAction :anim_attack];
                b_attack_anim = true;
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
    
    [sprite setVisible :true];
    
    if (init_pos < 0)
        [sprite setFlipX: false];
    else
        [sprite setFlipX: true];
    
    [sprite setPosition :ccp(init_pos, init_high1 + random()%80)];
    
    CGPoint end_point = CGPointMake (end_pos - 0*40, init_high2+random()%80);
    
    float bird_dist = ccpDistance([sprite position], end_point);
    
    
    [move_action setDuration : (bird_dist / 120.0f)];
    [move_action setEndPoint :end_point];
    [sprite runAction:move_action];
   

}

-(CGPoint) GetPos
{
    return [sprite position];
}

-(int) GetDir
{
    if ( b_attack )
        return 0;
    
    if ( sprite.flipX )
        return -1;
    else
        return 1;
}

-(void) Attack :(CGPoint) duckPos
{
    
    int sdvig_x = random()%80 - 40;
    int sdvig_y = random()%50 - 25;
    
    CGPoint end_point = CGPointMake(duckPos.x + sdvig_x, duckPos.y + sdvig_y);
    
    float bird_dist = ccpDistance([sprite position],  end_point);

    [sprite stopAction:repeat_action];
    [sprite stopAction:move_action];
    CCSpriteFrame *tempFrame = [[CCSpriteFrameCache sharedSpriteFrameCache ] spriteFrameByName:@"aa_002.png"];

    [sprite setTextureRect:[tempFrame rect]  rotated:[tempFrame rotated] untrimmedSize:[tempFrame rect].size];
    
    
    
    [move_action setDuration :(bird_dist / 500.0f)];
    [move_action setEndPoint:end_point];
    [sprite runAction :move_action];
    b_attack = true;
}

-(void) Fire
{
    if ( b_attack )
    {
        [sprite stopAction:move_action];
        [sprite runAction :anim_attack];
        b_attack_anim = true;
    }
}

-(CGRect) GetRect
{
    return [sprite boundingBox] ;
}

@end
