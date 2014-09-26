//
//  Thumb.h
//  Duck
//
//  Created by Denis A on 9/13/14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import "cocos2d.h"

@interface Thumb : CCNode
{
  
    
}
@property (nonatomic,retain) CCSprite *m_spriteLine;
@property (nonatomic,retain) CCSprite *m_spriteThumb;

@property int m_Value;
-(void) update;
@end
