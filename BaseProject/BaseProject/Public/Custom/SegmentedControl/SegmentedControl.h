//
//  SegmentedControl.h
//  GJT
//
//  Created by Wmy on 2016/11/1.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SegmentedControl;
@protocol SegmentedControlDelegate <NSObject>
- (void)segmentControl:(SegmentedControl *)segmentCtrl clickedButtonAtIndex:(NSInteger)buttonIndex;
@end

@interface SegmentedControl : UIView

@property (nonatomic, weak) id<SegmentedControlDelegate> delegate;
@property (nonatomic, strong) NSArray *segments;
@property (nonatomic, assign) NSInteger selectedSegment;    // defaults selected index 0.
@property (nonatomic) BOOL separationLineHidden;        // defaults is YES.
@property (nonatomic) BOOL bottomLineHidden;            // defaults is YES.
@property (nonatomic) BOOL bottomSelectedLineHidden;    // defaults is YES.


/**
 设置选中标记滚动线滚动滚动比 0.0~1.0
 */
- (void)setSelectedLineScrollPercent:(CGFloat)percent;

/**
 设置分类按钮badge 为0时不显示
 */
- (void)setBadgeNumber:(NSInteger)number atIndex:(NSInteger)index;

@end
