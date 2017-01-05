//
//  NSDictionary+Json.m
//  ZT
//
//  Created by Wmy on 15/8/2.
//  Copyright (c) 2015年 soshare. All rights reserved.
//

#import "NSDictionary+Json.h"

@implementation NSDictionary (Json)

- (NSString *)stringForKey:(id)key {
    NSString * const kEmptyStrings = @"";
    NSString *result = [self objectForKey:key];
    if([result isKindOfClass:[NSString class]])
    {
        return result;
    }
    else if ([result isKindOfClass:[NSNumber class]])
    {
        return [NSString stringWithFormat:@"%.0f", [result doubleValue]];
    }
    return kEmptyStrings;
}

- (NSString *)stringForKey11:(id)key
{
    NSString * const kEmptyStrings = @"";
    NSString *result = [self objectForKey:key];
    if([result isKindOfClass:[NSString class]])
    {
        return result;
    }
    else if ([result isKindOfClass:[NSNumber class]])
    {
        return [NSString stringWithFormat:@"%.02f", [result doubleValue]];
    }
    return kEmptyStrings;
}

#pragma mark - double
- (NSString *)stringDoubleValueForKey:(id)key
{
    id result = [self objectForKey:key];
    if ([result isKindOfClass:[NSString class]]) {
        return result;
    }
    if ([result isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%lf", [result doubleValue]];
    }
    return @"";
}

#pragma mark - intenger
- (NSString *)stringIntForKey:(id)key
{
    id result = [self objectForKey:key];
    if ([result isKindOfClass:[NSString class]]) {
        return result;
    }
    if ([result isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%ld", (long)[result integerValue]];
    }
    return @"";
}

#pragma mark - float
- (NSString *)stringFloatForKey:(id)key
{
    id result = [self objectForKey:key];
    if ([result isKindOfClass:[NSString class]]) {
        return result;
    }
    if ([result isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%.02f", [result floatValue]];
    }
    return @"";
}

- (NSDictionary *)dictionaryForKey:(id)key
{
    NSDictionary *result = [self objectForKey:key];
    if([result isKindOfClass:[NSDictionary class]])
    {
        return result;
    }
    return nil;
}

- (NSArray *)arrayForKey:(id)key
{
    NSArray *result = [self objectForKey:key];
    if([result isKindOfClass:[NSArray class]])
    {
        return result;
    }
    return nil;
}

@end
