//
//  GameWorld.h
//  Duck
//
//  Created by Anton on 9/14/14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import "cocos2d.h"
#import "GameLevel.h"




@interface GameWorld : CCLayer
{
    enum GameStates{
		ZASTAVKA,		// Ð½Ð°Ñ‡Ð°Ð»ÑŒÐ½Ð°Ñ� Ð·Ð°Ñ�Ñ‚Ð°Ð²ÐºÐ°
		MANMENU,		// Ð³Ð»Ð°Ð²Ð½Ð¾Ðµ Ð¼ÐµÐ½ÑŽ
		SELECTLEVEL,	// Ð²Ñ‹Ð±Ð¾Ñ€ ÑƒÑ€Ð¾Ð²Ð½Ñ�
		GAMEOVER,		// Ð¸Ð³Ñ€Ð° Ð·Ð°ÐºÐ¾Ð½Ñ‡ÐµÐ½Ð°
		PLAY			// Ð¸Ð´ÐµÑ‚ Ð¸Ð³Ñ€Ð°
	} GameStates;
    
    enum GameStates m_state;
    
    
    int	    LOG_SCREEN_WIDTH;		// Ð›Ð¾Ð³Ð¸Ñ‡ÐµÑ�ÐºÐ°Ñ� Ð´Ð»Ð¸Ð½Ð° Ð¼Ð¸Ñ€Ð°
	int  	LOG_SCREEN_HEIGHT;		// Ð›Ð¾Ð³Ð¸Ñ‡ÐµÑ�ÐºÐ°Ñ� Ð²Ñ‹Ñ�Ð¾Ñ‚Ð° Ð¼Ð¸Ñ€Ð°
	float 	PULA_SPEED;
	
	int     MIN_DELAY_BONUS;
	int     MIN_DELAY_BOMBA;
}
    



+(CCScene *) scene;
@end
