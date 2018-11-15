//
//  BDLoadingCoverView.h
//  QiXiuBaoDian
//
//  Created by ben on 2018/4/3.
//  Copyright © 2018年 guanwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDLoadingConst.h"

/**
 这里可以根据需求进行扩展
 */
typedef NS_ENUM(NSInteger,BDLoadingAnimationType){
    
    /**系统的加载效果*/
    BDLoadingAnimationSystem,//default
    /**图片动画效果*/
    BDLoadingAnimationImages,
    /**蚂蚁森林加载效果*/
    BDLoadingAnimationMayiSenLing,
    
};

@class BDLoadingCoverView;

@protocol BDLoadingCoverViewDelegate <NSObject>

@optional

/**
 点击重新加载
 */
- (void)coverViewReloadAction:(BDLoadingCoverView*)loadView;
/**
 点击导航条的返回
 */
- (void)coverViewBackAction:(BDLoadingCoverView*)loadView;

@end

/**
 加载页面的遮盖view
 可以扩展多种样式的遮盖
 */
@interface BDLoadingCoverView : UIView

/**为loadingview 做标记，可能一个页面存在多次加载不同接口，针对不同接口灵活判断*/
@property (nonatomic,assign)NSInteger sgin;
/**
 当动画样式为图片样式时，必须传入
 */
@property (nonatomic,strong)NSArray<UIImage*>*animationImages;

@property (nonatomic,weak)id <BDLoadingCoverViewDelegate>delegate;

#pragma mark - 显示遮盖加载
/**
 展示遮盖
 */
- (void)showCoverToView:(UIView*)view;
/**
 注意;当为BDLoadingAnimationImages时，必须要传入图片数组
 */
- (void)showCoverToView:(UIView*)view animation:(BDLoadingAnimationType)animationType;

/**
 消除遮盖
 */
- (void)hideCover;

/**
 添加导航条到coverview 上 一般这种遮盖是满屏的，则在某些需求下可以进行添加导航栏
 比如加载失败后，可以添加一个，以便用户点击返回
 */
- (void)addTopNaviBarWithColorValue:(UIColor*)color;

#pragma mark - 直接展示结果

/**
 根据不同的错误码进行不同的页面展示
 */
- (void)showErrorViewWithErrorNumber:(BDRequestErrorType)errorType;

/**
 根页面进行页面加载的遮盖效果
 @param errorType 错误类型
 @param errorMsg 错误提示语 只针对后台返回的
 */
- (void)showErrorViewWithErrorNumber:(BDRequestErrorType)errorType errorMsg:(NSString*)errorMsg;

@end
