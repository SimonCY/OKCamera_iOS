//
//  CYImageEditor.h
//  OKCamera
//
//  Created by Chenyan on 2017/9/10.
//  Copyright © 2017年 Chenyan. All rights reserved.
//

#import "CYViewController.h"
#import "CYImageEditorImage.h"
#import "CYImageEditorTheme.h"
@class CYImageEditor;


@protocol CYImageEditorDelegate <NSObject>

@optional

- (void)CYImageEditor:(CYImageEditor *)editor didFinishEditingWithImage:(CYImageEditorImage *)image;

- (void)CYImageEditorDidCancel:(CYImageEditor *)editor;

@end


@interface CYImageEditor : CYViewController

@property (weak,nonatomic) id<CYImageEditorDelegate> delegate;

@property (nonatomic,strong) CYImageEditorTheme *theme;

/** the only-one initMethod */
- (instancetype)initWithImage:(CYImageEditorImage *)image;

- (void)showInViewController:(UIViewController *)controller withImageView:(UIImageView *)imageView;

- (void)refreshToolSetting;

@end
