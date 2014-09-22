//
//  GameLevel.m
//  Duck
//
//  Created by Denis A on 9/14/14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import "GameLevel.h"



#import <Foundation/Foundation.h>


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

//-(id) init
//{
//	if( (self=[super init])) {
//        [self setTouchEnabled:true];
//		// ask director for the window size
// 		CGSize size = [[CCDirector sharedDirector] winSize];
//        
//       // [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"play.mp3"];
//        
//    }
//	
//	return self;
//}

-(id) initWithXMLFile :(NSString*) xml_file Src:(NSString*) descr
{
    if(self =[super init]){
        
        _m_BackgroundItems =[[NSMutableArray alloc] init];
        _m_HunterItems = [[NSMutableArray alloc] init];
		_m_BonusItems = [[NSMutableArray alloc] init];
		_m_FlowersItems = [[NSMutableArray alloc] init];
        
		_m_SkyBox = nil;
		_m_Descr = descr;
        [self LoadFromXML:xml_file];
    }
    return self;
}
    
-(void) LoadFromXML :(NSString*) xml_file
{
    [_m_BackgroundItems removeAllObjects];
    [_m_HunterItems removeAllObjects];
    [_m_BonusItems removeAllObjects];
    [_m_FlowersItems removeAllObjects];
    
    //NSString *filePath = [self dataFilePath:FALSE];
    NSString *file_path = [[NSBundle mainBundle] pathForResource:xml_file ofType:@"xml"];
    
   
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
            }else if([name isEqualToString:@"Hunters"]){
                 [self LoadHunters :m_backgroundItem];
            }else if([name isEqualToString:@"Bonus"]){
                [self LoadBonus :m_backgroundItem];
            }else if([name isEqualToString:@"Flower"]){
                [self LoadFlower :m_backgroundItem];
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
                [_m_BackgroundItems addObject:b_item];
                
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

-(void) LoadHunters :(GDataXMLElement*) backgrounditem
{
    int dd =0;
    dd =backgrounditem.childCount;
    for(int i=0; i<backgrounditem.childCount; i++){
        
        GDataXMLNode *node =  [backgrounditem childAtIndex:i];
        if([[node name] isEqualToString:@"Items"]){
            for(int j=0; j<node.childCount;j++){
                GDataXMLNode *node_item = [node childAtIndex:j];
                
                HunterItem *h_item =[[HunterItem alloc] init];
                [_m_HunterItems addObject:h_item];
                
                for(int j1=0; j1<node_item.childCount; j1++){
                    GDataXMLNode *sub_item =[node_item childAtIndex:j1];
                    if([sub_item.name isEqualToString:@"Position"]){
                        
                        GDataXMLNode *cc = [sub_item childAtIndex:0];
                        h_item.x = cc.stringValue.floatValue;
                        cc = [sub_item childAtIndex:1];
                        h_item.y = cc.stringValue.floatValue;
                    }else if([sub_item.name isEqualToString:@"Width"]) {
                        GDataXMLNode *cc = [sub_item childAtIndex:0];
                        h_item.width =cc.stringValue.floatValue;
                       
                    } else if([sub_item.name isEqualToString:@"Height"]) {
                        GDataXMLNode *cc = [sub_item childAtIndex:0];
                        h_item.height =cc.stringValue.floatValue;
                      
                    }else if([sub_item.name isEqualToString:@"CustomProperties"]) {
                        
                        GDataXMLNode *cc = [sub_item childAtIndex:0];
                        h_item.z_order =cc.stringValue.intValue;
                        
                        cc = [sub_item childAtIndex:1];
                        h_item.scale =cc.stringValue.intValue;
                        
                        cc = [sub_item childAtIndex:2];
                        h_item.type =cc.stringValue.intValue;
                    }
                }
                
            }
        }
        
    }
}
-(void) LoadBonus :(GDataXMLElement*) backgrounditem
{
    int dd =0;
    dd =backgrounditem.childCount;
    for(int i=0; i<backgrounditem.childCount; i++){
        
        GDataXMLNode *node =  [backgrounditem childAtIndex:i];
        if([[node name] isEqualToString:@"Items"]){
            for(int j=0; j<node.childCount;j++){
                GDataXMLNode *node_item = [node childAtIndex:j];
                
                BonusItem *bo_item =[[BonusItem alloc] init];
                [_m_BonusItems addObject:bo_item];
                
                for(int j1=0; j1<node_item.childCount; j1++){
                    GDataXMLNode *sub_item =[node_item childAtIndex:j1];
                    if([sub_item.name isEqualToString:@"Position"]){
                        
                        GDataXMLNode *cc = [sub_item childAtIndex:0];
                        bo_item.x = cc.stringValue.floatValue;
                        cc = [sub_item childAtIndex:1];
                        bo_item.y = cc.stringValue.floatValue;
                    }else if([sub_item.name isEqualToString:@"Width"]) {
                        GDataXMLNode *cc = [sub_item childAtIndex:0];
                        bo_item.width =cc.stringValue.floatValue;
                        
                    } else if([sub_item.name isEqualToString:@"Height"]) {
                        GDataXMLNode *cc = [sub_item childAtIndex:0];
                        bo_item.height =cc.stringValue.floatValue;
                        
                    }else if([sub_item.name isEqualToString:@"CustomProperties"]) {
                        
                        GDataXMLNode *cc = [sub_item childAtIndex:0];
                        bo_item.z_order =cc.stringValue.intValue;
                    
                    }
                }
                
            }
        }
        
    }
}
-(void) LoadFlower :(GDataXMLElement*) backgrounditem
{
    int dd =0;
    dd =backgrounditem.childCount;
    for(int i=0; i<backgrounditem.childCount; i++){
        
        GDataXMLNode *node =  [backgrounditem childAtIndex:i];
        if([[node name] isEqualToString:@"Items"]){
            for(int j=0; j<node.childCount;j++){
                GDataXMLNode *node_item = [node childAtIndex:j];
                FlowerItem *f_item =[[FlowerItem alloc] init];
                [_m_FlowersItems addObject:f_item];
                
                for(int j1=0; j1<node_item.childCount; j1++){
                    GDataXMLNode *sub_item =[node_item childAtIndex:j1];
                    if([sub_item.name isEqualToString:@"Position"]){
                        
                        GDataXMLNode *cc = [sub_item childAtIndex:0];
                        f_item.x = cc.stringValue.floatValue;
                        cc = [sub_item childAtIndex:1];
                        f_item.y = cc.stringValue.floatValue;
                    }else if([sub_item.name isEqualToString:@"Width"]) {
                        GDataXMLNode *cc = [sub_item childAtIndex:0];
                        f_item.width =cc.stringValue.floatValue;
                        
                    } else if([sub_item.name isEqualToString:@"Height"]) {
                        GDataXMLNode *cc = [sub_item childAtIndex:0];
                        f_item.height =cc.stringValue.floatValue;
                        
                    }else if([sub_item.name isEqualToString:@"CustomProperties"]) {
                        
                        GDataXMLNode *cc = [sub_item childAtIndex:0];
                        f_item.z_order =cc.stringValue.intValue;
                        
                    }
                }
                
            }
        }
        
    }
}

@end
