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
#import "CYImageEditor.h"
#import "UIView+YYAdd.h"
#import "UIDevice+YYAdd.h"

@interface CYHomeViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,CYImageEditorDelegate>
@property (nonatomic,strong) UIButton *editorBtn;
@property (nonatomic,strong) UIButton *cameraBtn;
@property (nonatomic,strong) UIButton *settingBtn;
@end

@implementation CYHomeViewController

#pragma mark - system

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNav];
    [self setupUI];
}

- (void)setupNav {
 
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title"]];
    titleImageView.bounds = CGRectMake(0, 0, titleImageView.image.size.width, titleImageView.image.size.height);
    self.navigationItem.titleView = titleImageView;

    //    [self.navigationController setNavigationBarHidden:YES];

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"home_info" isLeft:YES target:self action:@selector(leftItemClicked)];

}

- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat radius = 3;
    
    //editorBtn
    self.editorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.editorBtn.layer.cornerRadius = radius;
    self.editorBtn.layer.masksToBounds = YES;
    [self.editorBtn setImage:[UIImage imageNamed:@"home_beauty"] forState:UIControlStateNormal];
    [self.editorBtn setBackgroundImage:[UIImage createImageWithColor:CommonWhite size:CGSizeMake(1, 1)] forState:UIControlStateNormal];
    [self.view addSubview:self.editorBtn];

    //cameraBtn
    self.cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cameraBtn.layer.cornerRadius = radius;
    self.cameraBtn.layer.masksToBounds = YES;
    [self.cameraBtn setImage:[UIImage imageNamed:@"home_camera"] forState:UIControlStateNormal];
    [self.cameraBtn setBackgroundImage:[UIImage createImageWithColor:CommonWhite size:CGSizeMake(1, 1)] forState:UIControlStateNormal];
    [self.view addSubview:self.cameraBtn];

    //settingBtn
    self.settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.settingBtn.layer.cornerRadius = radius;
    self.settingBtn.layer.masksToBounds = YES;
    [self.settingBtn setImage:[UIImage imageNamed:@"home_setting"] forState:UIControlStateNormal];
    [self.settingBtn setBackgroundImage:[UIImage createImageWithColor:CommonWhite size:CGSizeMake(1, 1)] forState:UIControlStateNormal];
    [self.view addSubview:self.settingBtn];

    //target
    [self.editorBtn addTarget:self action:@selector(editorBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.cameraBtn addTarget:self action:@selector(cameraBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.settingBtn addTarget:self action:@selector(settingBtnClicked) forControlEvents:UIControlEventTouchUpInside];
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    //common
    CGFloat offset = 50;
    CGFloat margin = 10;
    
    CGFloat btnX = margin;
    CGFloat btnH = (self.view.height - cy_NavbarHeight - cy_StatusBarHeight - cy_HomebarHeight - margin * 4) / 3;
    CGFloat btnW = self.view.width - margin * 2;
    
    //editorBtn
    CGFloat editorBtnY = margin + cy_NavbarHeight + cy_StatusBarHeight;
    CGFloat editorBtnH = btnH + offset / 2;
    self.editorBtn.frame = CGRectMake(btnX, editorBtnY, btnW, editorBtnH);
    
    CAShapeLayer *albumMaskLayer = [CAShapeLayer layer];
    UIBezierPath *albumMaskPath = [UIBezierPath bezierPath];
    
    CGFloat editorBtnMinX = CGRectGetMinX(self.editorBtn.bounds);
    CGFloat editorBtnMaxX = CGRectGetMaxX(self.editorBtn.bounds);
    CGFloat editorBtnMinY = CGRectGetMinY(self.editorBtn.bounds);
    CGFloat editorBtnMaxY = CGRectGetMaxY(self.editorBtn.bounds);
    
    [albumMaskPath moveToPoint:CGPointMake(editorBtnMinX, editorBtnMinY)];
    [albumMaskPath addLineToPoint:CGPointMake(editorBtnMaxX, editorBtnMinY)];
    [albumMaskPath addLineToPoint:CGPointMake(editorBtnMaxX, editorBtnMaxY)];
    [albumMaskPath addLineToPoint:CGPointMake(editorBtnMinX, editorBtnMaxY - offset)];
    [albumMaskPath addLineToPoint:CGPointMake(editorBtnMinX, editorBtnMinY)];
    albumMaskLayer.path = albumMaskPath.CGPath;
    self.editorBtn.layer.mask = albumMaskLayer;
    
    
    //cameraBtn
    CGFloat cameraBtnY = CGRectGetMaxY(self.editorBtn.frame)+ margin - offset;
    CGFloat cameraBtnH = btnH + offset;

    self.cameraBtn.frame = CGRectMake(btnX, cameraBtnY, btnW, cameraBtnH);
    
    CAShapeLayer *cameraMaskLayer = [CAShapeLayer layer];
    UIBezierPath *cameraMaskPath = [UIBezierPath bezierPath];
    
    CGFloat cameraBtnMinX = CGRectGetMinX(self.cameraBtn.bounds);
    CGFloat cameraBtnMaxX = CGRectGetMaxX(self.cameraBtn.bounds);
    CGFloat cameraBtnMinY = CGRectGetMinY(self.cameraBtn.bounds);
    CGFloat cameraBtnMaxY = CGRectGetMaxY(self.cameraBtn.bounds);
    
    [cameraMaskPath moveToPoint:CGPointMake(cameraBtnMinX, cameraBtnMinY)];
    [cameraMaskPath addLineToPoint:CGPointMake(cameraBtnMaxX, cameraBtnMinY + offset)];
    [cameraMaskPath addLineToPoint:CGPointMake(cameraBtnMaxX, cameraBtnMaxY - offset)];
    [cameraMaskPath addLineToPoint:CGPointMake(cameraBtnMinX, cameraBtnMaxY)];
    [cameraMaskPath addLineToPoint:CGPointMake(cameraBtnMinX, cameraBtnMinY)];
    cameraMaskLayer.path = cameraMaskPath.CGPath;
    self.cameraBtn.layer.mask = cameraMaskLayer;
    
    
    //settingBtn
    CGFloat settingY = CGRectGetMaxY(self.cameraBtn.frame) + margin - offset;
    CGFloat settingH = btnH + offset / 2;

    self.settingBtn.frame = CGRectMake(btnX, settingY, btnW, settingH);
    
    CAShapeLayer *settingMaskLayer = [CAShapeLayer layer];
    UIBezierPath *settingMaskPath = [UIBezierPath bezierPath];
    
    CGFloat settingBtnMinX = CGRectGetMinX(self.settingBtn.bounds);
    CGFloat settingBtnMaxX = CGRectGetMaxX(self.settingBtn.bounds);
    CGFloat settingBtnMinY = CGRectGetMinY(self.settingBtn.bounds);
    CGFloat settingBtnMaxY = CGRectGetMaxY(self.settingBtn.bounds);
    
    [settingMaskPath moveToPoint:CGPointMake(settingBtnMinX, settingBtnMinY + offset)];
    [settingMaskPath addLineToPoint:CGPointMake(settingBtnMaxX, settingBtnMinY)];
    [settingMaskPath addLineToPoint:CGPointMake(settingBtnMaxX, settingBtnMaxY)];
    [settingMaskPath addLineToPoint:CGPointMake(settingBtnMinX, settingBtnMaxY)];
    [settingMaskPath addLineToPoint:CGPointMake(settingBtnMinX, settingBtnMinY + offset)];
    settingMaskLayer.path = settingMaskPath.CGPath;
    self.settingBtn.layer.mask = settingMaskLayer;
}

#pragma mark - itemClicked 

- (void)leftItemClicked {
    CYContactViewController *contactVC = [[CYContactViewController alloc] init];
    CYNavigationController *nav = [[CYNavigationController alloc] initWithRootViewController:contactVC];
    nav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - btnClicked

- (void)editorBtnClicked {

#warning test code
    UIImage *originalImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"testImg.jpg" ofType:nil]];
    CYImageEditorImage *imageModel = [[CYImageEditorImage alloc] initWithImage:originalImage];

    CYImageEditor *editorVC = [[CYImageEditor alloc] initWithImage:imageModel];
    editorVC.delegate = self;
    [self.navigationController pushViewController:editorVC animated:YES];
    return;

    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    
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

#pragma mark - imagePickerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

    CYLog(@"%@",info);

    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    CYLog(@"editedImage Size is %@",[NSValue valueWithCGSize:editedImage.size]);
    CYLog(@"originalImage Size is %@",[NSValue valueWithCGSize:originalImage.size]);

    [picker dismissViewControllerAnimated:YES completion:nil];

    CYImageEditorImage *imageModel = [[CYImageEditorImage alloc] initWithImage:originalImage];

    CYImageEditor *editorVC = [[CYImageEditor alloc] initWithImage:imageModel];
    editorVC.delegate = self;
    [self.navigationController pushViewController:editorVC animated:YES];
}

#pragma mark - CYImageEditorDelegate

- (void)CYImageEditor:(CYImageEditor *)editor didFinishEditingWithImage:(UIImage *)image {

}

- (void)CYImageEditorDidCancel:(CYImageEditor *)editor {

}
@end
