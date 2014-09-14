//
//  GameLevel.m
//  Duck
//
//  Created by Denis A on 9/14/14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import "GameLevel.h"

@implementation GameLevel
{
    
}
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLevel *layer = [GameLevel node];
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
        
       // [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"play.mp3"];
        
    }
	
	return self;
}



@end
