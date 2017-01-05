//
//  NSDictionary+Json.h
//  ZT
//
//  Created by Wmy on 15/8/2.
//  Copyright (c) 2015年 soshare. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Json)

- (NSString *)stringForKey:(id)key;

- (NSString *)stringIntForKey:(id)key;

- (NSString *)stringDoubleValueForKey:(id)key;

- (NSString *)stringFloatForKey:(id)key;

- (NSDictionary *)dictionaryForKey:(id)key;

- (NSMutableArray *)arrayForKey:(id)key;

@end
