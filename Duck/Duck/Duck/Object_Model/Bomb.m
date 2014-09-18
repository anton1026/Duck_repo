//
//  Bomb.m
//  Duck
//
//  Created by Denis A on 9/17/14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import "Bomb.h"

@implementation Bomb

-(id)initWithNode :(CCNode*) rootNode
{
    if(self = [super init]){
        
        _type =0;
        _m_BombaState =0;
        _bombtype1 = [[BombType alloc] init];
        _bombtype2 = [[BombType alloc] init];
        
        CCSpriteFrame *cframe =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"bomb1.png"];
        _bombtype1.sprite = [CCSprite spriteWithSpriteFrame:cframe];
        
        NSMutableArray *frames = [[NSMutableArray alloc]init];
        for(int i = 1; i <5  ; i++) {
            if(i==1)
                [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"bomb.png"]]];
            else
                [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"bomb%d.png",i]]];
        }
        
        CCAnimation *BombaAnimation = [CCAnimation animationWithFrames:frames delay:0.1f];
        
        //        _bombtype1.sprite addAnimation(BombaAnimation);
        _bombtype1.action = [CCAnimate actionWithAnimation:BombaAnimation];
        
        [rootNode addChild: _bombtype1.sprite z:5];
        
        [_bombtype1.sprite setVisible:false];
        [_bombtype1.sprite setScale:0.7f];
        
        
        cframe =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"tnt1.png"];
        _bombtype2.sprite = [CCSprite spriteWithSpriteFrame:cframe];
        
        
        for(int i = 2; i <4  ; i++) {
            [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"tnt%d.png",i]]];
        }
        BombaAnimation = [CCAnimation animationWithFrames:frames delay:0.1f];
        
        
        //        _bombtype2.sprite addAnimation(BombaAnimation);
        
        _bombtype2.action = [CCAnimate actionWithAnimation:BombaAnimation];
        [rootNode addChild : _bombtype2.sprite z: 5];
        [_bombtype2.sprite setVisible :false];
        [_bombtype2.sprite setScale :0.7f];
        
    }
    return self;
}


@end
