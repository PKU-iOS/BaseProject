//
//  WMYDatePicker.h
//  WMYDatePicker
//
//  Created by Wmy on 16/4/22.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WMYDatePicker;
@protocol WMYDatePickerDelegate <NSObject>

@optional
- (void)datePickerDismiss;
- (void)dateConfirmInDatePicker:(WMYDatePicker *)datePicker;
- (void)datePicker:(WMYDatePicker *)datePicker changeDate:(NSDate *)date;

@end

@interface WMYDatePicker : UIControl

@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, weak) id<WMYDatePickerDelegate> delegate;
- (void)show;

@end
