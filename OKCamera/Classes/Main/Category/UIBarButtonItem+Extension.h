

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName isLeft:(BOOL)isLeft target:(id)target action:(SEL)action;

+ (instancetype)itemWithTitle:(NSString *)title titleColor:(UIColor *)color target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)backBarItemWithImageName:(NSString *)imageName isLeft:(BOOL)isLeft target:(id)target action:(SEL)action;

@end
