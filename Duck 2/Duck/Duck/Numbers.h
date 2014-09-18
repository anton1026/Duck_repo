//
//  Numbers.h
//  Duck
//
//  Created by Denis A on 9/16/14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import "cocos2d.h"

@interface Numbers : CCNode
{
//    int m_Num;
//    NSMutableArray *sprs;
}
@property int m_Num;
@property (nonatomic,retain) NSMutableArray *sprs;
-(float) SetNum :(int) num;
@end
