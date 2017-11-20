//
//  CYEditorImage.m
//  OKCamera
//
//  Created by Chenyan on 2017/9/10.
//  Copyright © 2017年 Chenyan. All rights reserved.
//

#import "CYImageEditorImage.h"

@implementation CYImageEditorImage

- (instancetype)initWithImage:(UIImage *)image {
    if (self = [super init]) {

        _originalImage = [UIImage imageWithCGImage:image.CGImage];
        _editedImage = [UIImage imageWithCGImage:_originalImage.CGImage];
//        _lastEditedImage = [UIImage imageWithCGImage:_originalImage.CGImage];
    }
    return self;
}

@end
