//
//  AlbumViewController.m
//  BaseProject
//
//  Created by Wmy on 2017/1/4.
//  Copyright © 2017年 Wmy. All rights reserved.
//

#import "AlbumViewController.h"
#import "FileManagerViewController.h"

@interface AlbumViewController ()

@end

@implementation AlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"AlbumVC";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // 需要引用
//    FileManagerViewController *fileVC = [FileManagerViewController new];
//    fileVC.view.backgroundColor = [UIColor blueColor];
//    [self.navigationController pushViewController:fileVC animated:YES];
    
    // 不引用 直接跳转传值
     [self.base_navigationController pushViewController:@"LoadViewController" parameters:@{@"key":@"value"}];
    
}

@end
