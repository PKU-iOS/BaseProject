//
//  ThirdPartService.m
//  FamilyCloud
//
//  Created by Wmy on 2017/1/5.
//  Copyright © 2017年 Wmy. All rights reserved.
//

#import "ThirdPartService.h"

@implementation ThirdPartService

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"三方类初始化");
        
        
    });
}

@end
