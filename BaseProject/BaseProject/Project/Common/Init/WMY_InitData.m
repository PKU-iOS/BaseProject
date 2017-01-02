//
//  WMY_InitializingData.m
//  WaveView
//
//  Created by Wmy on 2016/11/10.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import "WMY_InitData.h"

@implementation WMY_InitData

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"数据初始化");
        [self initDB];
        [self GetServerStatus];
    });
}

+ (void)initDB {
    // 初始化数据库
    
}

+ (void)GetServerStatus {
    // 检测网络状态
    
}

@end
