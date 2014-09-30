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
        BonusAnimation =[[CCAnimation alloc]init];
        for(int i = 1; i <4  ; i++) {
            [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"bonus%d.png",i]]];
        }
        BonusAnimation = [CCAnimation animationWithSpriteFrames:frames delay:0.1f];
        _action = [CCAnimate actionWithAnimation:BonusAnimation];
       
        
        [rootNode addChild :_sprite z: zi];
        [_sprite setVisible:false];
    }
    return self;
}
-(void) runShootAction
{
    NSMutableArray *frames = [[NSMutableArray alloc]init];
    BonusAnimation =[[CCAnimation alloc]init];
    for(int i = 1; i <4  ; i++) {
        [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"bonus%d.png",i]]];
    }
    BonusAnimation = [CCAnimation animationWithSpriteFrames:frames delay:0.1f];
    _action = [CCAnimate actionWithAnimation:BonusAnimation];

    [_sprite runAction:_action];
}
-(Boolean) onActionEnd
{
    if([_action isDone])
        return true;
    else
        return false;
}
@end
