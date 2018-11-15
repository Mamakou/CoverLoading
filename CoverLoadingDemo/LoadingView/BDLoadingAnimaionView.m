//
//  BDLoadingAnimaionView.m
//  CoverLoadingDemo
//
//  Created by goviewtech on 2018/11/14.
//  Copyright © 2018 goviewtech. All rights reserved.
//

#import "BDLoadingAnimaionView.h"
#import <FLAnimatedImageView.h>
#import <FLAnimatedImage.h>
#import "UIView+AutoLayout.h"
#import "BDMayiSenlingView.h"



@interface BDLoadingAnimaionView ()

@property (nonatomic,strong)UIActivityIndicatorView *indicatorView;
@property (nonatomic,strong)FLAnimatedImageView *imageView;
@property (nonatomic,weak)BDMayiSenlingView *senlinView;


@property (nonatomic,assign)BDLoadingAnimationType animationType;



@end


@implementation BDLoadingAnimaionView

-(FLAnimatedImageView *)imageView
{
    if(!_imageView){
        _imageView = [[FLAnimatedImageView alloc]init];
    }
    return _imageView;
}

-(UIActivityIndicatorView *)indicatorView
{
    if(!_indicatorView){
        _indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
    }
    return _indicatorView;
}

- (void)reloading
{
    switch (self.animationType) {
        case BDLoadingAnimationSystem:
            [self.indicatorView startAnimating];
            break;
         case BDLoadingAnimationImages:
        {
            NSString *path = [[NSBundle mainBundle] pathForResource:@"Loading9" ofType:@"gif"];
            NSData *data = [[NSData alloc]initWithContentsOfFile:path];
            FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:data];
            self.imageView.animatedImage = image;
        }
            break;
         case BDLoadingAnimationMayiSenLing:
            [self.senlinView start];
            break;
            
        default:
            break;
    }
    
}

- (void)stopLoading
{
    switch (self.animationType) {
        case BDLoadingAnimationSystem:
            [self.indicatorView stopAnimating];
            break;
         case BDLoadingAnimationImages:
            self.imageView.image = [UIImage new];
            break;
         case BDLoadingAnimationMayiSenLing:
            [self.senlinView stop];
            break;
        default:
            break;
    }
    
}

- (void)showAnimationType:(BDLoadingAnimationType)animationType
{
    self.animationType = animationType;
    
    switch (animationType) {
        case BDLoadingAnimationSystem:
        {
            [self addSubview:self.indicatorView];
            [self.indicatorView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
            [self.indicatorView autoAlignAxisToSuperviewAxis:ALAxisVertical];
            [self.indicatorView startAnimating];
        }
            break;
        case BDLoadingAnimationImages:
        {
        
            NSString *path = [[NSBundle mainBundle] pathForResource:@"Loading9" ofType:@"gif"];
            NSData *data = [[NSData alloc]initWithContentsOfFile:path];
            FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:data];
            self.imageView.animatedImage = image;
            [self addSubview:self.imageView];
            [self.imageView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
            [self.imageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
        }
            break;
        case BDLoadingAnimationMayiSenLing:
        {
            self.backgroundColor = [UIColor colorWithRed:57/255.0 green:190/255.0 blue:114/255.0 alpha:1];
            CGFloat width = 100;
            CGFloat height = 100;
            CGFloat x = (self.bounds.size.width-width)*0.5;
            CGFloat y = (self.bounds.size.height-height)*0.5;
            
            BDMayiSenlingView *senlingView = [[BDMayiSenlingView alloc]initWithFrame:CGRectMake(x, y, width, height)];
            self.senlinView = senlingView;
            [self addSubview:senlingView];
            [senlingView start];
        }
            
            break;
        default:
            break;
    }
}


@end
