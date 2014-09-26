//
//  HunterItem.h
//  Duck
//
//  Created by Denis A on 9/17/14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HunterItem : NSObject

@property    float x, y;
@property    float width, height;
@property    int z_order;
@property    float scale;
@property    int type;        // 0, 1 or 2
@property    int lives;

@end
