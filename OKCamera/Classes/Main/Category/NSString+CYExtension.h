//
//  NSString+CYExtension.h
//  LightBox
//
//  Created by RRTY on 17/3/30.
//  Copyright © 2017年 deepAI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (CYExtension)

#pragma mark - 文字排版相关
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
- (CGSize)sizeWithFont:(UIFont *)font maxH:(CGFloat)maxH;

#pragma mark - 时间戳
+ (NSString *)getCuttentDate;

#pragma mark - 正则过滤
- (BOOL)isMobileNumber;

#pragma mark - 加密
- (NSString *)md5;
@end
