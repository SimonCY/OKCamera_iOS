//
//  CYImageEditor.h
//  OKCamera
//
//  Created by Chenyan on 2017/9/10.
//  Copyright © 2017年 Chenyan. All rights reserved.
//

#import "CYViewController.h"
#import "CYImageEditorImage.h"
@class CYImageEditor;


@protocol CYImageEditorDelegate <NSObject>

@optional

- (void)CYImageEditor:(CYImageEditor *)editor didFinishEditingWithImage:(UIImage*)image;

- (void)CYImageEditorDidCancel:(CYImageEditor*)editor;

@end


@interface CYImageEditor : CYViewController

@property (weak,nonatomic) id<CYImageEditorDelegate> delegate;

/** the only-one initMethod */
- (instancetype)initWithImage:(CYImageEditorImage *)image;

@end
