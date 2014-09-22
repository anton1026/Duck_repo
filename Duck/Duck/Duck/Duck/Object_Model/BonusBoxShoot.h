//
//  BonusBoxShoot.h
//  Duck
//
//  Created by Denis A on 9/17/14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@interface BonusBoxShoot : NSObject

@property(nonatomic,retain) CCSprite  *sprite;
@property(nonatomic,retain) CCAnimate *action;
-(id) initWithNode :(CCNode *)rootNode zorder:(int) zi;

@end
