//
//  CYHomeViewController.m
//  OKCamera
//
//  Created by Chenyan on 2017/8/13.
//  Copyright © 2017年 Chenyan. All rights reserved.
//

#import "CYHomeViewController.h"
#import "iPhoneMacro.h"
#import "UIImage+CYExtension.h"
#import "CYSettingViewController.h"
#import "CYNavigationController.h"
#import "UIBarButtonItem+Extension.h"
#import "CYContactViewController.h"

@interface CYHomeViewController ()
@property (nonatomic,strong) UIButton *albumBtn;
@property (nonatomic,strong) UIButton *cameraBtn;
@property (nonatomic,strong) UIButton *settingBtn;
@end

@implementation CYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNav];
    [self setupUI];
}

- (void)setupNav {

    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"OKCamera";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont italicSystemFontOfSize:15];
    titleLabel.frame = CGRectMake(0, 0, 50, 15);

    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title"]];
    titleImageView.bounds = CGRectMake(0, 0, titleImageView.image.size.width, titleImageView.image.size.height);
    self.navigationItem.titleView = titleImageView;

    //    [self.navigationController setNavigationBarHidden:YES];

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"home_info" isLeft:YES target:self action:@selector(leftItemClicked)];
}

- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //common
    CGFloat offset = 50;
    CGFloat margin = 10;
    CGFloat radius = 3;
    
    CGFloat btnX = margin;
    CGFloat btnH = (self.view.bounds.size.height - 64 - margin * 4) / 3;
    CGFloat btnW = self.view.bounds.size.width - margin * 2;
    
    //albumBtn
    CGFloat albumBtnY = margin + 64 ;
    CGFloat albumBtnH = btnH + offset / 2;
    
    self.albumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.albumBtn.frame = CGRectMake(btnX, albumBtnY, btnW, albumBtnH);
//    [self.albumBtn setTitle:@"Beautify" forState:UIControlStateNormal];
    [self.albumBtn setImage:[UIImage imageNamed:@"home_beauty"] forState:UIControlStateNormal];
    [self.albumBtn setBackgroundImage:[UIImage createImageWithColor:CommonWhite size:CGSizeMake(1, 1)] forState:UIControlStateNormal];
    [self.view addSubview:self.albumBtn];
    self.albumBtn.titleLabel.font = [UIFont boldSystemFontOfSize:30];
    
    CAShapeLayer *albumMaskLayer = [CAShapeLayer layer];
    UIBezierPath *albumMaskPath = [UIBezierPath bezierPath];

    [albumMaskPath moveToPoint:CGPointMake(CGRectGetMinX(self.albumBtn.bounds), CGRectGetMinY(self.albumBtn.bounds))];
    [albumMaskPath addLineToPoint:CGPointMake(CGRectGetMaxX(self.albumBtn.bounds), CGRectGetMinY(self.albumBtn.bounds))];
    [albumMaskPath addLineToPoint:CGPointMake(CGRectGetMaxX(self.albumBtn.bounds), CGRectGetMaxY(self.albumBtn.bounds))];
    [albumMaskPath addLineToPoint:CGPointMake(CGRectGetMinX(self.albumBtn.bounds), CGRectGetMaxY(self.albumBtn.bounds) - offset)];
    [albumMaskPath addLineToPoint:CGPointMake(CGRectGetMinX(self.albumBtn.bounds), CGRectGetMinY(self.albumBtn.bounds))];
    albumMaskLayer.path = albumMaskPath.CGPath;
    self.albumBtn.layer.mask = albumMaskLayer;
    
    self.albumBtn.layer.cornerRadius = radius;
    self.albumBtn.layer.masksToBounds = YES;
    
    //cameraBtn
    CGFloat cameraBtnY = CGRectGetMaxY(self.albumBtn.frame)+ margin - offset;
    CGFloat cameraBtnH = btnH + offset;
    
    self.cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cameraBtn.frame = CGRectMake(btnX, cameraBtnY, btnW, cameraBtnH);
