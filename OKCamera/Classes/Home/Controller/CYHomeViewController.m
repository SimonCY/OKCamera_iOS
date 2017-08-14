//
//  CYHomeViewController.m
//  OKCamera
//
//  Created by Chenyan on 2017/8/13.
//  Copyright © 2017年 Chenyan. All rights reserved.
//

#import "CYHomeViewController.h"
#import "iPhoneMacro.h"

@interface CYHomeViewController ()
@property (nonatomic,strong) UIButton *albumBtn;
@property (nonatomic,strong) UIButton *cameraBtn;
@property (nonatomic,strong) UIButton *settingBtn;
@end

@implementation CYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"主页";
 
    
    [self setupUI];
}

- (void)setupUI {
    
    self.view.backgroundColor = CommonWhite;
    
    //common
    CGFloat offset = 150;
    CGFloat margin = 10;
    
    CGFloat btnX = margin;
    CGFloat btnH = (self.view.bounds.size.height - margin * 4 - 64) / 3;
    CGFloat btnW = self.view.bounds.size.width - margin * 2;
    
    //albumBtn
    CGFloat albumBtnY = margin + 64 ;
    CGFloat albumBtnH = btnH ;
    
    self.albumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.albumBtn.frame = CGRectMake(btnX, albumBtnY, btnW, albumBtnH);
    self.albumBtn.backgroundColor = cy_RandomColor;
    self.albumBtn.layer.borderWidth = 3;
    
    [self.albumBtn setTitle:@"Beautify" forState:UIControlStateNormal];
    [self.view addSubview:self.albumBtn];
    
    CAShapeLayer *albumMaskLayer = [CAShapeLayer layer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(CGRectGetMinX(self.albumBtn.frame), CGRectGetMinY(self.albumBtn.frame))];
    [path addLineToPoint:CGPointMake(CGRectGetMaxX(self.albumBtn.frame), CGRectGetMinY(self.albumBtn.frame))];
    [path addLineToPoint:CGPointMake(CGRectGetMaxX(self.albumBtn.frame), CGRectGetMaxY(self.albumBtn.frame) + offset / 2)];
    [path addLineToPoint:CGPointMake(CGRectGetMinX(self.albumBtn.frame), CGRectGetMaxY(self.albumBtn.frame) - offset / 2)];
    [path addLineToPoint:CGPointMake(CGRectGetMinX(self.albumBtn.frame), CGRectGetMinY(self.albumBtn.frame))];
    albumMaskLayer.path = path.CGPath;
    self.albumBtn.layer.mask = albumMaskLayer;
    
    
    //cameraBtn
    CGFloat cameraBtnY = CGRectGetMaxY(self.albumBtn.frame)+ margin;
    CGFloat cameraBtnH = btnH;
    
    self.cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cameraBtn.frame = CGRectMake(btnX, cameraBtnY, btnW, cameraBtnH);
    self.cameraBtn.backgroundColor = cy_RandomColor;
    self.cameraBtn.layer.borderWidth = 2;
    [self.cameraBtn setTitle:@"Camera" forState:UIControlStateNormal];
    [self.view addSubview:self.cameraBtn];
    
    //settingBtn
    CGFloat settingY = CGRectGetMaxY(self.cameraBtn.frame)+ margin;
    CGFloat settingH = btnH ;
    self.settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.settingBtn.frame = CGRectMake(btnX, settingY, btnW, settingH);
    self.settingBtn.backgroundColor = cy_RandomColor;
    self.settingBtn.layer.borderWidth = 2;
    [self.settingBtn setTitle:@"Setting" forState:UIControlStateNormal];
    [self.view addSubview:self.settingBtn];
    
    
}

@end
