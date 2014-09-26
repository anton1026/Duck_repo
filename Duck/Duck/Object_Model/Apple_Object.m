//
//  Apple_Object.m
//  Duck
//
//  Created by Denis A on 9/17/14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import "Apple_Object.h"

@implementation Apple_Object

-(id) init
{
    if(self =[super init]){
        self.m_appleSprite =nil;
        self.m_appleActionAnim =nil;
        self.m_appleActionMove =nil;
        
    }
    return self;
    
}

@end
