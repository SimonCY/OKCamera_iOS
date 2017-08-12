//
//  UIImage+Resize.m
//  SCCaptureCameraDemo
//
//  Created by chenyan on 14-1-17.
//  Copyright (c) 2014年 chenyan. All rights reserved.
//

#import "UIImage+CYExtension.h"
#import <Accelerate/Accelerate.h>
#import "iPhoneMacro.h"

@implementation UIImage (Resize)



- (UIImage *)fixOrientation {
    
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

#pragma mark - cut image
/**
 *  切图
 */
- (UIImage *)cutImageForRect:(CGRect)usebleRect {
    // CGImageCreateWithImageInRect只认像素
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat newX = usebleRect.origin.x ;
    CGFloat newY = usebleRect.origin.y ;
    CGFloat newW = usebleRect.size.width ;
    CGFloat newH = usebleRect.size.height ;
    
    CYLog(@"imageSize is %@",[NSValue valueWithCGSize:self.size]);
    CGImageRef newImageRef = CGImageCreateWithImageInRect(self.CGImage, CGRectMake(newX,newY, newW , newH));
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    CGImageRelease(newImageRef);
    CYLog(@"newImage size is %@ ,scale is %f",[NSValue valueWithCGSize:newImage.size],scale);
    
    if (newImage == nil) {
        CYLog(@"裁图失败");
    }
    return newImage;
}

#pragma mark - copy  
- (UIImage *)copyImage{
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], CGRectMake(0, 0, self.size.width,self.size.height));
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return newImage;
}

- (UIImage *)copyImageToNewSize:(CGSize)newSize {
    
    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}

- (UIImage *)copyImageToNewWidth:(CGFloat)newWidth {
    
    CGFloat newHeight = self.size.height / self.size.width * newWidth;
    UIImage *result = [self copyImageToNewSize:CGSizeMake(newWidth, newHeight)];
    return result;
}

- (UIImage *)copyImageToNewHeight:(CGFloat)newHeight{
    
    CGFloat newWidth = self.size.width / self.size.height * newHeight;
    UIImage *result = [self copyImageToNewSize:CGSizeMake(newWidth, newHeight)];
    return result;
}

#pragma mark - scale image
// Returns a rescaled copy of the image, taking into account its orientation
// The image will be scaled disproportionately if necessary to fit the bounds specified by the parameter
- (UIImage *)resizedImage:(CGSize)newSize interpolationQuality:(CGInterpolationQuality)quality {
    BOOL drawTransposed;
    CGAffineTransform transform = CGAffineTransformIdentity;
    

    
    if([[[UIDevice currentDevice]systemVersion]floatValue] >= 5.0) {
        drawTransposed = YES;
    } else {
        switch(self.imageOrientation) {
            case UIImageOrientationLeft:
            case UIImageOrientationLeftMirrored:
            case UIImageOrientationRight:
            case UIImageOrientationRightMirrored:
                drawTransposed = YES;
                break;
            default:
                drawTransposed = NO;
        }
        
        transform = [self transformForOrientation:newSize];
    }
    transform = [self transformForOrientation:newSize];
    return [self resizedImage:newSize transform:transform drawTransposed:drawTransposed interpolationQuality:quality];
}

// Resizes the image according to the given content mode, taking into account the image's orientation
- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  size:(CGSize)newSize
                    interpolationQuality:(CGInterpolationQuality)quality {
    CGFloat horizontalRatio = newSize.width / self.size.width;
    CGFloat verticalRatio = newSize.height / self.size.height;
    CGFloat ratio;
    
    switch(contentMode) {
        case UIViewContentModeScaleAspectFill:
            ratio = MAX(horizontalRatio, verticalRatio);
            break;
            
        case UIViewContentModeScaleAspectFit:
            ratio = MIN(horizontalRatio, verticalRatio);
            break;
            
        default:
            [NSException raise:NSInvalidArgumentException format:@"Unsupported content mode: %ld", (long)contentMode];
    }
    
    return [self resizedImage:newSize interpolationQuality:quality];
}





#pragma mark - rotate image
//degree是弧度制
- (UIImage *)rotatedByDegrees:(CGFloat)degrees
{
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(degrees);
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, degrees);
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
}

#pragma mark Private helper methods

