//
//  CYEditorViewController.m
//  OKCamera
//
//  Created by Chenyan on 2017/10/11.
//  Copyright © 2017年 Chenyan. All rights reserved.
//

#import "CYEditorViewController.h"
#import "CYImageEditorToolBar.h"

@interface CYEditorViewController ()<UIScrollViewDelegate>

@property (strong,nonatomic) CYImageEditorImage *image;

@property (strong,nonatomic) UIScrollView *scrollView;

@property (strong,nonatomic) UIImageView *imageView;

@property (nonatomic, strong) UIImageView *targetImageView;

@property (strong,nonatomic) CYImageEditorToolBar *toolBar;

@end

@implementation CYEditorViewController

#pragma mark - system

- (void)dealloc {


}

- (instancetype)initWithImage:(UIImage *)image {
    if (self = [super init]) {

        _image = [[CYImageEditorImage alloc] initWithImage:image];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //scrollView
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.clipsToBounds = NO;
    [self.view addSubview:self.scrollView];


    //test code
    self.scrollView.backgroundColor = [UIColor redColor];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    CGFloat scrollViewX = 0;
    self.scrollView.frame = self.view.bounds;
}

#pragma mark - public

#pragma mark - pravite

- (void)resetImageView {

    self.imageView.image = self.image.originalImage;
}

- (void)resetZoomScaleWithAnimated:(BOOL)animated {

    
}

#pragma mark - scrollViewDelegate

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {


}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {


}
@end
