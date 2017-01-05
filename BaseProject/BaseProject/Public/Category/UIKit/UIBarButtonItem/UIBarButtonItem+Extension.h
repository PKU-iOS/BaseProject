//
//  UIBarButtonItem+Extension.h
//  GNT
//
//  Created by Wmy on 16/8/30.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum _BAR_BUTTON_ITEM_STYLE_
{
    // item
    BAR_BUTTON_ITEM_STYLE_NORMAL = 0,
    // 返回按钮
    BAR_BUTTON_ITEM_STYLE_BACK = 10,
    
    
}BAR_BUTTON_ITEM_STYLE;

@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *)createItemWithTitle:(NSString *)title target:(id)target sel:(SEL)sel;

+ (UIBarButtonItem *)createItemWithImageName:(NSString *)imageName target:(id)target sel:(SEL)sel;

+ (UIBarButtonItem *)itemStyle:(BAR_BUTTON_ITEM_STYLE)style target:(id)target sel:(SEL)sel;


@end