// Returns a copy of the image that has been transformed using the given affine transform and scaled to the new size
// The new image's orientation will be UIImageOrientationUp, regardless of the current image's orientation
// If the new size is not integral, it will be rounded up
- (UIImage *)resizedImage:(CGSize)newSize
                transform:(CGAffineTransform)transform
           drawTransposed:(BOOL)transpose
     interpolationQuality:(CGInterpolationQuality)quality {
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
    CGRect transposedRect = CGRectMake(0, 0, newRect.size.height, newRect.size.width);
    CGImageRef imageRef = self.CGImage;
    
    // Fix for a colorspace / transparency issue that affects some types of
    // images. See here: http://vocaro.com/trevor/blog/2009/10/12/resize-a-uiimage-the-right-way/comment-page-2/#comment-39951
    
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                newRect.size.width,
                                                newRect.size.height,
                                                8,
                                                0,
                                                CGImageGetColorSpace(imageRef),
                                                kCGImageAlphaNoneSkipLast);
    
    // Rotate and/or flip the image if required by its orientation
    CGContextConcatCTM(bitmap, transform);
    
    // Set the quality level to use when rescaling
    CGContextSetInterpolationQuality(bitmap, quality);
    
    // Draw into the context; this scales the image
    CGContextDrawImage(bitmap, transpose ? transposedRect : newRect, imageRef);
    
    // Get the resized image from the context and a UIImage
    CGImageRef newImageRef = CGBitmapContextCreateImage(bitmap);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    // Clean up
    CGContextRelease(bitmap);
    CGImageRelease(newImageRef);
    
    return newImage;
}


