//
//  CYViewController.m
//  LightBox
//
//  Created by RRTY on 17/3/14.
//  Copyright © 2017年 deepAI. All rights reserved.
//

#import "CYViewController.h"
#import "AppDelegate.h"
#import "iPhoneMacro.h"

@interface CYViewController ()

@end

@implementation CYViewController

#pragma mark - system

- (instancetype)init {
    if (self = [super init]) {
        
        self.needGesture = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self baseUISetup];
}

- (void)baseUISetup {
    
    
    //nav
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//    self.navigationController.navigationBar.layer.shadowColor = [UIColor blackColor].CGColor;
//    self.navigationController.navigationBar.layer.shadowOpacity = 0.5f;
//    self.navigationController.navigationBar.layer.shadowOffset = CGSizeMake(0, 0.05);
 
    //UI
    for (UIView *subView in self.view.subviews) {
        
        if ([subView isKindOfClass:[UITableView class]]) {
            
            ((UITableView *)subView).estimatedSectionHeaderHeight = 0;
            ((UITableView *)subView).estimatedSectionFooterHeight = 0;
            ((UITableView *)subView).estimatedRowHeight = 0;
        }
        if ([subView isKindOfClass:[UIScrollView class]]) {
            
            if (@available(iOS 11.0, *)) {
                ((UIScrollView *)subView).contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
                ((UIScrollView *)subView).contentInset = UIEdgeInsetsMake(64, 0, 49, 0);//iPhoneX这里是88
                ((UIScrollView *)subView).scrollIndicatorInsets = ((UIScrollView *)subView).contentInset;
            }
        }
    }
    
    //大标题
    //    if (@available(iOS 11.0, *)) {
    //        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAutomatic;
    //        self.navigationController.navigationBar.prefersLargeTitles = YES;
    //
    //        UISearchController *searchVC = [[UISearchController alloc] initWithSearchResultsController:self];
    //        self.navigationItem.searchController = searchVC;
    //        self.definesPresentationContext = true;
    //
    //    } else {
    //        // Fallback on earlier versions
    //    }

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if (!cy_isiPhoneX && self.statusBarHidden) {

        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    if (!cy_isiPhoneX && self.statusBarHidden) {

        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];


}

#pragma mark - public
 
- (void)setShouldRotateToLandscapeRight:(BOOL)shouldRotateToLandscapeRight {
    
    _shouldRotateToLandscapeRight = shouldRotateToLandscapeRight;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.shouldRotateToLandscapeRight = shouldRotateToLandscapeRight;
    if([[UIDevice currentDevice]respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val;
        if (shouldRotateToLandscapeRight) {
            val = UIInterfaceOrientationLandscapeRight;
        } else {
            val = UIInterfaceOrientationPortrait;
        }
        
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}
@end
