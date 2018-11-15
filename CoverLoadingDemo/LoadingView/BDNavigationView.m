//
//  BDNavigationView.m
//  QiXiuBaoDian
//
//  Created by ben on 2018/4/4.
//  Copyright © 2018年 guanwei. All rights reserved.
//

#import "BDNavigationView.h"
#import "UIView+AutoLayout.h"

#define SCREEN_WIDTH UIScreen.mainScreen.bounds.size.width
#define SCREEN_HEIGHT UIScreen.mainScreen.bounds.size.height

@interface BDNavigationView ()

@property (nonatomic,weak)UIImageView *backgroundImageView;

@property (nonatomic,weak)UILabel *naviTitleLabel;

@property (nonatomic,weak)UIButton *backBtn;



@end

@implementation BDNavigationView

+ (instancetype)navigationView
{
    return [[self alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor clearColor];
         
        UIImageView *backgroundImageView = [[UIImageView alloc]initWithFrame:frame];
        self.backgroundImageView = backgroundImageView;
        [self addSubview:backgroundImageView];
        
        UILabel *naviTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height, SCREEN_WIDTH, 44)];
        naviTitleLabel.textAlignment = NSTextAlignmentCenter;
        naviTitleLabel.textColor = [UIColor colorWithRed:1.0*51/255 green:1.0*51/255 blue:1.0*51/255 alpha:1.0];
        naviTitleLabel.font = [UIFont systemFontOfSize:16];
        self.naviTitleLabel = naviTitleLabel;
        [self addSubview:naviTitleLabel];
        
        NSString *backTitle = @"返回";
        CGFloat width = [backTitle sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}].width;
       
        CGFloat btnWidth = width+13+10;
        if (btnWidth <40){
            btnWidth = 40;
        }
        
        
        UIButton* backButton = [[UIButton alloc]initWithFrame:CGRectMake(8, [UIApplication sharedApplication].statusBarFrame.size.height, btnWidth, 44)];
        self.backBtn = backButton;
        backButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [backButton setTitleColor:[UIColor colorWithRed:1.0*51/255 green:1.0*51/255 blue:1.0*51/255 alpha:1.0] forState:UIControlStateNormal];
        [backButton setTitle:backTitle forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"common_return_black"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(clickBackToHome) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backButton];
        
        UIView *botLineView = [[UIView alloc]init];
        botLineView.alpha = 0;
        _bottomLineView = botLineView;
        [self addSubview:botLineView];
        botLineView.backgroundColor = [UIColor colorWithRed:1.0*225/255 green:1.0*225/255 blue:1.0*225/255 alpha:1.0];
        [botLineView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
        [botLineView autoSetDimension:ALDimensionHeight toSize:0.5];
    
    }
    return self;
}

- (void)clickBackToHome
{
    if(self.navigationBackAction){
        self.navigationBackAction();
    }
}



@end
