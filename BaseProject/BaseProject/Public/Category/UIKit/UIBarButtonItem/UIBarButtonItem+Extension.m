//
//  UIBarButtonItem+Extension.m
//  GNT
//
//  Created by Wmy on 16/8/30.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)createItemWithTitle:(NSString *)title target:(id)target sel:(SEL)sel {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title
                                                             style:UIBarButtonItemStylePlain
                                                            target:target
                                                            action:sel];
    return item;
}

+ (UIBarButtonItem *)createItemWithImageName:(NSString *)imageName target:(id)target sel:(SEL)sel {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:imageName]
                                                             style:UIBarButtonItemStylePlain
                                                            target:target
                                                            action:sel];
    return item;
}

+ (UIBarButtonItem *)itemStyle:(BAR_BUTTON_ITEM_STYLE)style target:(id)target sel:(SEL)sel {
    NSString *titleStr;
    NSString *imageName;
    switch (style) {
        case BAR_BUTTON_ITEM_STYLE_NORMAL:
            titleStr = @"item";
            break;
            
        case BAR_BUTTON_ITEM_STYLE_BACK:
            imageName = @"goBack";
            break;

            
        default:
            titleStr = @"item";
            break;
    }
    if (titleStr.length > 0) {
        return [self createItemWithTitle:titleStr target:target sel:sel];
    }else {
        return [self createItemWithImageName:imageName target:target sel:sel];
    }
}


@end
