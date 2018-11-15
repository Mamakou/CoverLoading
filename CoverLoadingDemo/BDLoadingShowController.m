//
//  BDLoadingShowController.m
//  CoverLoadingDemo
//
//  Created by goviewtech on 2018/11/15.
//  Copyright © 2018 goviewtech. All rights reserved.
//

#import "BDLoadingShowController.h"
#import "UIView+AutoLayout.h"
#import "BDLoadingCoverView.h"

@interface BDLoadingShowController ()<BDLoadingCoverViewDelegate>

@end

@implementation BDLoadingShowController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self loadUIMessage];
    if(self.showMulit){
        [self loadMuiltOne];
    }else{
        [self loadDetailData];
    }
}

- (void)loadUIMessage
{
    self.title = @"详情页面";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *centerLabel = [[UILabel alloc]init];
    centerLabel.text = @"这里就是详情结果，我用的自动布局是UIView+AutoLayout，感觉比masroy啥的要更加轻量吧，或者是个人认为\n模仿网络加载再展示详情结果";
    centerLabel.numberOfLines = 0;
    [self.view addSubview:centerLabel];
    [centerLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [centerLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [centerLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    
}

- (void)loadDetailData
{
    BDLoadingCoverView *cover = [[BDLoadingCoverView alloc]initWithFrame:self.view.bounds];
    cover.sgin = 1;
    [cover showCoverToView:self.view animation:self.type];
    cover.delegate = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if(self.showFail){
            [cover showErrorViewWithErrorNumber:BDRequestErrorTimeOut errorMsg:@"请求超时"];
            return ;
        }
        [cover hideCover];
    });
}

- (void)loadMuiltOne
{
    BDLoadingCoverView *cover = [[BDLoadingCoverView alloc]initWithFrame:self.view.bounds];
    cover.sgin = 1;
    [cover showCoverToView:self.view animation:BDLoadingAnimationSystem];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [cover hideCover];
        [self loadMuiltTwo];
    });
}

- (void)loadMuiltTwo
{
    BDLoadingCoverView *cover = [[BDLoadingCoverView alloc]initWithFrame:self.view.bounds];
    cover.sgin = 2;
    [cover showCoverToView:self.view animation:BDLoadingAnimationMayiSenLing];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [cover hideCover];
    });
}



#pragma mark - BDLoadingCoverViewDelegate
- (void)coverViewBackAction:(BDLoadingCoverView *)loadView
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)coverViewReloadAction:(BDLoadingCoverView *)loadView
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [loadView hideCover];
    });
    
}



@end