//    [self.cameraBtn setTitle:@"Camera" forState:UIControlStateNormal];
    [self.cameraBtn setImage:[UIImage imageNamed:@"home_camera"] forState:UIControlStateNormal];
    [self.cameraBtn setBackgroundImage:[UIImage createImageWithColor:CommonWhite size:CGSizeMake(1, 1)] forState:UIControlStateNormal];
    [self.view addSubview:self.cameraBtn];
    self.cameraBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25];
    
    CAShapeLayer *cameraMaskLayer = [CAShapeLayer layer];
    UIBezierPath *cameraMaskPath = [UIBezierPath bezierPath];
    
    [cameraMaskPath moveToPoint:CGPointMake(CGRectGetMinX(self.cameraBtn.bounds), CGRectGetMinY(self.cameraBtn.bounds))];
    [cameraMaskPath addLineToPoint:CGPointMake(CGRectGetMaxX(self.cameraBtn.bounds), CGRectGetMinY(self.cameraBtn.bounds) + offset)];
    [cameraMaskPath addLineToPoint:CGPointMake(CGRectGetMaxX(self.cameraBtn.bounds), CGRectGetMaxY(self.cameraBtn.bounds) - offset)];
    [cameraMaskPath addLineToPoint:CGPointMake(CGRectGetMinX(self.cameraBtn.bounds), CGRectGetMaxY(self.cameraBtn.bounds))];
    [cameraMaskPath addLineToPoint:CGPointMake(CGRectGetMinX(self.cameraBtn.bounds), CGRectGetMinY(self.cameraBtn.bounds))];
    cameraMaskLayer.path = cameraMaskPath.CGPath;
    self.cameraBtn.layer.mask = cameraMaskLayer;
    
    self.cameraBtn.layer.cornerRadius = radius;
    self.cameraBtn.layer.masksToBounds = YES;
    
    //settingBtn
    CGFloat settingY = CGRectGetMaxY(self.cameraBtn.frame) + margin - offset;
    CGFloat settingH = btnH + offset / 2;
    self.settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.settingBtn.frame = CGRectMake(btnX, settingY, btnW, settingH);
//    [self.settingBtn setTitle:@"Setting" forState:UIControlStateNormal];
    [self.settingBtn setImage:[UIImage imageNamed:@"home_setting"] forState:UIControlStateNormal];
    [self.settingBtn setBackgroundImage:[UIImage createImageWithColor:CommonWhite size:CGSizeMake(1, 1)] forState:UIControlStateNormal];
    [self.view addSubview:self.settingBtn];
    self.settingBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    
    CAShapeLayer *settingMaskLayer = [CAShapeLayer layer];
    UIBezierPath *settingMaskPath = [UIBezierPath bezierPath];
    
    [settingMaskPath moveToPoint:CGPointMake(CGRectGetMinX(self.settingBtn.bounds), CGRectGetMinY(self.settingBtn.bounds) + offset)];
    [settingMaskPath addLineToPoint:CGPointMake(CGRectGetMaxX(self.settingBtn.bounds), CGRectGetMinY(self.settingBtn.bounds))];
    [settingMaskPath addLineToPoint:CGPointMake(CGRectGetMaxX(self.settingBtn.bounds), CGRectGetMaxY(self.settingBtn.bounds))];
    [settingMaskPath addLineToPoint:CGPointMake(CGRectGetMinX(self.settingBtn.bounds), CGRectGetMaxY(self.settingBtn.bounds))];
    [settingMaskPath addLineToPoint:CGPointMake(CGRectGetMinX(self.settingBtn.bounds), CGRectGetMinY(self.settingBtn.bounds) + offset)];
    settingMaskLayer.path = settingMaskPath.CGPath;
    self.settingBtn.layer.mask = settingMaskLayer;
    
    self.settingBtn.layer.cornerRadius = radius;
    self.settingBtn.layer.masksToBounds = YES;
    
    //target
    [self.albumBtn addTarget:self action:@selector(albumBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.cameraBtn addTarget:self action:@selector(cameraBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.settingBtn addTarget:self action:@selector(settingBtnClicked) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - itemClicked 
- (void)leftItemClicked {
    CYContactViewController *contactVC = [[CYContactViewController alloc] init];
    [self.navigationController pushViewController:contactVC animated:YES];
}

#pragma mark - btnClicked
- (void)albumBtnClicked {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)cameraBtnClicked {
    
}

- (void)settingBtnClicked {
    
    CYSettingViewController *settingVC = [[CYSettingViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

@end
