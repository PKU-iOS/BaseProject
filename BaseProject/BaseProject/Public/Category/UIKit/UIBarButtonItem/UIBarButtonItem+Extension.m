//
//  UIBarButtonItem+Extension.m
//  GNT
//
//  Created by Wmy on 16/8/30.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)


+ (UIBarButtonItem *)backBarButtonItemTarget:(id)target sel:(SEL)sel {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"goBack"]
                                                                 style:UIBarButtonItemStylePlain
                                                                target:target
                                                                action:sel];
    
    return backItem;
}


@end
