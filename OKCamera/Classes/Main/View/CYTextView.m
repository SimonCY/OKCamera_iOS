//
//  CYTextView.m
//  CYMicroblog
//
//  Created by Chenyan on 16/1/1.
//  Copyright (c) 2016年 Chenyan. All rights reserved.
//

#import "CYTextView.h"

/**
 *  默认的palceholder字体颜色
 */
#define CYDefaultPlaceholderColor [UIColor lightGrayColor]
/**
 *  最大文本长度
 */
#define CYDefaultMaxLength 16

@implementation CYTextView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)setup {

    self.maxLength = CYDefaultMaxLength;
    self.font = [UIFont systemFontOfSize:17];
    //当textView的文本发生改变时  会自动发出一个名为UITextViewTextDidChangeNotification的通知   最后的object是判断通知是由谁发出的  这里写self  是代表只接受自己发出的这个通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
}
/**
 *  setNeedsDisplay方法  会在下一个消息循环(RunLoop)才重新drawRect     这是为了性能
 */
- (void)drawRect:(CGRect)rect {
    //文字改变时 判断当前有文字么  如果没有文字  显示placeholder
    if (self.text.length) return;
    //内省机制 判断placeholder是否有值
    if (self.placeholder) {
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSFontAttributeName] = self.font;
        attrs[NSForegroundColorAttributeName] =  self.placeholderColor?self.placeholderColor:CYDefaultPlaceholderColor;
//        [self.placeholder drawAtPoint:CGPointMake(5, 8) withAttributes:attrs];
        //用这个方法不用上边那个是为了  在以后开发中兼容placeholder过长时自动换行的功能
        
        [self.placeholder drawInRect:CGRectMake(5, 8, self.bounds.size.width - 10, self.bounds.size.height - 16) withAttributes:attrs];
    }
}
#pragma mark - 重写set方法  是为了做到和系统自带控件一样  属性在外部被更改了 马上就由反应  这才是合格的UI控件
- (void)setPlaceholder:(NSString *)placeholder {
    /**
     *  这是copy的语法   @property 用copy时  实际上是拷贝对象的值生成一个新的对象   (属性值不随着原来赋值的值的改变而改变)
     */
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}
/**
 *  //通过代码修改text值时系统不会发出UITextViewTextDidChangeNotification通知    这样写也会让placeholder做出响应的反应  让字数上限也会实时起作用
 */
- (void)setText:(NSString *)text {
    if (text.length >= self.maxLength) {
        text = [text substringToIndex:self.maxLength];
    }
    [super setText:text];
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    [self setNeedsDisplay];
}

#pragma mark - 通知触发事件
- (void)textDidChange {
    //在这里进行字数的约束   但是这种做法只能约束用户输入的text   通过代码添加的text的约束需要在settext方法中做
    if (self.text.length >= self.maxLength) {
        NSString *subText = [self.text substringToIndex:self.maxLength];
        self.text = subText;
    }
    [self setNeedsDisplay];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
