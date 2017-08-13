//
//  AppDelegate.m
//  OKCamera
//
//  Created by Chenyan on 2017/8/12.
//  Copyright © 2017年 Chenyan. All rights reserved.
//

#import "AppDelegate.h"
#import "CYNavigationController.h"
#import "CYHomeViewController.h"
#import "AppDelegate+CYLaunchAnimation.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen]bounds]];

    CYHomeViewController *homeVC = [[CYHomeViewController alloc] init];
    CYNavigationController *nav = [[CYNavigationController alloc] initWithRootViewController:homeVC];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];

    //状态栏
    [application setStatusBarStyle:UIStatusBarStyleDefault];
    [application setStatusBarHidden:NO];
    //launch动画
//    [self showLaunchAnimation];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {

}


- (void)applicationDidEnterBackground:(UIApplication *)application {

}


- (void)applicationWillEnterForeground:(UIApplication *)application {

}


- (void)applicationDidBecomeActive:(UIApplication *)application {

}


- (void)applicationWillTerminate:(UIApplication *)application {

}


@end
