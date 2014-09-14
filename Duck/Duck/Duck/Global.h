//
//  Global.h
//  Duck
//
//  Created by Anton on 9/12/14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import "cocos2d.h"

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