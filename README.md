# CoverLoadingDemo
系统级别的遮盖加载

如何使用:
一般都是伴随着网络请求 
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

//如果出现网络加载失败，

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
