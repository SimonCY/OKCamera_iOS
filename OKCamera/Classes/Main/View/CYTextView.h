//
//  CYTextView.h
//  CYMicroblog
//
//  Created by Chenyan on 16/1/1.
//  Copyright (c) 2016年 Chenyan. All rights reserved.
//  带有PlaceHolder的textView

#import <UIKit/UIKit.h>


@interface CYTextView : UITextView
/**
 *  占位文字
 */
@property (copy,nonatomic) NSString *placeholder;
/**
 *  占位文字颜色
 */
@property (strong,nonatomic) UIColor *placeholderColor;

/**
 输入最大文字限制 default is 16
 */
@property (nonatomic,assign) NSInteger maxLength;
@end
