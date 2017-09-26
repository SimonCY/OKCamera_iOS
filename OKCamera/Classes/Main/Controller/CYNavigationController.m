//
//  CYNavigationController.m
//  LightBox
//
//  Created by RRTY on 17/3/13.
//  Copyright © 2017年 deepAI. All rights reserved.
//

#import "CYNavigationController.h"
#import "UIBarButtonItem+Extension.h"
#import "UIImage+CYExtension.h"
#import "iPhoneMacro.h"

#import "CYViewController.h"


@interface CYNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation CYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = self;
 
//    self.navigationBar.prefersLargeTitles = NO;
//    self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAutomatic;
    
}

#pragma mark theme setup
+ (void)initialize {
    
    [self setupNavigationBarTheme];
    [self setupBarButtonItemTheme];
}

+ (void)setupNavigationBarTheme {
    //var
    UIColor *textColor = [UIColor darkTextColor];
    CGFloat textSize = 20;
    BOOL isBold = YES;

    //title
    UINavigationBar *appearance = [UINavigationBar appearance];
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = textColor;
    textAttrs[NSFontAttributeName] = isBold?[UIFont boldSystemFontOfSize:textSize]:[UIFont systemFontOfSize:textSize];
    [appearance setTitleTextAttributes:textAttrs];
    //系统返回按钮颜色
    [appearance setTintColor:textColor];
 
    //设置颜色  带阴影线
    [appearance setBarTintColor:CommonWhite];
    //设置拉伸背景图 不带阴影线
//    [appearance setBackgroundImage:[UIImage createImageWithColor:CommonWhite size:CGSizeMake(1, 1)] forBarMetrics:UIBarMetricsDefault];
}

+ (void)setupBarButtonItemTheme {

    //var
    UIColor *textNormalColor = [UIColor darkTextColor];
    UIColor *textDisableColor = cy_RGBColor(150, 150, 150);
    CGFloat textSize = 16;

    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    //normal
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = textNormalColor;
    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:textSize];
    [appearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    //disable
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    disableTextAttrs[NSForegroundColorAttributeName] = textDisableColor;
    [appearance setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    //highlighted
    //    NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    //    highTextAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
    //    [appearance setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
    //backgoundimage
    //    [appearance setBackgroundImage:[UIImage imageWithName:@"cm2_nav_bg"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    
}

#pragma mark - pravite
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if ([self.topViewController isMemberOfClass:[viewController class]]) {
        return;
    }
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backBarItemWithImageName:@"nav_back" isLeft:YES target:self action:@selector(back)];
    }
    
    [super pushViewController:viewController animated:animated];
    
}

- (UIViewController *)childViewControllerForStatusBarStyle{
    
    return self.topViewController;
}

#pragma mark Click events
- (void)back {
    
    [self popViewControllerAnimated:YES];
}

#pragma mark ---gestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    return ((self.childViewControllers.count > 1) && [(CYViewController *)self.topViewController isNeedGesture]);
}


@end
