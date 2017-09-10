//
//  CYTableViewItem.h
//  zhiying
//
//  Created by DeepAI on 2017/6/26.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYTableViewItem : NSObject


@property (nonatomic,strong) UIImage* image;

@property (nonatomic,copy) NSString* text;

@property (nonatomic,copy) NSString* detailText;

@property (nonatomic,assign) UITableViewCellAccessoryType accessoryType;

@property (nonatomic,assign) Class desVc;


/** height for row, default is 40 */
@property (nonatomic,assign) CGFloat height;


/** the only-one initMethod */
- (instancetype)initWithImage:(NSString *)image text:(NSString *)text detailText:(NSString *)detailText desVC:(Class)desVc accessoryType:(UITableViewCellAccessoryType)accessoryType;
@end
