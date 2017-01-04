//
//  GuideViewController.m
//  BaseProject
//
//  Created by Wmy on 2017/1/3.
//  Copyright © 2017年 Wmy. All rights reserved.
//

#import "GuideViewController.h"

@interface GuideViewController () <UIScrollViewDelegate>
@property (nonatomic, weak) IBOutlet UIScrollView *guideScrollV;
- (IBAction)action_enterApp:(id)sender;
@end

@implementation GuideViewController

- (void)dealloc {
    debugMethod();
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)action_enterApp:(id)sender {
//    [kUserDefaults setBool:YES forKey:kUD_GUIDEPAGE_ISSKIP];
//    [kUserDefaults synchronize];
    [kNotifCenter postNotificationName:kNC_GuideVC_RemoveNotification object:nil];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_guideScrollV != scrollView) {
        return;
    }
    CGFloat offset_x = scrollView.contentOffset.x;
    if (offset_x < 2 * kSCREEN_WIDTH) {
        return;
    }
    
    CGFloat topOffsetX = 100.;
    
    CGFloat overtop_x = offset_x - 2 * kSCREEN_WIDTH;
    if (overtop_x > 0 && overtop_x < topOffsetX) {
        CGFloat alpha = 1.0 - overtop_x / topOffsetX;
        self.view.alpha = alpha;
    }
    static BOOL canEnter = 1;
    if (canEnter == 1 && overtop_x > topOffsetX) {
        canEnter = 0;
        [self action_enterApp:nil];
    }
}

@end
