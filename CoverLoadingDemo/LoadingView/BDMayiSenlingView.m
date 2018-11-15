//
//  BDMayiSenlingView.m
//  CoverLoadingDemo
//
//  Created by goviewtech on 2018/11/15.
//  Copyright © 2018 goviewtech. All rights reserved.
//

#import "BDMayiSenlingView.h"

@interface BDMayiSenlingView ()

@property(nonatomic,strong) CAShapeLayer * shapeLayer;
@property(nonatomic,strong) CADisplayLink * displayLink;

@property (nonatomic,assign)CGFloat moveValue;
@property (nonatomic,assign)CGFloat moveSpeed;

@property (nonatomic,assign)BOOL directionUp;

@end


@implementation BDMayiSenlingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpBaseUIMessage];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self setUpBaseUIMessage];
    }
    return self;
}

- (void)setUpBaseUIMessage
{
    self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.0];
    UIImageView *treeImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tree"]];
    treeImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:treeImageView];
    
    self.shapeLayer = [[CAShapeLayer alloc]init];
    self.shapeLayer.fillColor = [UIColor colorWithRed:57/255.0 green:190/255.0 blue:114/255.0 alpha:0.5].CGColor;
    [self.layer addSublayer:self.shapeLayer];
    
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(setShape)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    //移动的速度设置
    self.moveValue =  0;
    self.moveSpeed = 0.5;
    
}

- (void)start
{
    if(self.displayLink == nil){
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(setShape)];
        [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)stop
{
    if(self.displayLink){
        [self.displayLink invalidate];
        self.displayLink = nil;
    }
}

- (void)setShape
{
    if (self.moveValue >= self.bounds.size.height-10) {
        self.directionUp = YES;
    }else if (self.moveValue <= 0){
        self.directionUp = NO;
    }
    if (self.directionUp == YES) {
        self.moveValue -= self.moveSpeed;
    }else{
        self.moveValue += self.moveSpeed;
    }
    [self updateShapePath];
}

- (void)updateShapePath
{
    CGMutablePathRef  path =  CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, self.moveValue);
    for (int i = 0; i < self.bounds.size.width; i ++)  {
        CGPathAddLineToPoint(path, NULL, i, self.moveValue );
    }
    CGPathAddLineToPoint(path, NULL, self.bounds.size.width, 0 );
    CGPathAddLineToPoint(path, NULL, 0, 0);
    CGPathCloseSubpath(path);
    _shapeLayer.path = path;
    CGPathRelease(path);
}



@end