// Returns an affine transform that takes into account the image orientation when drawing a scaled image
- (CGAffineTransform)transformForOrientation:(CGSize)newSize {
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch(self.imageOrientation) {
        case UIImageOrientationDown:           // EXIF = 3
        case UIImageOrientationDownMirrored:   // EXIF = 4
            transform = CGAffineTransformTranslate(transform, newSize.width, newSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:           // EXIF = 6
        case UIImageOrientationLeftMirrored:   // EXIF = 5
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:          // EXIF = 8
        case UIImageOrientationRightMirrored:  // EXIF = 7
            transform = CGAffineTransformTranslate(transform, 0, newSize.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch(self.imageOrientation) {
        case UIImageOrientationUpMirrored:     // EXIF = 2
        case UIImageOrientationDownMirrored:   // EXIF = 4
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:   // EXIF = 5
        case UIImageOrientationRightMirrored:  // EXIF = 7
            transform = CGAffineTransformTranslate(transform, newSize.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    return transform;
}
#pragma mark - 类方法
/**
 *  UIColor生成UIImage
 *
 *  @param color     生成的颜色
 *  @param imageSize 生成的图片大小
 *
 *  @return 生成后的图片
 */
+ (UIImage*)createImageWithColor:(UIColor*)color size:(CGSize)imageSize {
    CGRect rect=CGRectMake(0.0f, 0.0f, imageSize.width, imageSize.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

//画一条线
+ (void)drawALineWithFrame:(CGRect)frame andColor:(UIColor*)color inLayer:(CALayer*)parentLayer {
    CALayer *layer = [CALayer layer];
    layer.frame = frame;
    layer.backgroundColor = color.CGColor;
    [parentLayer addSublayer:layer];
}



+ (void)imageCoreBlurImage:(UIImage *)image withBlurNumber:(CGFloat)blur backImage:(void (^)(UIImage *))backImage{
    
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = image.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    
    void *pixelBuffer;
    //从CGImage中获取数据
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    //设置从CGImage获取对象的属性
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
                         CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    if (backImage) {
        backImage(returnImage);
    }
}

+ (UIImage *)captureView:(UIView *)view {
 
    // 1.开启上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    
    // 2.将控制器view的layer渲染到上下文
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    // 3.取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 4.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark - 类型转换
+ (Byte *)imageToBuffer:(UIImage *)image {
    
    CGImageRef inputCGImage = [image CGImage];
    NSUInteger width =                 CGImageGetWidth(inputCGImage);
    NSUInteger height = CGImageGetHeight(inputCGImage);
    
    // 2.
    NSUInteger bytesPerPixel = 4;   //rgba是4 rgb是3 灰度图是1
    NSUInteger bytesPerRow = bytesPerPixel *     width;
    NSUInteger bitsPerComponent = 8;
    
    Byte * pixels;
    pixels = (Byte *) calloc(height * width,     sizeof(UInt32));
    
    // 3.
    CGColorSpaceRef colorSpace =     CGColorSpaceCreateDeviceRGB();
    CGContextRef context =     CGBitmapContextCreate(pixels, width, height,     bitsPerComponent, bytesPerRow, colorSpace,     kCGImageAlphaPremultipliedLast |     kCGBitmapByteOrder32Big);
    
    // 4.
    CGContextDrawImage(context, CGRectMake(0,     0, width, height), inputCGImage);
    //    CGImageRef imageRef = CGBitmapContextCreateImage (context);
    //    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    // 5. Cleanup
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    return pixels;
}

+ (CVPixelBufferRef) pixelBufferFromCGImage: (CGImageRef) image
{
    NSDictionary *options = @{
                              (NSString*)kCVPixelBufferCGImageCompatibilityKey : @YES,
                              (NSString*)kCVPixelBufferCGBitmapContextCompatibilityKey : @YES,
                              (NSString*)kCVPixelBufferIOSurfacePropertiesKey: [NSDictionary dictionary]
                              };
    CVPixelBufferRef pxbuffer = NULL;
    
    CGFloat frameWidth = CGImageGetWidth(image);
    CGFloat frameHeight = CGImageGetHeight(image);
    
    CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault,
                                          frameWidth,
                                          frameHeight,
                                          kCVPixelFormatType_32BGRA,
                                          (__bridge CFDictionaryRef) options,
                                          &pxbuffer);
    
    NSParameterAssert(status == kCVReturnSuccess && pxbuffer != NULL);
    
    CVPixelBufferLockBaseAddress(pxbuffer, 0);
    void *pxdata = CVPixelBufferGetBaseAddress(pxbuffer);
    NSParameterAssert(pxdata != NULL);
    
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(pxdata,
                                                 frameWidth,
                                                 frameHeight,
                                                 8,
                                                 CVPixelBufferGetBytesPerRow(pxbuffer),
                                                 rgbColorSpace,
                                                 (CGBitmapInfo)kCGImageAlphaNoneSkipFirst);
    NSParameterAssert(context);
    CGContextConcatCTM(context, CGAffineTransformIdentity);
    CGContextDrawImage(context, CGRectMake(0,
                                           0,
                                           frameWidth,
                                           frameHeight),
                       image);
    CGColorSpaceRelease(rgbColorSpace);
    CGContextRelease(context);
    
    CVPixelBufferUnlockBaseAddress(pxbuffer, 0);
    
    return pxbuffer;
    
    //    NSDictionary *options = @{
    //                              (NSString*)kCVPixelBufferCGImageCompatibilityKey : @YES,
    //                              (NSString*)kCVPixelBufferCGBitmapContextCompatibilityKey : @YES,
    //                              (NSString*)kCVPixelBufferIOSurfacePropertiesKey: [NSDictionary dictionary]
    //                              };
    //
    //
    //    CVPixelBufferRef pxbuffer = NULL;
    //
    //    CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault, CGImageGetWidth(image),
    //                                          CGImageGetHeight(image), kCVPixelFormatType_32BGRA, (__bridge CFDictionaryRef)options,
    //                                          &pxbuffer);
    //    if (status!=kCVReturnSuccess) {
    //        NSLog(@"Operation failed");
    //    }
    //
    //    NSParameterAssert(status == kCVReturnSuccess && pxbuffer != NULL);
    //
    //    CVPixelBufferLockBaseAddress(pxbuffer, 0);
    //    void *pxdata = CVPixelBufferGetBaseAddress(pxbuffer);
    //
    //    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    //    CGContextRef context = CGBitmapContextCreate(pxdata, CGImageGetWidth(image),
    //                                                 CGImageGetHeight(image), 8, 4*CGImageGetWidth(image), rgbColorSpace,
    //                                                 kCGImageAlphaNoneSkipFirst);
    //    NSParameterAssert(context);
    //
    //    CGContextConcatCTM(context, CGAffineTransformMakeRotation(0));
    //    CGAffineTransform flipVertical = CGAffineTransformMake( 1, 0, 0, -1, 0, CGImageGetHeight(image) );
    //    CGContextConcatCTM(context, flipVertical);
    //    CGAffineTransform flipHorizontal = CGAffineTransformMake( -1.0, 0.0, 0.0, 1.0, CGImageGetWidth(image), 0.0 );
    //    CGContextConcatCTM(context, flipHorizontal);
    //
    //    CGContextDrawImage(context, CGRectMake(0, 0, CGImageGetWidth(image),
    //                                           CGImageGetHeight(image)), image);
    //    CGColorSpaceRelease(rgbColorSpace);
    //    CGContextRelease(context);
    //
    //    CVPixelBufferUnlockBaseAddress(pxbuffer, 0);
    //    return pxbuffer;
}

+ (UIImage *)imageFromPixelBuffer:(CVPixelBufferRef)pixelBufferRef {
    CVImageBufferRef imageBuffer =  pixelBufferRef;
    
    CVPixelBufferLockBaseAddress(imageBuffer, 0);
    void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    size_t bufferSize = CVPixelBufferGetDataSize(imageBuffer);
    size_t bytesPerRow = CVPixelBufferGetBytesPerRowOfPlane(imageBuffer, 0);
    
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, baseAddress, bufferSize, NULL);
    
    CGImageRef cgImage = CGImageCreate(width, height, 8, 32, bytesPerRow, rgbColorSpace, kCGImageAlphaNoneSkipFirst | kCGBitmapByteOrderDefault, provider, NULL, true, kCGRenderingIntentDefault);
    
    
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(rgbColorSpace);
    
    CVPixelBufferUnlockBaseAddress(imageBuffer, 0);
    
    image = [self grayscale:image];
    
    return image;

}

//反转颜色空间
+ (UIImage*)grayscale:(UIImage*)anImage {
    
    CGImageRef imageRef;
    
    imageRef = anImage.CGImage;
    
    //const int width = anImage.size.width;
    
    //const int height = anImage.size.height;
    
    size_t width=CGImageGetWidth(imageRef);
    
    size_t height =CGImageGetHeight(imageRef);
    
    //ピクセルを構成するRGB各要素が何ビットで構成されている
    
    size_t bitsPerComponent;
    
    bitsPerComponent =CGImageGetBitsPerComponent(imageRef);
    
    //ピクセル全体は何ビットで構成されているか
    
    size_t bitsPerPixel;
    
    bitsPerPixel =CGImageGetBitsPerPixel(imageRef);
    
    //画像の横1ライン分のデータが、何バイトで構成されているか
    
    size_t bytesPerRow;
    
    bytesPerRow =CGImageGetBytesPerRow(imageRef);
    
    //画像の色空間
    
    CGColorSpaceRef colorSpace;
    
    colorSpace =CGImageGetColorSpace(imageRef);
    
    //画像のBitmap情報
    
    CGBitmapInfo bitmapInfo;
    
    bitmapInfo =CGImageGetBitmapInfo(imageRef);
    
    //画像がピクセル間の補完をしているか
    
    bool shouldInterpolate;
    
    shouldInterpolate =CGImageGetShouldInterpolate(imageRef);
    
    //表示装置によって補正をしているか
    
    CGColorRenderingIntent intent;
    
    intent =CGImageGetRenderingIntent(imageRef);
    
    //画像のデータプロバイダを取得する
    
    CGDataProviderRef dataProvider;
    
    dataProvider =CGImageGetDataProvider(imageRef);
    
    //データプロバイダから画像のbitmap生データ取得
    
    CFDataRef data;
    
    UInt8*buffer;
    
    data =CGDataProviderCopyData(dataProvider);
    
    buffer = (UInt8*)CFDataGetBytePtr(data);
    
    //// 1ピクセルずつ画像を処理
    
    for(NSInteger y =0; y < height; y++) {
        
        for(NSInteger x =0; x < width; x++) {
            
            UInt8*tmp = buffer + y * bytesPerRow + x *4;// RGBAの4つ値をもっているので、1ピクセルごとに*4してずらす
            
            // RGB値を取得   这段是颜色反转的关键点代码  此处是从argb转成rgba
            
            UInt8 alpha,red,green,blue;
            
            alpha = *(tmp +0);
            
            red = *(tmp +1);
            
            green = *(tmp +2);
            
            blue = *(tmp +3);
            
            if(alpha) {
                
                *(tmp +0) =blue;
                
                *(tmp +1) =green;
                
                *(tmp +2) = red;
                
                *(tmp +3) = alpha;
            }
            
        }
        
    }
    
    //効果を与えたデータ生成
    
    CFDataRef effectedData;
    
    effectedData =CFDataCreate(NULL, buffer,CFDataGetLength(data));
    
    //効果を与えたデータプロバイダを生成
    
    CGDataProviderRef effectedDataProvider;
    
    effectedDataProvider =CGDataProviderCreateWithCFData(effectedData);
    
    //画像を生成
    
    CGImageRef effectedCgImage;
    
    UIImage*effectedImage;
    
    effectedCgImage =CGImageCreate(
                                   
                                   width, height,
                                   
                                   bitsPerComponent, bitsPerPixel, bytesPerRow,
                                   
                                   colorSpace, bitmapInfo, effectedDataProvider,
                                   
                                   NULL, shouldInterpolate, intent);
    
    effectedImage = [[UIImage alloc]initWithCGImage:effectedCgImage];
    
    //データの解放
    
    CGImageRelease(effectedCgImage);
    
    CFRelease(effectedDataProvider);
    
    CFRelease(effectedData);
    
    CFRelease(data);
    
    return effectedImage;
    
}
@end
