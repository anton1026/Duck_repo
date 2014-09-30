//
//  Global.h
//  Duck
//
//  Created by Anton on 9/12/14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import "cocos2d.h"

#import "Background.h"
#import "BackgroundItem.h"
#import "HunterItem.h"
#import "BonusItem.h"
#import "FlowerItem.h"
#import "Hunter.h"
#import "BombType.h"
#import "Bomb.h"
#import "Pula.h"
#import "Background.h"
#import "BonusBoxLive.h"
#import "BonusBoxShoot.h"
#import "BonusBox.h"
#import "Flower.h"
#import "Apple_Object.h"
#import "FreeInd.h"


#ifdef UI_USER_INTERFACE_IDIOM
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#else
#define IS_IPAD false
#endif

#define _isRus false
extern float g_fx,g_fy,g_fx1,g_fy1;
extern bool flag_retain;
int  current_level;
int ShowButtons;
float density;
int openLevels;
NSMutableArray *Level_Lists;
float WIN_SIZE_X;
float WIN_SIZE_Y;
Boolean bExit;
int LeftRightKef;
int UpDownKef;
