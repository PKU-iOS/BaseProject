//
//  ViewController.m
//  BaseProject
//
//  Created by Wmy on 2016/11/11.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.navigationController pushViewController:@"ViewController_1"
//                                       parameters:@{@"id":@"123056", @"name":@"wmy"}];
    [self.base_navigationController pushViewController:@"ViewController_1"
                                            parameters:@{@"id":@"123056", @"name":@"wmy"}];
    
}


@end
