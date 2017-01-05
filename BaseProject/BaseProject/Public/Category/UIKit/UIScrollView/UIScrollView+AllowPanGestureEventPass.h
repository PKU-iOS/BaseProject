//
//  UIScrollView+AllowPanGestureEventPass.h
//  ZeroGo
//
//  Created by colorPen on 15/12/28.
//  Copyright © 2015年 colorful. All rights reserved.
//

/**
 *  在对应的类中调用 resolveGoBackGestureConflict, 解决返回边缘手势与scrollview滑动手势冲突
 
 - (void)resolveGoBackGestureConflict {
    for (UIGestureRecognizer *recognizer in self.navigationController.view.gestureRecognizers)
    {
        if ([recognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]])
        {
            [self.scrollView.panGestureRecognizer requireGestureRecognizerToFail:(UIScreenEdgePanGestureRecognizer *)recognizer];
 
            break;
        }
    }
 }
 
 */

#import <UIKit/UIKit.h>

@interface UIScrollView (AllowPanGestureEventPass)

@end
