//
//  BDLoadingShowController.h
//  CoverLoadingDemo
//
//  Created by goviewtech on 2018/11/15.
//  Copyright © 2018 goviewtech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDLoadingCoverView.h"

NS_ASSUME_NONNULL_BEGIN
/**
 个人建议将加载遮盖效果封装到基类中
 */
@interface BDLoadingShowController : UIViewController

/****
 这里是为了演示用而设置的属性
 *****/
@property (nonatomic,assign)BDLoadingAnimationType type;

@property (nonatomic,assign)BOOL showFail;

@property (nonatomic,assign)BOOL showMulit;

@end

NS_ASSUME_NONNULL_END
