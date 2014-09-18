//
//  Bomb.h
//  Duck
//
//  Created by Denis A on 9/17/14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BombType.h"

@interface Bomb : NSObject
{
    
}

@property (nonatomic,retain) BombType  *bombtype1;
@property (nonatomic,retain) BombType  *bombtype2;
@property int type;
@property int m_BombaState;

-(id)initWithNode :(CCNode*) rootNode;

@end
