//
//  CYImageEditor.h
//  OKCamera
//
//  Created by Chenyan on 2017/9/10.
//  Copyright © 2017年 Chenyan. All rights reserved.
//


#import "CYEditorViewController.h"

@class CYImageEditor;


@protocol CYImageEditorDelegate <NSObject>

@optional

- (void)CYImageEditor:(CYImageEditor *)editor didFinishEditingWithImage:(UIImage*)image;

- (void)CYImageEditorDidCancel:(CYImageEditor*)editor;

@end


@interface CYImageEditor : CYEditorViewController

@property (weak,nonatomic) id<CYImageEditorDelegate> delegate;

/** the only-one initMethod */
- (instancetype)initWithImage:(UIImage *)image;



@end
