

#import "UIBarButtonItem+Extension.h"
#import "UIView+CYExtension.h"

@implementation UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName isLeft:(BOOL)isLeft target:(id)target action:(SEL)action {
    UIButton *button = [[UIButton alloc] init];

    [button setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
 
    // 设置按钮的尺寸为背景图片的尺寸
//    button.size = button.currentBackgroundImage.size;
    button.size = CGSizeMake(40, 40);
    button.imageEdgeInsets = UIEdgeInsetsMake(0, isLeft?-30:0, 0,0);
    // 监听按钮点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}


+ (instancetype)itemWithTitle:(NSString *)title titleColor:(UIColor *)color target:(id)target action:(SEL)action {
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0,80, 40);
    [button.titleLabel setFont:[UIFont systemFontOfSize:17]];
    if (color == nil) {
        [button setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    } else {
        [button setTitleColor:color forState:UIControlStateNormal];
    }
    [button setTitleColor:[UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0] forState:UIControlStateDisabled];
    [button setTitleColor:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)backBarItemWithImageName:(NSString *)imageName isLeft:(BOOL)isLeft target:(id)target action:(SEL)action {
    UIButton *button = [[UIButton alloc]init];

    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 40, 40);

    button.imageEdgeInsets = UIEdgeInsetsMake(0, isLeft?-30:0, 0,0);

    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}


@end
