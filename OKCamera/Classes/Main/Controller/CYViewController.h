//
//  CYViewController.h
//  LightBox
//
//  Created by RRTY on 17/3/14.
//  Copyright © 2017年 deepAI. All rights reserved.
//
 
#import "CYNavigationController.h"


@interface CYViewController : UIViewController

/*
 * default is YES
 */
@property (nonatomic,assign,getter=isNeedGesture) BOOL needGesture;

/*
 * 是否需要强制LandscapeRight
 */
@property (nonatomic,assign) BOOL shouldRotateToLandscapeRight;

@property (assign,nonatomic) BOOL navBarHidden;

@property (assign,nonatomic) BOOL statusBarHidden;
 
@end
