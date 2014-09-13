//
//  SetupLayer.h
//  Duck
//
//  Created by  Anton on 9/13/14.
//  Copyright (c) 2014 Anton. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GDataXMLNode.h"

@interface SetupLayer : CCLayer
{
    //NSMutableArray *backgorund_list =  new NSMutableArray[init];
    CCSprite *m_OK;
    CCSprite *m_Cancel;
    CCSprite *m_Check;
    CCSprite *m_Uncheck;
    CCNode   *m_rootNode;
}
+(CCScene *) scene;

-(void) LoadformXML :(NSString*) file_path;
-(void) LoadBackground :(GDataXMLElement*) backgrounditem;
-(void) on_time:(ccTime) dt;
-(void) BuildWorld;
@end
