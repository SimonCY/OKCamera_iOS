//
//  CYGPUStillImageFilterTool.h
//  zhiying
//
//  Created by DeepAI on 2017/6/9.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GPUImage.h>

typedef NS_ENUM(NSUInteger, CYGPUStillImageFilterType) {
    CYGPUStillImageFilterTypeYunying,
    CYGPUStillImageFilterTypeLiunian,
    CYGPUStillImageFilterTypeHuaijiu,
    CYGPUStillImageFilterTypeLengdiao,
    CYGPUStillImageFilterTypeBibo,
    CYGPUStillImageFilterTypeMengan,
    CYGPUStillImageFilterTypeHDR,
    CYGPUStillImageFilterTypeRichu,
    CYGPUStillImageFilterTypeBaoguang,
    CYGPUStillImageFilterTypeSumiao,
    CYGPUStillImageFilterTypeKatong,
};

@interface CYGPUStillImageFilterTool : NSObject

+ (UIImage *)filterImage:(UIImage *)sourceImage WithType:(CYGPUStillImageFilterType)filterType;

@end
