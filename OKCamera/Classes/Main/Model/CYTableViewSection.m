//
//  CYTableViewSection.m
//  zhiying
//
//  Created by DeepAI on 2017/6/26.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import "CYTableViewSection.h"

@implementation CYTableViewSection
- (NSMutableArray *)items {
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}
@end
