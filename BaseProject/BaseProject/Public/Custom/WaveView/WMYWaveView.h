//
//  WMYWaveView.h
//  WaveView
//
//  Created by Wmy on 2016/11/4.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WaveDirectionType) {
    WaveDirectionTypeUp = 0,
    WaveDirectionTypeDown,
};

@interface WMYWaveView : UIView
@property (nonatomic) WaveDirectionType waveDirectionType;
@property (nonatomic) CGFloat angularSpeed;
@property (nonatomic) CGFloat waveSpeed;
@property (nonatomic) NSTimeInterval waveTime;
@property (nonatomic, strong) UIColor *waveColor;

+ (instancetype)addToView:(UIView *)view withFrame:(CGRect)frame;
- (BOOL)wave;
- (void)stop;

@end

