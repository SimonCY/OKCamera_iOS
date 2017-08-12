//
//  CYViewController.h
//  LightBox
//
//  Created by RRTY on 17/3/14.
//  Copyright © 2017年 deepAI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYViewController : UIViewController

/*
 *是否需要侧滑返回手势  default is YES
 */
@property (nonatomic,assign,getter=isNeedGesture) BOOL needGesture;

/*
 *强制横屏还是强制竖屏
 */
@property (nonatomic,assign) BOOL shouldRotateToLandscapeRight;
@end
