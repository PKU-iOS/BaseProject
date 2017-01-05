//
//  BaseViewController.h
//  BaseProject
//
//  Created by Wmy on 2017/1/2.
//  Copyright © 2017年 Wmy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationController.h"

@interface BaseViewController : UIViewController

@property (nonatomic, readonly, strong) NavigationController *base_navigationController;
@property (nonatomic, strong) NSDictionary *params;

@end
