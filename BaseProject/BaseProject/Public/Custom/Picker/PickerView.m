//
//  PickerView.m
//  ZT
//
//  Created by Wmy on 15/8/9.
//  Copyright (c) 2015年 soshare. All rights reserved.
//

#import "PickerView.h"

#define kDuration 0.26

@interface PickerView () <UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic) UIPickerView *pickerView;
@property (nonatomic, strong) UIToolbar *toolBar;

@property (nonatomic, assign) NSInteger selectedRow;
@property (nonatomic, assign) NSInteger selectedComponent;
@end

@implementation PickerView

#pragma mark - life cycle


- (instancetype)initWithFrame:(CGRect)frame
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    self = [super initWithFrame:(CGRect){{0, 0}, size}];
    if (self)
    {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.01];
        [self addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.contentView];
   
    }
    return self;
}


#pragma mark - event response
- (void)actionConformSelect {
    [self dismiss];

    // 确认
    if (self.delegate && [_delegate respondsToSelector:@selector(pickerView:confirmSelectRow:inComponent:)]) {
        [_delegate pickerView:self confirmSelectRow:_selectedRow inComponent:_selectedComponent];
    }
}

// 刷新显示数据
- (void)reloadAllComponents {
    [_pickerView reloadAllComponents];
    _selectedComponent = 0;
    _selectedRow = 0;
    [_pickerView selectRow:0 inComponent:0 animated:NO];

}
// 设置选中行
- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated {
    [_pickerView selectRow:row inComponent:component animated:YES];
}

// 显示
- (void)show {
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    _contentView.frame = (CGRect){{0, self.bounds.size.height}, {self.bounds.size.width, 260}};
    [UIView animateWithDuration:kDuration
                     animations:^{
                         self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];

                         _contentView.frame = (CGRect){{0, self.bounds.size.height - 260},
                                                          {self.bounds.size.width, 260}};
                     }];
}
// 隐藏
- (void)dismiss {
    
    [UIView animateWithDuration:kDuration
                     animations:^{
                         self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.01];

                         _contentView.frame = (CGRect){{0, self.bounds.size.height},
                                                          {self.bounds.size.width, 260}};
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                     }];
    
}

#pragma mark - dataSource
 
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfComponentsInPickerView:)]) {
       return [_dataSource numberOfComponentsInPickerView:self];
    }
    return 1;
}
 
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(pickerView:numberOfRowsInComponent:)]) {
        return [_dataSource pickerView:self numberOfRowsInComponent:component];
    }
    return 0;
}
 
#pragma mark - delegate

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 30.0f;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerView:titleForRow:forComponent:)]) {
        return [_delegate pickerView:self titleForRow:row forComponent:component];
    }
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _selectedRow = row;
    _selectedComponent = component;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerView:didSelectRow:inComponent:)]) {
        [_delegate pickerView:self didSelectRow:row inComponent:component];
    }
}


#pragma mark - getter and setter 

- (UIView *)contentView {
    if (_contentView == nil) {
        UIView *view = [[UIView alloc] init];
        view.frame = (CGRect){{0, self.bounds.size.height}, {self.bounds.size.width, 260}};
        view.backgroundColor = [UIColor clearColor];
        _contentView = view;
        [_contentView addSubview:self.toolBar];
        [_contentView addSubview:self.pickerView];
    }
    return _contentView;
}

- (UIPickerView *)pickerView {
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.frame = CGRectMake(0, _toolBar.bounds.size.height,
                                       _contentView.bounds.size.width,
                                       _contentView.bounds.size.height - _toolBar.bounds.size.height);
        _pickerView.backgroundColor = RGBA(248, 248, 248, 0.98);
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.showsSelectionIndicator = YES;
    }
    return _pickerView;
}

- (UIToolbar *)toolBar {
    if (_toolBar == nil) {
        _toolBar = [[UIToolbar alloc] init];
        _toolBar.frame = CGRectMake(0, 0, _contentView.bounds.size.width, 44);
        
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                  target:nil
                                                                                  action:nil];
        
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"确认  "
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(actionConformSelect)];
        NSArray *items = @[leftItem,rightItem];
        [_toolBar setItems:items];
    }
    return _toolBar;
}

@end
