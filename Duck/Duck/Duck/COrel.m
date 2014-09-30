


//
//  COrel.m
//  Duck
//
//  Created by Anton on 9/14/14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import "COrel.h"
#import "Global.h"

@implementation COrel
{
    
}
-(id) initWithNode : (CCNode *) rootNode
{
    if(self =[super init]){
        m_rootNode =rootNode;

//    m_random = random;
    
        _anim_action = nil;
        _b_attack = false;
        _b_attack_anim = false;
        _isActionEnd =true;
        _isAtackEnd=true;
        
    }
    return self;
}
-(void) initOrel
{
    
    OrelAnimation =[[CCAnimation alloc]init];
    NSMutableArray *frames = [[NSMutableArray alloc]init];
    OrelAnimation =[[CCAnimation alloc]init];
    for(int i = 0; i <9  ; i++) {
        [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"pt_00%d.png",i]]];
    }
    OrelAnimation  = [CCAnimation animationWithSpriteFrames:frames delay:0.15f];
    
   
    
    [frames removeAllObjects];
    AttackAnimation =[[CCAnimation alloc]init];
    for(int i = 2; i <6  ; i++) {
        [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"aa_00%d.png",i]]];
    }
    
    AttackAnimation  = [CCAnimation animationWithSpriteFrames:frames delay:0.07f];
    
    _anim_attack = [CCAnimate actionWithAnimation:AttackAnimation];

    
    _sprite = [CCSprite spriteWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"pt_000.png"]];
    [m_rootNode addChild :_sprite z: 500];
    
    
    
    [_sprite setScale:0.9f*g_fx1];
    
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
        if(_isAtackEnd )
//        if ( [_anim_attack isDone] )
        {
           
            OrelAnimation =[[CCAnimation alloc]init];
            NSMutableArray *frames = [[NSMutableArray alloc]init];
            OrelAnimation =[[CCAnimation alloc]init];
            for(int i = 0; i <9  ; i++) {
                [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"pt_00%d.png",i]]];
            }
            OrelAnimation  = [CCAnimation animationWithSpriteFrames:frames delay:0.15f];
            
            
            
            [frames removeAllObjects];
            AttackAnimation =[[CCAnimation alloc]init];
            for(int i = 2; i <6  ; i++) {
                [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"aa_00%d.png",i]]];
            }
            
            AttackAnimation  = [CCAnimation animationWithSpriteFrames:frames delay:0.07f];
            
            _anim_attack = [CCAnimate actionWithAnimation:AttackAnimation];

            
            _anim_action = [CCAnimate actionWithAnimation:OrelAnimation];
            repeat_action = [CCRepeatForever actionWithAction:_anim_action];
            
            [_sprite stopAction : _anim_attack];
            [_sprite runAction  : repeat_action];
            
            _b_attack = false;
            _b_attack_anim = false;
            
            [self SetInitState];
        }
    }
    else
    {
        if (_isActionEnd)
        {
            if ( _b_attack )
            {
                NSMutableArray *frames = [[NSMutableArray alloc]init];
                AttackAnimation =[[CCAnimation alloc]init];
                for(int i = 2; i <6  ; i++) {
                    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"aa_00%d.png",i]]];
                }
                
                AttackAnimation  = [CCAnimation animationWithSpriteFrames:frames delay:0.07f];
                _anim_attack =[CCAnimate actionWithAnimation:AttackAnimation];
                
                CCCallFuncN* actionForTargetMoveDidFinish2 = [CCCallFuncN actionWithTarget:self selector:@selector(targetAttackFinished)];
                _isAtackEnd =false;
                [_sprite runAction:[CCSequence actions:_anim_attack,actionForTargetMoveDidFinish2,nil]];

//                [_sprite runAction :_anim_attack];
                _b_attack_anim = true;
            }
            else
                [self SetInitState];
        }
    }
    
}
-(void) targetAttackFinished
{
      _isAtackEnd =true;
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
    
    _move_action =[CCMoveTo actionWithDuration:(bird_dist / 120.0f) position:end_point];
    
    
  
    
    CCCallFuncN* actionForTargetMoveDidFinish = [CCCallFuncN actionWithTarget:self selector:@selector(targetMoveFinished)];
    _isActionEnd =false;
    [_sprite runAction:[CCSequence actions:_move_action,actionForTargetMoveDidFinish,nil]];

    
 //   [_sprite runAction:_move_action];
   

}
-(void)targetMoveFinished
{
    _isActionEnd=true;
    
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
    
    _move_action =[CCMoveTo actionWithDuration:(bird_dist / 500.0f) position:end_point];
    
   
     CCCallFuncN* actionForTargetMoveDidFinish = [CCCallFuncN actionWithTarget:self selector:@selector(targetMoveFinished)];
    _isActionEnd =false;
    [_sprite runAction:[CCSequence actions:_move_action,actionForTargetMoveDidFinish,nil]];

    //[_sprite runAction :_move_action];
    _b_attack = true;
 
}

-(void) Fire
{
   
    if ( _b_attack )
    {
        [_sprite stopAction:_move_action];
        
        OrelAnimation =[[CCAnimation alloc]init];
        NSMutableArray *frames = [[NSMutableArray alloc]init];
        OrelAnimation =[[CCAnimation alloc]init];
        for(int i = 0; i <9  ; i++) {
            [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"pt_00%d.png",i]]];
        }
        OrelAnimation  = [CCAnimation animationWithSpriteFrames:frames delay:0.15f];

//        
//        CCAnimation *OrelAnimation =[[CCAnimation alloc]init];
//        
//        CCSpriteFrame *frame =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"pt_000.png"];
//        
//        [OrelAnimation  addSpriteFrame:frame];
//        
//        frame =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"pt_001.png"];
//        [OrelAnimation  addSpriteFrame:frame];
//        
//        frame =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"pt_002.png"];
//        [OrelAnimation  addSpriteFrame:frame];
//        
//        frame =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"pt_003.png"];
//        [OrelAnimation  addSpriteFrame:frame];
//        
//        frame =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"pt_004.png"];
//        [OrelAnimation  addSpriteFrame:frame];
//        
//        frame =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"pt_005.png"];
//        [OrelAnimation  addSpriteFrame:frame];
//        
//        frame =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"pt_006.png"];
//        [OrelAnimation  addSpriteFrame:frame];
//        
//        frame =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"pt_007.png"];
//        [OrelAnimation  addSpriteFrame:frame];
//        
//        frame =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"pt_008.png"];
//        [OrelAnimation  addSpriteFrame:frame];
//        
//        
//        [OrelAnimation setDelayPerUnit:0.15f];
       
        
        
        [frames removeAllObjects];
        AttackAnimation =[[CCAnimation alloc]init];
        for(int i = 2; i <6  ; i++) {
            [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"aa_00%d.png",i]]];
        }
        
        AttackAnimation  = [CCAnimation animationWithSpriteFrames:frames delay:0.07f];
        _anim_attack =[CCAnimate actionWithAnimation:AttackAnimation];
        
        
        CCCallFuncN* actionForTargetMoveDidFinish2 = [CCCallFuncN actionWithTarget:self selector:@selector(targetAttackFinished)];
        _isAtackEnd =false;
        [_sprite runAction:[CCSequence actions:_anim_attack,actionForTargetMoveDidFinish2,nil]];
        
        
      //  [_sprite runAction :_anim_attack];
        _b_attack_anim = true;
    }
}

-(CGRect) GetRect
{
    return [_sprite boundingBox] ;
}

@end
