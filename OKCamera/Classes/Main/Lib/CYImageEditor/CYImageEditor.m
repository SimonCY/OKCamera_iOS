//
//  CYImageEditor.m
//  OKCamera
//
//  Created by Chenyan on 2017/9/10.
//  Copyright © 2017年 Chenyan. All rights reserved.
//

#import "CYImageEditor.h"
#import "iPhoneMacro.h"

@interface CYImageEditor ()

@property (strong,nonatomic) CYImageEditorImage *image;

@end

@implementation CYImageEditor

#pragma mark - system

- (instancetype)initWithImage:(CYImageEditorImage *)image {
    if (self = [super init]) {
        _image = image;
    }
    return self;
}

#pragma mark - view cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = CommonWhite;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}


@end
