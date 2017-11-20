//
//  CYImageEditor.m
//  OKCamera
//
//  Created by Chenyan on 2017/9/10.
//  Copyright © 2017年 Chenyan. All rights reserved.
//

#import "CYImageEditor.h"
#import "iPhoneMacro.h"

@interface CYImageEditor ()<UINavigationControllerDelegate>

@end

@implementation CYImageEditor

#pragma mark - system
- (instancetype)initWithImage:(UIImage *)image {

    return [super initWithImage:image];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = CommonWhite;
    self.navBarHidden = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if (!cy_isiPhoneX) {
        
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    if (!cy_isiPhoneX) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    }
}

#pragma mark - public

- (void)show {

    
}

@end
