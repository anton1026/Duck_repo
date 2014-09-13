//
//  TutorialLevel.m
//  Duck
//
//  Created by Anton on 9/13/14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import "TutorialLevel.h"
#import "SimpleAudioEngine.h"

@implementation TutorialLevel
{
    
}
float g_fx,g_fy,g_fx1,g_fy1;
bool flag_retain=false;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	TutorialLevel *layer = [TutorialLevel node];
	// add layer as a child to scene
	[scene addChild: layer];
	// return the scene
	return scene;
}

-(id) init
{
	if( (self=[super init])) {
        [self setTouchEnabled:true];
		// ask director for the window size
 		CGSize size = [[CCDirector sharedDirector] winSize];
     	CCSprite *background;
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"play.mp3"];
        
        
        
        
        //        [self schedule:@"ontime" interval:1.0f/20.0f];
    }
	
	return self;
}
@end
