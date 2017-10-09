//
//  CYImageEditorTheme.m
//  OKCamera
//
//  Created by DeepAI on 2017/10/2.
//  Copyright © 2017年 Chenyan. All rights reserved.
//

#import "CYImageEditorTheme.h"

static id _sharedInstance = nil;

@implementation CYImageEditorTheme

#pragma mark - single

+ (instancetype)sharedTheme {
    
    static dispatch_once_t  onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[CYImageEditorTheme alloc] init];
    });
    return _sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (_sharedInstance == nil) {
            _sharedInstance = [super allocWithZone:zone];
            return _sharedInstance;
        }
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

#pragma mark - cycle

- (instancetype)init {
    
    if (self = [super init]) {
        
//        self.bundleName = @"CYImageEditor";
        self.backgroundColor = [UIColor whiteColor];
        self.toolBarColor = [UIColor colorWithWhite:1 alpha:0.8];
        self.toolBarIconColor = @"black";
        self.toolBarTextColor = [UIColor blackColor];
        self.toolBarSelectedButtonColor = [[UIColor cyanColor] colorWithAlphaComponent:0.2];
        self.toolBarTextFont = [UIFont systemFontOfSize:10];
        self.statusBarStyle = UIStatusBarStyleDefault;
    }
    return self;
}

#pragma mark - getter

//- (NSBundle*)bundle {
//    NSString *path = [[NSBundle mainBundle] pathForResource:self.bundleName ofType:@"bundle"];
//    if(path){
//        return [NSBundle bundleWithPath:path];
//    }
//
//    path = [[NSBundle bundleForClass:self.class] pathForResource:self.bundleName ofType:@"bundle"];
//    if(path){
//        return [NSBundle bundleWithPath:path];
//    }
//    return nil;
//}



@end
