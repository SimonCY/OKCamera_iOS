//
//  CYViewController.m
//  LightBox
//
//  Created by RRTY on 17/3/14.
//  Copyright © 2017年 deepAI. All rights reserved.
//

#import "CYViewController.h"
#import "AppDelegate.h"

@interface CYViewController ()

@end

@implementation CYViewController

- (instancetype)init {
    if (self = [super init]) {
        
        self.needGesture = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
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
}

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
