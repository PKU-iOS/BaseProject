//
//  DataInit.m
//  FamilyCloud
//
//  Created by Wmy on 2017/1/5.
//  Copyright © 2017年 Wmy. All rights reserved.
//

#import "DataInit.h"

@implementation DataInit

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
