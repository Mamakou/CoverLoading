//
//  BDLoadingCoverView.m
//  QiXiuBaoDian
//
//  Created by ben on 2018/4/3.
//  Copyright © 2018年 guanwei. All rights reserved.
//

#import "BDLoadingCoverView.h"
#import "UIView+AutoLayout.h"
#import "BDNavigationView.h"
#import "BDLoadingAnimaionView.h"

@interface BDLoadingCoverView ()

@property (nonatomic,weak)UIImageView *backImageView;

@property (nonatomic,weak)UILabel *textLabel;

@property (nonatomic,assign)BDRequestErrorType errorType;

@property (nonatomic,weak)NSLayoutConstraint *imageLayout;

@property (nonatomic,weak)BDLoadingAnimaionView *animationView;

@property (nonatomic,weak)BDNavigationView *navigationView;


@end

@implementation BDLoadingCoverView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        
        //设置文字与图片的距离为10 临时占用，方便调整位置的
        UIView *tempView = [[UIView alloc]init];
        tempView.backgroundColor = [UIColor clearColor];
        [self addSubview:tempView];
        [tempView autoSetDimensionsToSize:CGSizeMake(1, 1)];
        [tempView autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [tempView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        //结果显示的背景图
        UIImageView *backImageView = [[UIImageView alloc]init];
        backImageView.contentMode = UIViewContentModeCenter;
        self.backImageView = backImageView;
        [self addSubview:backImageView];
        [backImageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [backImageView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:tempView withOffset:-49];

        //结果显示文本
        UILabel *textLabel = [[UILabel alloc]init];
        textLabel.numberOfLines = 0;
        self.textLabel = textLabel;
        textLabel.textColor = [UIColor grayColor];
        textLabel.font = [UIFont systemFontOfSize:14];
        textLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:textLabel];
        [textLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:backImageView];
        [textLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:backImageView withOffset:10];
        
        [backImageView setHidden:YES];
        [textLabel setHidden:YES];
        
        BDLoadingAnimaionView *animationView = [[BDLoadingAnimaionView alloc]initWithFrame:frame];
        self.animationView = animationView;
        [self addSubview:animationView];
      
        UITapGestureRecognizer *tapAction = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickToReload)];
        [self addGestureRecognizer:tapAction];
    }
    return self;
}

/**
 展示遮盖
 */
- (void)showCoverToView:(UIView*)view
{
    [self showCoverToView:view animation:BDLoadingAnimationSystem];
}

- (void)showCoverToView:(UIView*)view animation:(BDLoadingAnimationType)animationType
{
    self.animationView.hidden = NO;
    [self.animationView showAnimationType:animationType];
    [view addSubview:self];
}

/**
 消除遮盖
 */
- (void)hideCover
{
    [UIView transitionWithView:self duration:0.25 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self.animationView stopLoading];
        [self removeFromSuperview];
    }];
}

#pragma mark - 操作时间
- (void)clickToReload
{
    if(_errorType == BDRequestErrorTimeOut || _errorType == BDRequestErrorNetLow || _errorType == BDRequestErrorOther || _errorType == BDRequestErrorDataFail){
        [self.backImageView setHidden:YES];
        [self.textLabel setHidden:YES];
        self.animationView.hidden = NO;
        [self.animationView reloading];
        //做一个延迟效果，
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if([self.delegate respondsToSelector:@selector(coverViewReloadAction:)]){
                [self.delegate coverViewReloadAction:self];
            }
        });
    }
}


/**
 添加导航条到coverview 上
 */
- (void)addTopNaviBarWithColorValue:(UIColor*)color
{
    BDNavigationView *navigationView = [BDNavigationView navigationView];
    UIColor *backColor = [UIColor whiteColor];
    if(color){
        backColor = color;
    }
    navigationView.backgroundColor = backColor;
    self.navigationView = navigationView;
    __weak typeof(self)weakself = self;
    navigationView.navigationBackAction = ^{
        if([weakself.delegate respondsToSelector:@selector(coverViewBackAction:)]){
            [weakself.delegate coverViewBackAction:weakself];
        }
    };
    [self addSubview:navigationView];
    [self bringSubviewToFront:navigationView];
}

- (void)showErrorViewWithErrorNumber:(BDRequestErrorType)errorType
{
    [self showErrorViewWithErrorNumber:errorType errorMsg:nil];
}

- (void)showErrorViewWithErrorNumber:(BDRequestErrorType)errorType errorMsg:(NSString*)errorMsg
{
    _errorType = errorType;
    self.animationView.hidden = YES;
    [self.animationView stopLoading];
    self.backImageView.hidden = NO;
    self.textLabel.hidden = NO;
    NSString *showText = @"";
    NSString *imageName = @"empty_no_network";
    switch (errorType) {
        case BDRequestErrorTimeOut:
            showText = @"请求超时,点击重新加载";
            break;
        case BDRequestErrorOther:
            showText = @"服务器开小差，点击重新加载";
            break;
        case BDRequestErrorNetLow:
            showText = @"当前网络不给力，点击重新加载";
            break;
        case BDRequestErrorDataFail:
        {
            if(errorMsg){
                showText = errorMsg;
            }else{
                showText = @"服务器开小差";
            }
            imageName = @"empty_no_data";
        }
            break;
        case BDRequestErrorTokenInvalid:
            showText = @"您的账号在其他设备登录";
            self.userInteractionEnabled = NO;
            imageName = @"empty_login_other";
            break;
        case BDRequestErrorDataDeleted:
            showText = @"数据已被作者删除了";
            imageName = @"empty_no_data";
            break;
        case BDRequestErrorVersionLow:
            showText = @"当前版本过低，请前往App Store下载最新版本";
            imageName = @"empty_profession";
           
            break;
        case BDRequestErrorFuncUnopened:
            showText = @"功能还未开放，敬请期待";
            imageName = @"empty_profession";
            break;
        case BDRequestErrorDownlined:
            showText = @"抱歉，您访问的内容已经下线\n请访问其他内容吧！";
            imageName = @"empty_downlined";
            break;
        case BDRequestErrorUserSealUp:
            imageName = @"empty_sealup";
            showText = @"该用户因为违规，已经被封号\n请移步，查看其他用户信息。";
            break;
        case BDRequestErrorUserNoExist:
            imageName = @"empty_no_data";
            showText = @"用户不存在";
            break;
        case BDRequestErrorDataException:
            imageName = @"empty_no_data";
            if(errorMsg){
                showText = errorMsg;
            }else{
                showText = @"数据出现异常";
            }
            break;
        default:
            break;
    }
    self.textLabel.text = showText;
    UIImage *image = [UIImage imageNamed:imageName];
    
    self.backImageView.image = image;
    
    
}



@end
