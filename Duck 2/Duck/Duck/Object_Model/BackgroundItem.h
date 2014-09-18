//
//  BackgroundItem.h
//  Duck
//
//  Created by Denis A on 9/17/14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BackgroundItem : NSObject

@property  float x,y;
@property  float scale_x, scale_y;
@property  int origin_x,origin_y;
@property  NSString *texture_name;
@property  int ZOrder;
@property  int isSkyBox;


@end
