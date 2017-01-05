//
//  NSString+Tools.m
//  AssemProduct
//
//  Created by Wmy on 16/6/9.
//  Copyright © 2016年 分享通信. All rights reserved.
//

#import "NSString+Tools.h"

@implementation NSString (Tools)

+ (void)log:(NSDictionary *)dict {
    // @property (nonatomic, copy) NSString *%@; //
    NSMutableString *strM = [NSMutableString string];
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [strM appendString:[NSString stringWithFormat:@"/**  */\n@property (nonatomic, copy) NSString *%@;\n", key]];
    }];
    NSLog(@"%@", strM);
    
    // _id = STR_NonEmpty([dict stringIntForKey:@"id"]);
    NSMutableString *setStrM = [NSMutableString string];
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [setStrM appendString:[NSString stringWithFormat:@"_%@ = kNullString([dict stringForKey:@\"%@\"]);\n", key, key]];
    }];
    NSLog(@"%@", setStrM);
}

+ (NSAttributedString *)setLabelLineSpacing:(CGFloat)space andText:(NSString *)text {

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:space];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    
    return attributedString;
}

@end
