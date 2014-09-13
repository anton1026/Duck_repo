//
//  WelcomeLayer.h
//  Duck
//
//  Created by Denis A on 9/12/14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import "cocos2d.h"

@interface WelcomeLayer : CCLayer
{
     int cnt;
}
+(CCScene *) scene;
-(void) ontime : (ccTime) dt;
@end
