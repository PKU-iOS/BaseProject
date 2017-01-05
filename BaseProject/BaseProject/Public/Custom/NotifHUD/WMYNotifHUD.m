//
//  WMYNotifHUD.m
//  GNT
//
//  Created by Wmy on 2016/10/11.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import "WMYNotifHUD.h"
#import "MsgPlaySound.h"

NSString *const kHUD_ClickCallBackNotification = @"ClickCallBackNotification";

static CGFloat kBoundsSizeHeigth = 64.0;
static CGFloat kSelfAlpha = 1.0;

static NSTimeInterval kShowAnimateDuration = 0.28;
static NSTimeInterval kDismissAnimateDuration = 0.28;
static NSTimeInterval kDisplayTime = 3.2;

@interface WMYNotifHUD ()
//@property (nonatomic, strong) UIImageView *leftImg;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *bodyLabel;

// 要显示的数据 缓冲区
@property (nonatomic, strong) __block NSMutableArray <WMYNotifHUDModel *>*dataArrM;
// 当前正在显示的数据
@property (nonatomic) id object;

@end

@implementation WMYNotifHUD

+ (WMYNotifHUD *)sharedView {
    static dispatch_once_t once;
    
    static WMYNotifHUD *sharedView;
    
    CGRect rect;
#if !defined(SV_APP_EXTENSIONS)
    rect = [[[UIApplication sharedApplication] delegate] window].bounds;
#else
    rect = [[UIScreen mainScreen] bounds];
#endif
    rect.size.height = kBoundsSizeHeigth;
    rect.origin.y    = -kBoundsSizeHeigth;
    dispatch_once(&once, ^{ sharedView = [[self alloc] initWithFrame:rect]; });
    
    return sharedView;
}


#pragma mark - Instance Methods

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.98];
        
//        [self addSubview:self.leftImg];
        [self addSubview:self.titleLabel];
        [self addSubview:self.bodyLabel];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat selfW = self.frame.size.width;
    
//    CGFloat leftImgX = 10.0;
//    CGFloat leftImgY = 22.0;
//    CGFloat leftImgW = 54.0;
//    CGFloat leftImgH = 40.0;
//    self.leftImg.frame = CGRectMake(leftImgX, leftImgY, leftImgW, leftImgH);
    
//    CGFloat titleX = leftImgX + leftImgW + 8;
    CGFloat titleX = 10;
    CGFloat titleY = 20.0;
    CGFloat titleW = selfW - titleX - 10;
    CGFloat titleH = 18.0;
    
    CGFloat bodyX = titleX;
    CGFloat bodyY = titleY + titleH;
    CGFloat bodyW = selfW - bodyX - 10;
    CGFloat bodyH = kBoundsSizeHeigth - bodyY;
    
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    self.bodyLabel.frame  = CGRectMake(bodyX, bodyY, bodyW, bodyH);
        
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (_clickCallBack) {
        _clickCallBack(_object);
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:kHUD_ClickCallBackNotification object:_object];
    
    [self remove];
}


#pragma mark - Show Methods

+ (void)showInfo:(WMYNotifHUDModel *)model {
    [[self sharedView] showInfo:model block:nil];
}

+ (void)showInfo:(WMYNotifHUDModel *)model block:(block_clickCallBack)clickCallBack {
    [[self sharedView] showInfo:model block:clickCallBack];
}

- (void)showInfo:(WMYNotifHUDModel *)model block:(block_clickCallBack)clickCallBack {
    _clickCallBack = clickCallBack;
    
    if (self.superview) {
        [self.dataArrM addObject:model];
        return;
    }
    
    self.titleLabel.text = model.title;
    self.bodyLabel.text  = model.body;
    self.object = model.object;
    [self show];
}




/**
 显示一条消息
 */
- (void)show {
    
    [MsgPlaySound msgPlaySystemVibrate];
    
    if (!self.superview) {
        [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    }
    
    CGRect rect = [[[UIApplication sharedApplication] delegate] window].bounds;
    rect.size.height = kBoundsSizeHeigth;
    rect.origin.y    = -kBoundsSizeHeigth;
    self.frame = rect;
    self.alpha = kSelfAlpha;
    
    rect.origin.y = 0;
    __weak WMYNotifHUD *weakSelf = self;
    [UIView animateWithDuration:kShowAnimateDuration
                     animations:^{
                         __strong WMYNotifHUD *strongSelf = weakSelf;
                         strongSelf.frame = rect;
                     } completion:^(BOOL finished) {
                         __strong WMYNotifHUD *strongSelf = weakSelf;
                        [strongSelf performSelector:@selector(completeDisplay) withObject:nil afterDelay:kDisplayTime];
                     }];

}

/**
 当前消息显示结束
 */
- (void)completeDisplay {
    if (self.dataArrM.count > 0) {
        [self dismiss];
        [self performSelector:@selector(showNext) withObject:nil afterDelay:kDismissAnimateDuration];
    }else {
        [self remove];
    }
}


/**
 显示下一条消息
 */
- (void)showNext {
    WMYNotifHUDModel *model = self.dataArrM.firstObject;
    self.titleLabel.text = model.title;
    self.bodyLabel.text  = model.body;
    self.object = model.object;
    [self show];
    [self.dataArrM removeObjectAtIndex:0];
}


/**
 全部消息已显示完 隐藏HUD
 */
- (void)dismiss {

    __weak WMYNotifHUD *weakSelf = self;
    [UIView animateWithDuration:kDismissAnimateDuration
                     animations:^{
                         __strong WMYNotifHUD *strongSelf = weakSelf;
                         strongSelf.alpha = 0.0;
                     } completion:^(BOOL finished) {

                     }];
    
}

/**
 全部消息已显示完 隐藏HUD 并从父视图移除
 */
- (void)remove {
    
    __weak WMYNotifHUD *weakSelf = self;
    [UIView animateWithDuration:kDismissAnimateDuration
                     animations:^{
                         __strong WMYNotifHUD *strongSelf = weakSelf;
                         strongSelf.alpha = 0.0;
                     } completion:^(BOOL finished) {
                         __strong WMYNotifHUD *strongSelf = weakSelf;
                         if (strongSelf) {
                             [strongSelf removeFromSuperview];
                         }
                     }];
    
}



#pragma mark - getter

//- (UIImageView *)leftImg {
//    if (_leftImg == nil) {
//        _leftImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"about_logo"]];
//        _leftImg.contentMode = UIViewContentModeScaleAspectFit;
//    }
//    return _leftImg;
//}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.font = [UIFont boldSystemFontOfSize:14];
        label.textColor = [UIColor whiteColor];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)bodyLabel {
    if (_bodyLabel == nil) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor whiteColor];
        _bodyLabel = label;
    }
    return _bodyLabel;
}

- (NSMutableArray<WMYNotifHUDModel *> *)dataArrM {
    if (_dataArrM == nil) {
        _dataArrM = [NSMutableArray array];
    }
    return _dataArrM;
}

@end


#pragma mark - 
#pragma mark - WMYNotifHUDModel

@implementation WMYNotifHUDModel

@end

