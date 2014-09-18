//
//  BonusBoxShoot.m
//  Duck
//
//  Created by Denis A on 9/17/14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import "BonusBoxShoot.h"

@implementation BonusBoxShoot

-(id) initWithNode :(CCNode *)rootNode zorder:(int) zi
{
    if(self =[super init]){
        CCSpriteFrame *cframe =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"bonus1.png"];
        _sprite = [CCSprite spriteWithSpriteFrame:cframe];
        
        NSMutableArray *frames = [[NSMutableArray alloc]init];
        for(int i = 2; i <4  ; i++) {
            [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"bonus%d.png",i]]];
        }
        CCAnimation *BonusAnimation = [CCAnimation animationWithFrames:frames delay:0.1f];
        
        //    _sprite addAnimation(BonusAnimation);
        
        _action = [CCAnimate actionWithAnimation:BonusAnimation];
        [rootNode addChild :_sprite z: zi];
        [_sprite setVisible:false];
    }
    return self;
}

@end
