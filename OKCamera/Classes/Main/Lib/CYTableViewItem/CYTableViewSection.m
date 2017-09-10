//
//  CYTableViewSection.m
//  zhiying
//
//  Created by DeepAI on 2017/6/26.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import "CYTableViewSection.h"

@implementation CYTableViewSection

- (instancetype)init {
    if (self = [super init]) {
        self.headerHeight = 30.f;
        self.footerHeight = 30.f;
    }
    return self;
}

- (NSMutableArray *)items {
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}

@end
