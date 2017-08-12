//
//  CYTableViewSection.h
//  zhiying
//
//  Created by DeepAI on 2017/6/26.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTableViewSection : NSObject
@property (nonatomic,copy) NSString *groupTitle;
@property (nonatomic,strong) NSMutableArray *items;
@end
