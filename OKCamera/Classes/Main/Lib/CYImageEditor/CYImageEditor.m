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
    self.statusBarHidden = YES;
}

#pragma mark - public

- (void)show {

    
}

@end
