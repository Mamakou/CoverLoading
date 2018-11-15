//
//  ViewController.m
//  CoverLoadingDemo
//
//  Created by goviewtech on 2018/11/14.
//  Copyright © 2018 goviewtech. All rights reserved.
//

#import "ViewController.h"
#import "BDLoadingShowController.h"
#import "BDLoadingCoverView.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setUpBaseUIMessage];
    
    
}

- (void)setUpBaseUIMessage
{
    self.title = @"首页";
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    if(indexPath.row == 0){
        cell.textLabel.text = @"系统样式";
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"图片样式";
    }else if(indexPath.row == 2){
        cell.textLabel.text = @"蚂蚁森林";
    }else if (indexPath.row == 3){
        cell.textLabel.text = @"加载失败重新加载";
    }else{
        cell.textLabel.text = @"多个遮盖";
    }
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //这里只是模仿写死的，真实场景是根据产品经理要求来显示加载方式，就拿支付宝说:蚂蚁森林和蚂蚁庄园的加载动画就不一样
    //甚至同一个页面出现的加载遮盖也有不一样的，这样的页面一般有很多个接口才会用的不同的加载方式
    BDLoadingAnimationType type = BDLoadingAnimationSystem;
    BOOL isLoadFail = NO;
    BOOL isLoadMuitl = NO;
    if(indexPath.row == 1){
        type = BDLoadingAnimationImages;
    }else if (indexPath.row == 2){
        type = BDLoadingAnimationMayiSenLing;
    }else if (indexPath.row == 3){
        isLoadFail = YES;
    }else if (indexPath.row == 4){
        isLoadMuitl = YES;
    }
    BDLoadingShowController *showVc = [[BDLoadingShowController alloc]init];
    showVc.type = type;
    showVc.showFail = isLoadFail;
    showVc.showMulit = isLoadMuitl;
    [self.navigationController pushViewController:showVc animated:YES];
    
}






@end
