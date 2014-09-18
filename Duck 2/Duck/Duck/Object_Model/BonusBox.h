//
//  BonusBox.h
//  Duck
//
//  Created by Denis A on 9/17/14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BonusBoxLive.h"
#import "BonusBoxShoot.h"

@interface BonusBox : NSObject

@property (nonatomic,retain) BonusBoxLive *bonus_live;
@property (nonatomic,retain) BonusBoxShoot *bonus_shoot;
@property int m_type;
@property int m_BonusState;

-(id) initWithNode :(CCNode *)rootNode zorder:(int) zi;

@end
