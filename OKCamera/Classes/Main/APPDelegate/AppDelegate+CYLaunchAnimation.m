//
//  AppDelegate+CYLaunchAnimation.m
//  zhiying
//
//  Created by DeepAI on 2017/7/6.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import "AppDelegate+CYLaunchAnimation.h"

@implementation AppDelegate (CYLaunchAnimation)
- (void)showLaunchAnimation {
    //启动动画
    UIViewController *viewController = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateViewControllerWithIdentifier:@"LaunchScreen"];
    UIView *launchView = viewController.view;
    launchView.frame = self.window.frame;
    [self.window addSubview:launchView];
    UIView *label0 = [launchView viewWithTag:2];
    UIView *label1 = [launchView viewWithTag:3];
    label0.alpha = 0;
    label1.alpha = 0;
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    UIView *logo = [launchView viewWithTag:1];
    
    [UIView animateWithDuration:1 delay:0.f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        logo.layer.transform = CATransform3DScale(CATransform3DMakeRotation( M_PI , 0, 0, 1), 2.5, 2.5, 1.0f);
        logo.alpha = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            launchView.alpha = 0;
        }completion:^(BOOL finished) {
            [launchView removeFromSuperview];
        }];
    }];
}
@end
