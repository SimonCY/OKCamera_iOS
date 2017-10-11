//
//  CYImageEditorTheme.h
//  OKCamera
//
//  Created by DeepAI on 2017/10/2.
//  Copyright © 2017年 Chenyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CYImageEditorThemeDelegate

- (UIActivityIndicatorView *)imageEditorThemeActivityIndicatorView;

@end

@interface CYImageEditorTheme : NSObject

//@property (nonatomic,copy) NSString *bundleName;

@property (nonatomic,strong) UIColor *backgroundColor;

@property (nonatomic,strong) UIColor *toolBarColor;

@property (nonatomic,strong) UIColor *toolBarTextColor; 

@property (nonatomic,strong) UIColor *toolBarSelectedButtonColor;

@property (nonatomic,strong) NSString *toolBarIconColor;

@property (nonatomic,strong) UIFont *toolBarTextFont;

@property (nonatomic,assign) UIStatusBarStyle *statusBarStyle;

+ (instancetype)sharedTheme;
@end
