//
//  CYTableViewSection.h
//  zhiying
//
//  Created by DeepAI on 2017/6/26.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYTableViewItem.h"

@interface CYTableViewSection : NSObject

@property (nonatomic,copy) NSString *headerText;

@property (copy,nonatomic) NSString *footerText;

/** height for title.  */
@property (assign,nonatomic) CGFloat headerHeight;

/** height for footerText.  */
@property (assign,nonatomic) CGFloat footerHeight;

@property (nonatomic,strong) NSMutableArray *items;

@end
