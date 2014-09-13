//
//  Thumb.m
//  Duck
//
//  Created by Denis A on 9/13/14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import "Thumb.h"
#import "Global.h"

@implementation Thumb{
    
}

-(id) init
{
    if( (self=[super init])) {
      
        CCSpriteFrame *cframe =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"ThumbLine.png"];
        m_spriteLine = [CCSprite spriteWithSpriteFrame:cframe];
        [self addChild:m_spriteLine z:5];
        [m_spriteLine setPosition: ccp(0*g_fx,0*g_fy)];
        
        cframe =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"Thumb.png"];
        m_spriteThumb = [CCSprite spriteWithSpriteFrame:cframe];
        [self addChild: m_spriteThumb z:6];
        [m_spriteThumb setPosition: ccp(0*g_fx,0*g_fy)];
        
        m_Value =50;
                                    
    }
	
	return self;

}
-(void) update
{
    if(m_Value <0)
        m_Value =0;
    [m_spriteThumb setPosition: ccp(380.0f* m_Value / 100.0f*g_fx - 190*g_fx, 0*g_fy)];
}
@end
