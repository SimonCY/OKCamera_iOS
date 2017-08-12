//
//  CYGPUStillImageFilterTool.m
//  zhiying
//
//  Created by DeepAI on 2017/6/9.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import "CYGPUStillImageFilterTool.h"

@implementation CYGPUStillImageFilterTool

+ (UIImage *)filterImage:(UIImage *)sourceImage WithType:(CYGPUStillImageFilterType)filterType {
    
    GPUImageFilter *filter;
    
    switch (filterType) {
        case CYGPUStillImageFilterTypeYunying: {
            GPUImageMonochromeFilter *monochromeFilter = [[GPUImageMonochromeFilter alloc] init];
            [monochromeFilter setColor:(GPUVector4){0.f, 0.f, 0.f, 1.f}];
            monochromeFilter.intensity = 0.4;
            filter = monochromeFilter;
//正经的晕影滤镜
//            GPUImageVignetteFilter *vignetteFilter = [[GPUImageVignetteFilter alloc] init];
//            filter = vignetteFilter;
//放大镜效果
//            GPUImageBulgeDistortionFilter *bulgeDistortionFilter = [[GPUImageBulgeDistortionFilter alloc] init];
//            bulgeDistortionFilter.scale = 1;
//            bulgeDistortionFilter.radius = 0.25;
//            filter = bulgeDistortionFilter;
            break;
        }
        case CYGPUStillImageFilterTypeLiunian: {
            GPUImageMonochromeFilter *monochromeFilter = [[GPUImageMonochromeFilter alloc] init];
            [monochromeFilter setColor:(GPUVector4){1.0f, 1.0f, 0.0f, 1.f}];
            monochromeFilter.intensity = 0.1;
            filter = monochromeFilter;
            break;
        }
        case CYGPUStillImageFilterTypeHuaijiu:
            filter = [[GPUImageMonochromeFilter alloc] init];
            break;
        case CYGPUStillImageFilterTypeLengdiao: {
            GPUImageMonochromeFilter *monochromeFilter = [[GPUImageMonochromeFilter alloc] init];
            [monochromeFilter setColor:(GPUVector4){0.0f, 0.0f, 1.0f, 1.f}];
            monochromeFilter.intensity = 0.1;
            filter = monochromeFilter;
            break;
        }
        case CYGPUStillImageFilterTypeBibo:{
            GPUImageMonochromeFilter *monochromeFilter = [[GPUImageMonochromeFilter alloc] init];
            [monochromeFilter setColor:(GPUVector4){0.0f, 1.0f, 0.0f, 1.f}];
            monochromeFilter.intensity = 0.05;
            filter = monochromeFilter;
            break;
        }
        case CYGPUStillImageFilterTypeMengan: {
            GPUImageMonochromeFilter *monochromeFilter = [[GPUImageMonochromeFilter alloc] init];
            [monochromeFilter setColor:(GPUVector4){0.0f, 0.0f, 0.0f, 1.f}];
            monochromeFilter.intensity = 0.2;
            filter = monochromeFilter;
            break;
        }
        case CYGPUStillImageFilterTypeHDR:
            filter = [[GPUImageEmbossFilter alloc] init];
            break;
        case CYGPUStillImageFilterTypeRichu:{
            GPUImageMonochromeFilter *monochromeFilter = [[GPUImageMonochromeFilter alloc] init];
            [monochromeFilter setColor:(GPUVector4){1.0f, 0.0f, 0.0f, 1.f}];
            monochromeFilter.intensity = 0.1;
            filter = monochromeFilter;
            break;
        }
        case CYGPUStillImageFilterTypeBaoguang:
            filter = [[GPUImageColorInvertFilter alloc] init];
            break;
        case CYGPUStillImageFilterTypeSumiao:
            filter = [[GPUImageSketchFilter alloc] init];
            break;
        case CYGPUStillImageFilterTypeKatong:
            filter = [[GPUImageToonFilter alloc] init];
            break;
        default:
            break;
    }
    
    //设置渲染区域
    [filter forceProcessingAtSize:sourceImage.size];
    //如果需要处理滤镜处理后的结果，应显示指出
    [filter useNextFrameForImageCapture];
    
    //输入源
    GPUImagePicture *sourceInput = [[GPUImagePicture alloc] initWithImage:sourceImage];
    [sourceInput addTarget:filter];
    [sourceInput processImage];
    
    //获取图片
    UIImage *newImage = [filter imageFromCurrentFramebufferWithOrientation:UIImageOrientationUp];
    NSData *data = UIImageJPEGRepresentation(newImage,1);
    
    UIImage *result = [[UIImage alloc] initWithData:data];
    
    //处理后的释放
    newImage = nil;
    
    [sourceInput removeAllTargets];
    [sourceInput removeOutputFramebuffer];
    sourceInput = nil;
    
    [filter removeAllTargets];
    [filter useNextFrameForImageCapture];
    [filter endProcessing];
    //清除显存
    [[GPUImageContext sharedImageProcessingContext].framebufferCache purgeAllUnassignedFramebuffers];
    return result;
}

@end
