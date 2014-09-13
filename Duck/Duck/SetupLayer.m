//
//  SetupLayer.m
//  Duck
//
//  Created by Anton on 9/13/14.
//  Copyright (c) 2014 Anton. All rights reserved.
//
#import "Global.h"
#import "SetupLayer.h"
#import "SimpleAudioEngine.h"
#import "BackgroundItem.h"

#define OriginY                    (IS_IPAD ? 384 : 384)

@implementation SetupLayer{
    NSMutableArray *m_backgroundItems;
    
}

//float g_fx,g_fy,g_fx1,g_fy1;
//bool flag_retain=false;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	SetupLayer *layer = [SetupLayer node];
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
     	
        
        m_backgroundItems = [[NSMutableArray alloc] init];
        
        
        m_rootNode = [[CCNode alloc]init];
		[m_rootNode setScaleX:g_fx*g_fx1];
        [m_rootNode setScaleY:g_fx*g_fx1];
        
       // [self setPosition: ccp(-(1024-size.width)/2.0f*g_fx, -(768-size.height)/2.0*g_fy)];
         [self setPosition: ccp(0,0)];
        [self addChild:m_rootNode];
        
        
        CCSpriteFrame *cframe =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"ok.png"];
        m_OK = [CCSprite spriteWithSpriteFrame:cframe];
        [m_rootNode addChild: m_OK z:100 ];
        [m_OK setOpacity:160 ];
        [m_OK setPosition: ccp(700*g_fx, 70*g_fy)];
        
        cframe =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"cancel.png"];
        m_Cancel = [CCSprite spriteWithSpriteFrame:cframe];
        [m_rootNode addChild: m_Cancel z:100 ];
        [m_Cancel setOpacity:160 ];
        [m_Cancel setPosition: ccp(900*g_fx, 70*g_fy)];
        
        NSString *file_path = [[NSBundle mainBundle] pathForResource:@"level1" ofType:@"xml"];
        [self LoadformXML:file_path];

     //   [self scheduleUpdate];
        
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level1.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level1_2.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level1_3.plist"];
        
        [self BuildWorld];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"play.mp3"];
        
    }
	
	return self;
}
-(void) BuildWorld
{
    for(BackgroundItem *bi in m_backgroundItems ){
       
        NSString *temp = bi.texture_name;
        
    CCSpriteFrame *cframe =[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:bi.texture_name];
       CCSprite *back = [CCSprite spriteWithSpriteFrame:cframe];
      //  CCSprite *back =[CCSprite spriteWithFile:temp];
        [back setPosition: ccp((bi.x + 1536)*g_fx, (-(bi.y) + OriginY)*g_fy)];
        [back setScaleX:bi.scale_x];
        [back setScaleY:bi.scale_y];
         
        [m_rootNode addChild:back z:bi.ZOrder];
        
       
        
    }
    
}
-(void) LoadformXML :(NSString*) file_path
{
    
    //NSString *filePath = [self dataFilePath:FALSE];
    NSData *xmlData = [[NSMutableData alloc] initWithContentsOfFile:file_path];
    NSError *error;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:&error];
    if (doc == nil) { return; }
    
    //m_backgorund = [doc nodesForXPath:@"//Party/Player" error:nil];
    NSMutableArray *m_backItems =[doc nodesForXPath:@"//Layers/Layer" error:nil];
    
    for (GDataXMLElement *m_backgroundItem in m_backItems) {
        
        // Let's fill these in!
        NSArray  *temp = [m_backgroundItem attributes];
        NSString *name;
        if (temp.count > 0) {
            GDataXMLElement *firstName = (GDataXMLElement *) [temp objectAtIndex:0];
            name = firstName.stringValue;
            if([name isEqualToString:@"Background"]){
               [self LoadBackground :m_backgroundItem];
                NSLog(@"Ok");
            }
        }
        
    }
    
    
}
-(void) LoadBackground :(GDataXMLElement*) backgrounditem
{
    int dd =0;
    dd =backgrounditem.childCount;
    for(int i=0; i<backgrounditem.childCount; i++){
        
        GDataXMLNode *node =  [backgrounditem childAtIndex:i];
        if([[node name] isEqualToString:@"Items"]){
           for(int j=0; j<node.childCount;j++){
               GDataXMLNode *node_item = [node childAtIndex:j];
               
               BackgroundItem *b_item =[[BackgroundItem alloc] init];
               [m_backgroundItems addObject:b_item];
               
               for(int j1=0; j1<node_item.childCount; j1++){
                   GDataXMLNode *sub_item =[node_item childAtIndex:j1];
                   if([sub_item.name isEqualToString:@"Position"]){

                        GDataXMLNode *cc = [sub_item childAtIndex:0];
                        b_item.x = cc.stringValue.floatValue;
                        cc = [sub_item childAtIndex:1];
                        b_item.y = cc.stringValue.floatValue;
                   }else if([sub_item.name isEqualToString:@"Origin"]) {
                        GDataXMLNode *cc = [sub_item childAtIndex:0];
                        b_item.origin_x =cc.stringValue.intValue;
                        cc = [sub_item childAtIndex:1];
                        b_item.origin_y =cc.stringValue.intValue;
                   } else if([sub_item.name isEqualToString:@"Scale"]) {
                      GDataXMLNode *cc = [sub_item childAtIndex:0];
                      b_item.scale_x =cc.stringValue.floatValue;
                      cc = [sub_item childAtIndex:1];
                      b_item.scale_y =cc.stringValue.floatValue;
                   }else if([sub_item.name isEqualToString:@"texture_filename"]) {
                        GDataXMLNode *cc = [sub_item childAtIndex:0];
                        b_item.texture_name =cc.stringValue;
                     
                   }else if([sub_item.name isEqualToString:@"CustomProperties"]) {

                       GDataXMLNode *cc = [sub_item childAtIndex:0];
                       b_item.ZOrder =cc.stringValue.intValue;
                       
                   }
               }
            
            }
        }
        
    }
}
-(void) update:(ccTime)delta
{
   //float x = 512-m_duckPos.x;
   // float add = (m_visibleWidth-MySettings.getInstance().LOG_SCREEN_WIDTH)/2;
   // if (x > -add)
   //     x = -add;
   // if (x < (-(1024*3-(MySettings.getInstance().LOG_SCREEN_WIDTH + add))))
   //     x = -(1024*3-(MySettings.getInstance().LOG_SCREEN_WIDTH + add));
   float X =0;
    
   [m_rootNode setPosition:ccp(512*g_fx, 0*g_fy)];
    
   [m_OK setPosition: ccp( (-X+1200)*g_fx, 70*g_fx)];
}
@end
