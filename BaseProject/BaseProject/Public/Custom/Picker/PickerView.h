//
//  PickerView.h
//  ZT
//
//  Created by Wmy on 15/8/9.
//  Copyright (c) 2015年 soshare. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PickerViewDelegate, PickerViewDataSource;

@interface PickerView : UIControl

@property (nonatomic, weak) id<PickerViewDelegate> delegate;
@property (nonatomic, weak) id<PickerViewDataSource> dataSource;
// 显示选择器
- (void)show;
// 刷新显示
- (void)reloadAllComponents;
// 重置选中行
- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated;

@end


@protocol PickerViewDataSource <NSObject>
@optional
- (NSInteger)numberOfComponentsInPickerView:(PickerView *)pickerView;
@required
- (NSInteger)pickerView:(PickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
@end

@protocol PickerViewDelegate <NSObject>
@optional
/** 点击完成按钮回调 */
- (void)pickerView:(PickerView *)pickerView confirmSelectRow:(NSInteger)row inComponent:(NSInteger)component;
/** 填充pickerView数据 */
- (NSString *)pickerView:(PickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
/** 选中了component组 row行 */
- (void)pickerView:(PickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
@end



