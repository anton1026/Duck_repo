//
//  CBirds.m
//  Duck
//
//  Created by Anton on 9/14/14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import "CBirds.h"

@implementation CBirds


-(id) initWithNode : (CCNode *) rootNode
{
    if(self =[super init]){
        m_rootNode = rootNode;
        //   m_random = random;
        _sprites = [[NSMutableArray alloc] init];
        _move_actions = [[NSMutableArray alloc]init];
        _anim_action = nil;
        m_init_cnt = 0;
        
    }
    return self;

}

-(void) InitBirds
{
    // create birds
    CCAnimation *BirdAnimation = [[CCAnimation alloc]init];
    
    CCSpriteFrame *frame =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"chaika1.png"];
    
    [BirdAnimation  addSpriteFrame:frame];
    
    frame =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"chaika2.png"];
    [BirdAnimation  addSpriteFrame:frame];
    
    frame =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"chaika3.png"];
    [BirdAnimation  addSpriteFrame:frame];
    
    frame =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"chaika4.png"];
    [BirdAnimation  addSpriteFrame:frame];
    
    [BirdAnimation setDelayPerUnit:0.2f];
    
    
    for (int i = 0; i < 6; i++)
    {
        CCSpriteFrame *frame1 =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"chaika1.png"];
        
        CCSprite *sprite =[CCSprite spriteWithSpriteFrame:frame1];
        
        
        
        [_sprites addObject:sprite];
        
        
        [m_rootNode addChild: sprite z: 500];
        
       // [sprite ]
       // [sprite addAnimation:BirdAnimation];
        
        CCAnimate *anim_action = [CCAnimate actionWithAnimation:BirdAnimation];
        
        CCRepeatForever *repeat_action = [CCRepeatForever actionWithAction:anim_action];
        [sprite runAction:repeat_action];
        
        CCMoveTo *move_act =  [CCMoveTo actionWithDuration:1.0f position:ccp(1.0f,1.0f)];
        [_move_actions addObject:move_act];
        
    }
}

-(void) Shedule
{
    Boolean bAllDone = true;
    for (int i = 0; i < m_init_cnt; i++)
    {
        if (![[_move_actions objectAtIndex:i] isDone])
        {
            bAllDone = false;
        }
    }
    
    if (bAllDone)
        [self SetInitState];
}

-(void) SetInitState
{
    int init_pos, end_pos;
    
    if (random()%2 == 0)
    {
        init_pos = -100;
        end_pos = 3300;
    }
    else
    {
        init_pos = 3300;
        end_pos = -100;
   }
    
    m_init_cnt =random()%5 + 1;
    int init_high1 = random() % 220 + 500;
    int init_high2 = random() % 220+ 500;
    
    
    for (int i = m_init_cnt; i < 5; i++)
    {
        [[_sprites objectAtIndex:i] setVisible:false];

    }
    
    for (int i = 0; i < m_init_cnt; i++)
    {
        [[_sprites objectAtIndex:i] setVisible:true];
    
        if (init_pos < 0)
            [[_sprites objectAtIndex:i] setFlipX:true];

        else
            [[_sprites objectAtIndex:i] setFlipY:false];

        [[_sprites objectAtIndex:i] setPosition:ccp(init_pos - i*40, init_high1+ random() %80)];
        

        CGPoint end_point = CGPointMake(end_pos - i*40, init_high2+ random()%80);
        
        float bird_dist = ccpDistance([[_sprites objectAtIndex:i] position], end_point);
       
        

//        --------------------------------------------------
        [[_move_actions objectAtIndex:i] setDuration: (bird_dist/100.0f)];
        
        
        [[_move_actions objectAtIndex:i] setEndPoint:end_point];
        
        [[_sprites objectAtIndex:i] runAction: [_move_actions objectAtIndex:i]];

    }
}

@end
