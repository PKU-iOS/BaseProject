//
//  BaseViewController.m
//  BaseProject
//
//  Created by Wmy on 2017/1/2.
//  Copyright © 2017年 Wmy. All rights reserved.
//

#import "BaseViewController.h"
#import "NavigationController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_BG;
    self.rt_disableInteractivePop = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - getter

- (NavigationController *)base_navigationController {
    UIViewController *vc = self;
    while (vc && ![vc isKindOfClass:[NavigationController class]]) {
        vc = vc.navigationController;
    }
    return (NavigationController *)vc;
}

@end
