//
//  ThirdPartService.m
//  WaveView
//
//  Created by Wmy on 2016/11/10.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import "WMY_ThirdPartService.h"

@implementation WMY_ThirdPartService

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"%s", __func__);
        
        
    });
}

@end
