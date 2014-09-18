////
////  GameWorld.h
////  Duck
////
////  Created by Anton on 9/14/14.
////  Copyright (c) 2014 Anton. All rights reserved.
////
//
//#import "cocos2d.h"
//#import "GameLevel.h"
//
//@interface  Hunter1: NSObject
//{
//    CCRepeatForever *repeat;
//    CCAnimate 		*strelba_action;
//}
//@property(nonatomic,retain)HunterItem *hi;
//@property(nonatomic,retain)CCMoveTo *move_action;
//@property(nonatomic,retain)CCMoveTo *pula_action;
//@property(nonatomic,retain)CCSprite *sprite;
//@property(nonatomic,retain)CCSprite *pulaSprite;
//@property int state;
//@property int lives;
//@property long timetostay;
//@property long timetomove;
//@property long timetopula;
//
//@end
//
//@interface  Background1: NSObject
//
//  @property(nonatomic,retain) CCSprite *sprite;
//
//@end
//
//@interface Bomb1 :NSObject
//
// @property(nonatomic,retain) CCSprite *sprite;
// @property(nonatomic,retain) CCAnimate *action;
// @property int	type;
//
//@end
//
//@implementation Bomb1
//-(id) init
//{
//    if(self =[super init]){
//         _sprite = nil;
//         _action = nil;
//
//    }
//    return self;
//}
//@end
//
//
//@interface BonusBox1: NSObject
//
//@property(nonatomic,retain)  CCSprite *sprite;
//@property(nonatomic, retain) CCAnimate *action;
//    
//@end
//@implementation BonusBox1
//
//-(id)init
//{
//    if(self = [super init]){
//        _sprite = nil;
//        _action = nil;
//    }
//    return self;
//}
//@end
//
//
//@interface  Birds1 : NSObject
//
// @property (nonatomic,retain) NSMutableArray *sprites;
// @property (nonatomic,retain) CCAnimate *anim_action;
// @property (nonatomic,retain) NSMutableArray *move_actions;
//
//-(void) init_Birds;
//-(void) Shedule;
//-(void) SetInitState;
//@end
//@implementation Birds1
//
//-(id) init
//{
//    if(self =[super init]){
//        _sprites =[[NSMutableArray alloc]init];
//        _anim_action =nil;
//        _move_actions=[[NSMutableArray alloc]init];
//        
//    }
//    return  self;
//        
//}
//
//-(void) init_Birds
//{
//    NSMutableArray *frames = [[NSMutableArray alloc]init];
//    for(int i = 1; i <5  ; i++) {
//        [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"chaika%d.png",i]]];
//    }
//    CCAnimation *BirdAnimation  = [CCAnimation animationWithFrames:frames delay:0.2f];
//    
//    for (int i = 0; i < 6; i++)
//    {
//        CCSprite *sprite = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"chaika1.png"];
//        
//        [_sprites addObject:sprite];
//        
//       // [m_rootNode addChild :sprite z: 500];
//        
//       // sprite addAnimation(BirdAnimation);
//        
//        CCAnimate *anim_action = [CCAnimate actionWithAnimation: BirdAnimation];
//        CCRepeatForever *repeat_action = [CCRepeatForever actionWithAction:anim_action];
//        [sprite runAction :repeat_action];
//    }
//    
//}
//-(void) Shedule
//{
//    if (_move_actions.count == 0)
//    {
//        [self SetInitState];
//        return;
//    }
//    Boolean bAllDone = true;
//    for (int i = 0; i < _move_actions.count; i++)
//    {
//        if (![_move_actions[i] isDone])
//        {
//            bAllDone = false;
//        }
//    }
//    
//    if (bAllDone)
//        [self SetInitState];
//
//}
//-(void) SetInitState
//{
//    int init_pos, end_pos;
//    
//    if (random()%2 == 0)
//    {
//        init_pos = -100;
//        end_pos = 3300;
//    }
//    else
//    {
//        init_pos = 3300;
//        end_pos = -100;
//    }
//    
//    int init_cnt = random()%5 + 1;
//    int init_high1 = random()%220 + 500;
//    int init_high2 = random()%220 + 500;
//    
//    for (int i = init_cnt; i < 5; i++)
//    {
//        [_sprites[i] setVisible:false];
//    }
//    
//    [_move_actions  removeAllObjects];
//    
//    for (int i = 0; i < init_cnt; i++)
//    {
//        [_sprites[i] setVisible: true];
//        
//        if (init_pos < 0)
//            [_sprites[i] setFlipX:true];
//        else
//            [_sprites[i] setFlipX:false];
//
//        
//        [_sprites[i] setPosition: ccp(init_pos - i*40, init_high1+random()%80)];
//        
//        
//        
//        CGPoint end_point = CGPointMake(end_pos - i*40, init_high2+random() %80);
//        
//        float bird_dist =ccpDistance([_sprites[i] position], end_point);
//
//        CCMoveTo *move_act = [CCMoveTo  actionWithDuration:bird_dist / 100.0f position:end_point];
//        [_move_actions addObject: move_act];
//        [_sprites[i] runAction:move_act];
//
//    }
//
//}
//@end
//
//
//
//
//@interface GameWorld : CCLayer
//{
//    enum GameStates{
//		ZASTAVKA,		// Ð½Ð°Ñ‡Ð°Ð»ÑŒÐ½Ð°Ñ� Ð·Ð°Ñ�Ñ‚Ð°Ð²ÐºÐ°
//		MANMENU,		// Ð³Ð»Ð°Ð²Ð½Ð¾Ðµ Ð¼ÐµÐ½ÑŽ
//		SELECTLEVEL,	// Ð²Ñ‹Ð±Ð¾Ñ€ ÑƒÑ€Ð¾Ð²Ð½Ñ�
//		GAMEOVER,		// Ð¸Ð³Ñ€Ð° Ð·Ð°ÐºÐ¾Ð½Ñ‡ÐµÐ½Ð°
//		PLAY			// Ð¸Ð´ÐµÑ‚ Ð¸Ð³Ñ€Ð°
//	} GameStates;
//    
//    enum GameStates m_state;
//    
//    
//    int	    LOG_SCREEN_WIDTH;		// Ð›Ð¾Ð³Ð¸Ñ‡ÐµÑ�ÐºÐ°Ñ� Ð´Ð»Ð¸Ð½Ð° Ð¼Ð¸Ñ€Ð°
//	int  	LOG_SCREEN_HEIGHT;		// Ð›Ð¾Ð³Ð¸Ñ‡ÐµÑ�ÐºÐ°Ñ� Ð²Ñ‹Ñ�Ð¾Ñ‚Ð° Ð¼Ð¸Ñ€Ð°
//	int  	HUNTER_HEIGHT;
//	float 	HUNTER_SPEED;
//	float 	PULA_SPEED;
//	int     MIN_INTERVAL_STAY;
//	int     MAX_DELAY_STAY;
//	
//	int     MIN_DELAY_BONUS;
//	int     MIN_DELAY_BOMBA;
//	int     OriginX;
//	int     OriginY;
//	int     SkyScaleX;
//	int     SkyScaleY;
//}
//    
//
//
//
//+(CCScene *) scene;
//@end
