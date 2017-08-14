
//
//  Created by chenyna on 14-1-25.
//  Copyright (c) 2014年 chenyan. All rights reserved.
//

#ifndef iPhoneMacro_h
#define iPhoneMacro_h

#ifdef __OBJC__



// Debug Log
#ifdef DEBUG
#define CYLog(...) NSLog(__VA_ARGS__)
#else
#define CYLog(...)
#endif


// 函数输出
#define cy_LogFunc CYLog(@"%s", __func__)

// 打印方法运行时间
#define cy_TIME_BEGIN NSDate * startTime = [NSDate date];
#define cy_TIME_END CYLog(@"time interval: %f", -[startTime timeIntervalSinceNow]);


//weakself
#define cy_WEAKSELF __weak __typeof(&*self)weakSelf = self;
#define cy_STRONGSELF __strong __typeof(&*self) strongSelf = weakSelf;

//color
#define cy_RGBAColor(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define cy_RGBColor(r, g, b)  cy_RGBAColor(r, g, b, 1)

// 随机色
#define cy_RandomColor cy_RGBColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

// 十六进制转UIColor
#define cy_ColorFromHex(hexValue) [UIColor \
colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
green:((float)((hexValue & 0xFF00) >> 8))/255.0 \
blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]

//APP中的颜色
#define CommonPink cy_RGBColor(255,165,212)
#define CommonWhite cy_RGBColor(238,243,233)
#define Commonblue cy_RGBColor(117,207,248)

//frame and size
#define cy_SCREEN_BOUNDS    [[UIScreen mainScreen] bounds]
#define cy_DCREEN_SIZE      [[UIScreen mainScreen] bounds].size
#define cy_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define cy_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


/* 角度转弧度 */
#define DegreesToRadian(x) (M_PI * (x) / 180.0)
/* 弧度转角度 */
#define RadianToDegrees(radian) (radian * 180.0)/(M_PI)

/* 写入文件到桌面 */
#define cy_WriteToFile(data, name) [data writeToFile:[NSString stringWithFormat:@"/Users/chenyan/Desktop/%@.plist", name] atomically:YES]

// deprecated macro
#define cy_DEPRECATED_IN(VERSION) __attribute__((deprecated("This property has been deprecated and will be removed in VTMagic " VERSION ".")))


//notification
#define CYDidLogoutNotification  @"CYDidLogoutNotification"
#define CYDidLoginNotification  @"CYDidLoginNotification"

#define CYGotoMyProductNotification @"CYGotoMyProductNotification"
#define CYGotoHomeNotification @"CYGotoHomeNotification"

 
#endif
#endif
