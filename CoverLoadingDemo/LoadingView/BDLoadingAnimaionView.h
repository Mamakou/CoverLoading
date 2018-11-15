//
//  BDLoadingAnimaionView.h
//  CoverLoadingDemo
//
//  Created by goviewtech on 2018/11/14.
//  Copyright © 2018 goviewtech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDLoadingCoverView.h"

/**
 加载视图里面的view
 */
@interface BDLoadingAnimaionView : UIView

/**
 重新加载
 */
- (void)reloading;
/**
 停止加载
 */
- (void)stopLoading;
/**
 初始加载
 */
- (void)showAnimationType:(BDLoadingAnimationType)animationType;

@end


