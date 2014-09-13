//
//  Thumb.h
//  Duck
//
//  Created by Denis A on 9/13/14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import "cocos2d.h"

@interface Thumb : CCNode{
    CCSprite *m_spriteLine, *m_spriteThumb;
    int m_Value;
    
}
-(void) update;
@end
