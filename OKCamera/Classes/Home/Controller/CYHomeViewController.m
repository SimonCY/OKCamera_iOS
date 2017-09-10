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

@interface CYHomeViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,CYImageEditorDelegate>
@property (nonatomic,strong) UIButton *editorBtn;
@property (nonatomic,strong) UIButton *cameraBtn;
@property (nonatomic,strong) UIButton *settingBtn;
@end

@implementation CYHomeViewController

#pragma mark - view cycle

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
    
    //editorBtn
    CGFloat editorBtnY = margin + 64 ;
    CGFloat editorBtnH = btnH + offset / 2;
    
    self.editorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.editorBtn.frame = CGRectMake(btnX, editorBtnY, btnW, editorBtnH);
    self.editorBtn.layer.cornerRadius = radius;
    self.editorBtn.layer.masksToBounds = YES;
    [self.editorBtn setImage:[UIImage imageNamed:@"home_beauty"] forState:UIControlStateNormal];
    [self.editorBtn setBackgroundImage:[UIImage createImageWithColor:CommonWhite size:CGSizeMake(1, 1)] forState:UIControlStateNormal];
    [self.view addSubview:self.editorBtn];

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
    
    self.cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cameraBtn.layer.cornerRadius = radius;
    self.cameraBtn.layer.masksToBounds = YES;
    self.cameraBtn.frame = CGRectMake(btnX, cameraBtnY, btnW, cameraBtnH);
    [self.cameraBtn setImage:[UIImage imageNamed:@"home_camera"] forState:UIControlStateNormal];
    [self.cameraBtn setBackgroundImage:[UIImage createImageWithColor:CommonWhite size:CGSizeMake(1, 1)] forState:UIControlStateNormal];
    [self.view addSubview:self.cameraBtn];

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
    self.settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.settingBtn.frame = CGRectMake(btnX, settingY, btnW, settingH);
    self.settingBtn.layer.cornerRadius = radius;
    self.settingBtn.layer.masksToBounds = YES;
    [self.settingBtn setImage:[UIImage imageNamed:@"home_setting"] forState:UIControlStateNormal];
    [self.settingBtn setBackgroundImage:[UIImage createImageWithColor:CommonWhite size:CGSizeMake(1, 1)] forState:UIControlStateNormal];
    [self.view addSubview:self.settingBtn];

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


    //target
    [self.editorBtn addTarget:self action:@selector(editorBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.cameraBtn addTarget:self action:@selector(cameraBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.settingBtn addTarget:self action:@selector(settingBtnClicked) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - itemClicked 

- (void)leftItemClicked {
    CYContactViewController *contactVC = [[CYContactViewController alloc] init];
    [self.navigationController pushViewController:contactVC animated:YES];
}

#pragma mark - btnClicked

- (void)editorBtnClicked {
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
//    [self presentViewController:editorVC animated:YES completion:nil];
    [self.navigationController pushViewController:editorVC animated:YES];
}

#pragma mark - CYImageEditorDelegate

- (void)CYImageEditor:(CYImageEditor *)editor didFinishEditingWithImage:(UIImage *)image {

}

- (void)CYImageEditorDidCancel:(CYImageEditor *)editor {

}
@end
