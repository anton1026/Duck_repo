//
//  Apple_Object.h
//  Duck
//
//  Created by Denis A on 9/17/14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Apple_Object : NSObject

@property (nonatomic,retain) CCSprite *m_appleSprite;
@property (nonatomic,retain) CCAction *m_appleActionAnim;
@property (nonatomic,retain) CCMoveTo *m_appleActionMove;

@end
