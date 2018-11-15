//
//  BDNavigationView.h
//  QiXiuBaoDian
//
//  Created by ben on 2018/4/4.
//  Copyright © 2018年 guanwei. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 自定义 的nagation view 目前只有标题和返回键
 */
@interface BDNavigationView : UIView

+ (instancetype)navigationView;

/**标题 默认没有标题*/
@property (nonatomic,copy)NSString *naviTitle;

/**默认为黑色*/
@property (nonatomic,strong)UIColor *naviTitleColor;

/**返回键的标题 默认是返回*/
@property (nonatomic,copy)NSString *leftBackTitle;
/**默认为黑色*/
@property (nonatomic,strong)UIColor *leftBackTitleColor;

/**
 nomal:为nil 设置后就是整个view的背景图片
 */
@property (nonatomic,strong)UIImage *backgroundImage;

/**底部的横线 默认隐藏*/
@property (nonatomic,weak,readonly)UIView *bottomLineView;

/**点击返回的block操作*/
@property (nonatomic,copy)void (^navigationBackAction)(void);



@end
