//
//  CYEditorImage.h
//  OKCamera
//
//  Created by Chenyan on 2017/9/10.
//  Copyright © 2017年 Chenyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYImageEditorImage : NSObject

/** the clean image first you created the model passed*/
@property (strong,nonatomic,readonly) UIImage *originalImage;

/** the image current being edited as you could see */
@property (strong,nonatomic,readonly) UIImage *editedImage;

/** the image you begin sub-editing this time passed, existing for revoking */
@property (strong,nonatomic,readonly) UIImage *lastEditedImage;

/** the only-one initMethod */
- (instancetype)initWithImage:(UIImage *)image;
@end
