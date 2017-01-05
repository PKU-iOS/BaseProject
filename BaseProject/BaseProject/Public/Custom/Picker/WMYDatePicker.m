
//
//  WMYDatePicker.m
//  WMYDatePicker
//
//  Created by Wmy on 16/4/22.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import "WMYDatePicker.h"

static CGFloat const kDuration    = 0.26;
static CGFloat const kToolBarH    = 44;
static CGFloat const kDatePickerH = 216;

@interface WMYDatePicker ()
@property (nonatomic, strong) NSLayoutConstraint *contentViewBottomConstraint;
@property (nonatomic, strong) UIView *contentView;
//@property (nonatomic, strong) UIVisualEffectView *visualEffectView;
@property (nonatomic, strong) UIToolbar *toolBar;
@end

@implementation WMYDatePicker

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self)
    {
        [self configureUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.frame = [UIScreen mainScreen].bounds;
}

#pragma mark - event response

- (void)confirm:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(dateConfirmInDatePicker:)]) {
        [_delegate dateConfirmInDatePicker:self];
    }
    [self dismiss];
}

- (void)dateChange:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(datePicker:changeDate:)]) {
        _datePicker = (UIDatePicker *)sender;
        [_delegate datePicker:self changeDate:_datePicker.date];
    }
}

#pragma mark - show / dismiss

- (void)show {
    
    [[[UIApplication sharedApplication].delegate window] addSubview:self];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:kDuration
                         animations:^{
                             self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
                             _contentViewBottomConstraint.constant = 0;
                             [self layoutIfNeeded];
                         } completion:^(BOOL finished) {
                             
                         }];
    });
}

- (void)dismiss {
    
    if (_delegate && [_delegate respondsToSelector:@selector(datePickerDismiss)]) {
        [_delegate datePickerDismiss];
    }
    
    [UIView animateWithDuration:kDuration
                     animations:^{
                         self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.01];
                         _contentViewBottomConstraint.constant = kToolBarH + kDatePickerH;
                         [self layoutIfNeeded];
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                     }];
    
}

#pragma mark - configureUI

- (void)configureUI {
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.01];
    [self addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.contentView];
//    [_contentView addSubview:self.visualEffectView];
    [_contentView addSubview:self.datePicker];
    _datePicker.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    [self addSubview:self.toolBar];
    
    [self addVFL];
}

#pragma mark - getter

- (UIDatePicker *)datePicker {
    if (_datePicker == nil) {
        _datePicker = ({
            UIDatePicker *picker = [[UIDatePicker alloc] init];
            picker.translatesAutoresizingMaskIntoConstraints = NO;
            picker.locale = [NSLocale localeWithLocaleIdentifier:@"zh_Hans_CN"];
            picker.minimumDate = [NSDate date];
            [picker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
            picker;
        });
    }
    return _datePicker;
}

- (UIToolbar *)toolBar {
    if (_toolBar == nil) {
        
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                  target:nil
                                                                                  action:nil];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"完成  "
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(confirm:)];
        NSArray *items = @[leftItem,rightItem];
        
        _toolBar = [[UIToolbar alloc] initWithFrame:CGRectZero];
        _toolBar.translatesAutoresizingMaskIntoConstraints = NO;
        _toolBar.tintColor = COLOR_Theme;
        [_toolBar setItems:items];
    }
    return _toolBar;
}

//- (UIVisualEffectView *)visualEffectView {
//    if (_visualEffectView == nil) {
//        
//        _visualEffectView = ({
//            UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
//            visualEffectView.translatesAutoresizingMaskIntoConstraints = NO;
//            visualEffectView.alpha = 1.0;
//            visualEffectView;
//        });
//    }
//    return _visualEffectView;
//}

- (UIView *)contentView {
    if (_contentView == nil) {
        _contentView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
            view.translatesAutoresizingMaskIntoConstraints = NO;
            view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.68];
            view;
        });
    }
    return _contentView;
}

#pragma mark - vfl

- (void)addVFL {
    
    NSDictionary *metrics = @{@"contentViewH" : @(kDatePickerH),
                              @"toolBarH" : @(kToolBarH)};
    NSString *vfl1 = @"H:|-0-[contentView]-0-|";
    NSString *vfl2 = @"V:[contentView(contentViewH)]";
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfl1
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:nil
                                                                   views:@{@"contentView":_contentView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfl2
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:metrics
                                                                   views:@{@"contentView":_contentView}]];
    
    _contentViewBottomConstraint = [NSLayoutConstraint constraintWithItem:_contentView
                                                                attribute:NSLayoutAttributeBottom
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self
                                                                attribute:NSLayoutAttributeBottom
                                                               multiplier:1.0
                                                                 constant:kDatePickerH + kToolBarH];
    
    if (iOS8Later) {
        [NSLayoutConstraint activateConstraints:@[_contentViewBottomConstraint]];
        _contentViewBottomConstraint.active = YES;
    }else {
        [self addConstraint:_contentViewBottomConstraint];
    }
    
    
//    NSString *vfl3 = @"H:|-0-[visualEffectView]-0-|";
//    NSString *vfl4 = @"V:|-0-[visualEffectView]-0-|";
//    [_contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfl3
//                                                                         options:NSLayoutFormatDirectionLeadingToTrailing
//                                                                         metrics:nil
//                                                                           views:@{@"visualEffectView":_visualEffectView}]];
//    [_contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfl4
//                                                                         options:NSLayoutFormatDirectionLeadingToTrailing
//                                                                         metrics:nil
//                                                                           views:@{@"visualEffectView":_visualEffectView}]];
    
    NSString *vfl5 = @"H:|-0-[datePicker]-0-|";
    NSString *vfl6 = @"V:|-0-[datePicker]-0-|";
    [_contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfl5
                                                                         options:NSLayoutFormatDirectionLeadingToTrailing
                                                                         metrics:nil
                                                                           views:@{@"datePicker":_datePicker}]];
    [_contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfl6
                                                                         options:NSLayoutFormatDirectionLeadingToTrailing
                                                                         metrics:nil
                                                                           views:@{@"datePicker":_datePicker}]];
    NSString *vfl7 = @"H:|-0-[toolBar]-0-|";
    NSString *vfl8 = @"V:[toolBar(toolBarH)]-0-[contentView]";
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfl7
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:nil
                                                                   views:@{@"toolBar":_toolBar,
                                                                           @"contentView":_contentView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfl8
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:metrics
                                                                   views:@{@"toolBar":_toolBar,
                                                                           @"contentView":_contentView}]];
    
}


@end
