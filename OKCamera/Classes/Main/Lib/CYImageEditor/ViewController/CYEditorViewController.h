//
//  CYEditorViewController.h
//  OKCamera
//
//  Created by Chenyan on 2017/10/11.
//  Copyright © 2017年 Chenyan. All rights reserved.
//

#import "CYViewController.h"
#import "CYImageEditorImage.h"

@interface CYEditorViewController : CYViewController

/** the only-one initMethod */
- (instancetype)initWithImage:(UIImage *)image;

 

- (void)resetZoomScaleWithAnimated:(BOOL)animated;

@end
