//
//  BadgeButton.m
//  GJT
//
//  Created by Wmy on 2016/11/3.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import "BadgeButton.h"

static CGFloat kBadgeLabelH = 14.0;

@interface BadgeButton ()
@property (nonatomic, copy) UILabel *badgeLabel;
@end

@implementation BadgeButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_badgeLabel) {
        CGFloat labelW = kBadgeLabelH;
        if (_badgeValue > 99) {
            labelW = 22.0;
        }else if (_badgeValue > 9) {
            labelW = 18.0;
        }
        
        CGSize titleSize = [self.titleLabel.text stringCGSizeWithTextSize:CGSizeMake(300, 300) andFont:_badgeLabel.font];
        
        CGSize imgSize = CGSizeMake(0.0, 0.0);
        if (self.imageView.image) {
            imgSize = self.currentImage.size;
        }
        
        CGFloat labelY = 4.0;
        CGFloat labelX = 0.5 * (self.bounds.size.width + imgSize.width + titleSize.width + labelW);
        _badgeLabel.frame = CGRectMake(labelX, labelY, labelW, kBadgeLabelH);
    }

}


#pragma mark - setter

- (void)setBadgeValue:(NSInteger)badgeValue {
    _badgeValue = badgeValue;
    
    if (badgeValue < 1) {
        if (_badgeLabel) {
            _badgeLabel.text = @"";
            [_badgeLabel removeFromSuperview];
            _badgeLabel = nil;
        }
    }else {
        if (!_badgeLabel) {
            [self addSubview:self.badgeLabel];
        }
        if (badgeValue > 99) {
            _badgeLabel.text = @"99+";
        }else {
            _badgeLabel.text = [NSString stringWithFormat:@"%lu", badgeValue];
        }
    }
    
    [self setNeedsLayout];
}



#pragma mark - UI

- (UILabel *)badgeLabel {
    if (!_badgeLabel) {
        _badgeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _badgeLabel.backgroundColor = [UIColor redColor];
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
        _badgeLabel.textColor = [UIColor whiteColor];
        _badgeLabel.font = [UIFont systemFontOfSize:10];
        _badgeLabel.clipsToBounds = YES;
        _badgeLabel.layer.cornerRadius = 0.5 * kBadgeLabelH;
        _badgeLabel.tag = kBadgeLabelTag;
    }
    return _badgeLabel;
}

@end
