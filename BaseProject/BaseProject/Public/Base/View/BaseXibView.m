//
//  BaseXibView.m
//  GJT
//
//  Created by Wmy on 2016/11/2.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import "BaseXibView.h"

@interface BaseXibView ()
@property (nonatomic, strong) UIView *contentView;
@end

@implementation BaseXibView

// MARK: -------- life cycle --------

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self loadView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _contentView.frame = self.bounds;
}


// MARK: -------- 从xib中加载 --------

- (UIView *)loadWithNib:(NSString *)fileName owner:(id)owner {
    return [[NSBundle mainBundle] loadNibNamed:fileName owner:owner options:nil].firstObject;
}

// MARK: -------- 加载底层view --------

- (void)loadView {
    if (_contentView) {
        return;
    }
    [self addSubview:self.contentView];
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [self loadWithNib:NSStringFromClass([self class]) owner:self];
        _contentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    }
    return _contentView;
}

@end
