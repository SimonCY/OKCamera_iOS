//
//  CYContactViewController.m
//  OKCamera
//
//  Created by Chenyan on 2017/8/26.
//  Copyright © 2017年 Chenyan. All rights reserved.
//

#import "CYContactViewController.h"
#import "UIImage+CYExtension.h"
#import "NSString+CYExtension.h"
#import "iPhoneMacro.h"
#import "YYKit.h"

@interface CYContactViewController ()
@property (strong,nonatomic) UIImageView *logoImageView;

@property (strong,nonatomic) UILabel *versionLabel;

@property (strong,nonatomic) UIButton *updateBtn;
@property (strong,nonatomic) UIButton *judgeBtn;

@property (strong,nonatomic) UILabel *desLabel;
@property (strong,nonatomic) UILabel *contactLabel;

@property (strong,nonatomic) UIImageView *titleImageView;
@property (strong,nonatomic) UIImageView *authorImageView;
@end

@implementation CYContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = CommonWhite;

    [self setupNav];
    [self setupUI];

    [self asynchronouslySetFontName:@"HanziPenSC-W3"];
}

- (void)setupNav {

    // 1. Create an attributed string.
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"关于 OKCamera"];

    text.color = [UIColor blackColor];
    text.font = [UIFont fontWithName:@"Chalkboard SE" size:18];

    // 2. Set to YYLabel
    YYLabel *titleLabel = [[YYLabel alloc] init];
    titleLabel.attributedText = text;
    titleLabel.frame = CGRectMake(0, 0, 100, 44);
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;

    self.navigationItem.titleView = titleLabel;
}

- (void)setupUI {

    //logo
    self.logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    [self.view addSubview:self.logoImageView];
    self.logoImageView.layer.borderWidth = 0.5;
    self.logoImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.logoImageView.layer.cornerRadius = 10;
    self.logoImageView.clipsToBounds = YES;

    //versionLabel
    self.versionLabel = [[UILabel alloc] init];
    self.versionLabel.textAlignment = NSTextAlignmentCenter;
    self.versionLabel.numberOfLines = 0;
    self.versionLabel.text = @"版本：v1.0";
    self.versionLabel.font = [UIFont systemFontOfSize:14];
    self.versionLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:self.versionLabel];

    //updateBtn
    self.updateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.updateBtn setTitle:@"检查更新" forState:UIControlStateNormal];
    self.updateBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    self.updateBtn.clipsToBounds = YES;
    self.updateBtn.layer.cornerRadius = 5;
    [self.updateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.updateBtn setBackgroundImage:[UIImage createImageWithColor:Commonblue size:CGSizeMake(1, 1)] forState:UIControlStateNormal];
    [self.updateBtn addTarget:self action:@selector(updateBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.updateBtn];


    //judgeBtn
    self.judgeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.judgeBtn setTitle:@"五星好评" forState:UIControlStateNormal];
    self.judgeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    self.judgeBtn.layer.cornerRadius = 5;
    self.judgeBtn.clipsToBounds = YES;
    [self.judgeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.judgeBtn setBackgroundImage:[UIImage createImageWithColor:CommonPink size:CGSizeMake(1, 1)] forState:UIControlStateNormal];
    [self.judgeBtn addTarget:self action:@selector(judgeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.judgeBtn];

    //desLabel
    self.desLabel = [[UILabel alloc] init];
    self.desLabel.textAlignment = NSTextAlignmentCenter;
    self.desLabel.numberOfLines = 0;
    self.desLabel.text = @"OKCamera是一款由CY独立开发的\n免费相机+滤镜美化软件\n\n如果你觉得还不错请五星好评\n您的鼓励是对个人开发者最大的支持";
    self.desLabel.font = [UIFont fontWithName:@"Chalkboard SE" size:14];
    self.desLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:self.desLabel];

    //contactLabel
    self.contactLabel = [[UILabel alloc] init];
    self.contactLabel.textAlignment = NSTextAlignmentCenter;
    self.contactLabel.numberOfLines = 0;
    self.contactLabel.text = @"联系我们:\n\nQQ群:611211498";
    self.contactLabel.font = [UIFont fontWithName:@"Chalkboard SE" size:14];
    self.contactLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:self.contactLabel];

    //titleImage
    self.titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title"]];
    self.titleImageView.contentMode = UIViewContentModeCenter;
    [self.view addSubview:self.titleImageView];

    //authorImage
    self.authorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cy"]];
    self.authorImageView.contentMode = UIViewContentModeCenter;
    [self.view addSubview:self.authorImageView];


    [self setNeedUpdateVersionLabel];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

    //logo
    CGFloat logoWH = 110;
    CGFloat logoX = (cy_SCREEN_WIDTH - logoWH) / 2;
    CGFloat logoY = 120;
    self.logoImageView.frame = CGRectMake(logoX, logoY, logoWH, logoWH);

    //versionLabel
    CGFloat versionX = 0;
    CGFloat versionY = CGRectGetMaxY(self.logoImageView.frame) + 15;
    CGFloat versionW = cy_SCREEN_WIDTH;
    CGFloat versionH = 14;
    self.versionLabel.frame = CGRectMake(versionX, versionY, versionW, versionH);

    //updateBtn and judgeBtn
    CGFloat btnW = 100;
    CGFloat btnH = 28;
    CGFloat btnY = CGRectGetMaxY(self.versionLabel.frame) + 15;
    CGFloat updateX = (cy_SCREEN_WIDTH - btnW * 2) / 3;
    CGFloat judgeX = btnW + updateX * 2;
    self.updateBtn.frame = CGRectMake(updateX, btnY, btnW, btnH);
    self.judgeBtn.frame = CGRectMake(judgeX, btnY, btnW, btnH);


    //desLabel
    CGFloat desLabelX = updateX / 2;
    CGFloat desLabelY = CGRectGetMaxY(self.updateBtn.frame) + 30;
    CGFloat desLabelW = cy_SCREEN_WIDTH - desLabelX * 2;
    CGFloat desLabelH = [self.desLabel.text sizeWithFont:self.desLabel.font maxW:desLabelW].height;
    self.desLabel.frame = CGRectMake(desLabelX, desLabelY, desLabelW, desLabelH);

    //contactLabel
    CGFloat contactLabelX = updateX / 2;
    CGFloat contactLabelY = CGRectGetMaxY(self.desLabel.frame) + 30;
    CGFloat contactLabelW = cy_SCREEN_WIDTH - desLabelX * 2;
    CGFloat contactLabelH = [self.contactLabel.text sizeWithFont:self.contactLabel.font maxW:desLabelW].height;
    self.contactLabel.frame = CGRectMake(contactLabelX, contactLabelY, contactLabelW, contactLabelH);

    //authorImage
    CGFloat authorX = 0;
    CGFloat authorW = cy_SCREEN_WIDTH;
    CGFloat authorH = 30;
    CGFloat authorY = self.view.bounds.size.height - authorH - 20;
    self.authorImageView.frame = CGRectMake(authorX, authorY, authorW, authorH);
    //titleImage
    CGFloat titleX = authorX;
    CGFloat titleH = authorH;
    CGFloat titleW = authorW;
    CGFloat titleY = CGRectGetMinY(self.authorImageView.frame) - titleH;
    self.titleImageView.frame = CGRectMake(titleX, titleY, titleW, titleH);
}

#pragma mark - pravite
- (void)setNeedUpdateVersionLabel {

    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];

    self.versionLabel.text = [NSString stringWithFormat:@"版本：v%@",app_Version];
}

#pragma mark - btnClicked 
- (void)updateBtnClicked {
    NSString *appID = @"1252918819";
    NSString *str = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/ai-yu/id%@?mt=8", appID];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:str]]) {

        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}

- (void)judgeBtnClicked {

    NSString *appID = @"1252918819";
    NSString *str = [NSString stringWithFormat:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8", appID];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:str]]) {

        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}

- (void)asynchronouslySetFontName:(NSString *)fontName
{
    UIFont* aFont = [UIFont fontWithName:fontName size:14];
    // If the font is already downloaded
    if (aFont && ([aFont.fontName compare:fontName] == NSOrderedSame || [aFont.familyName compare:fontName] == NSOrderedSame)) {
        // Go ahead and display the sample text.

        self.desLabel.font = [UIFont fontWithName:fontName size:14];
        return;
    }

    // Create a dictionary with the font's PostScript name.
    NSMutableDictionary *attrs = [NSMutableDictionary dictionaryWithObjectsAndKeys:fontName, kCTFontNameAttribute, nil];

    // Create a new font descriptor reference from the attributes dictionary.
    CTFontDescriptorRef desc = CTFontDescriptorCreateWithAttributes((__bridge CFDictionaryRef)attrs);

    NSMutableArray *descs = [NSMutableArray arrayWithCapacity:0];
    [descs addObject:(__bridge id)desc];
    CFRelease(desc);

    __block BOOL errorDuringDownload = NO;

    // Start processing the font descriptor..
    // This function returns immediately, but can potentially take long time to process.
    // The progress is notified via the callback block of CTFontDescriptorProgressHandler type.
    // See CTFontDescriptor.h for the list of progress states and keys for progressParameter dictionary.
    CTFontDescriptorMatchFontDescriptorsWithProgressHandler( (__bridge CFArrayRef)descs, NULL,  ^(CTFontDescriptorMatchingState state, CFDictionaryRef progressParameter) {

        //NSLog( @"state %d - %@", state, progressParameter);

        double progressValue = [[(__bridge NSDictionary *)progressParameter objectForKey:(id)kCTFontDescriptorMatchingPercentage] doubleValue];

        if (state == kCTFontDescriptorMatchingDidBegin) {
            dispatch_async( dispatch_get_main_queue(), ^ {
                // Show an activity indicator
                NSLog(@"Begin Matching");
            });
        } else if (state == kCTFontDescriptorMatchingDidFinish) {
            dispatch_async( dispatch_get_main_queue(), ^ {
                // Remove the activity indicator

                // Display the sample text for the newly downloaded font
                self.desLabel.font = [UIFont fontWithName:fontName size:14];

                // Log the font URL in the console
                CTFontRef fontRef = CTFontCreateWithName((__bridge CFStringRef)fontName, 0., NULL);
                CFStringRef fontURL = CTFontCopyAttribute(fontRef, kCTFontURLAttribute);
                NSLog(@"%@", (__bridge NSURL*)(fontURL));
                CFRelease(fontURL);
                CFRelease(fontRef);

                if (!errorDuringDownload) {
                    NSLog(@"%@ downloaded", fontName);
                }
            });
        } else if (state == kCTFontDescriptorMatchingWillBeginDownloading) {
            dispatch_async( dispatch_get_main_queue(), ^ {
                // Show a progress bar

                NSLog(@"Begin Downloading");
            });
        } else if (state == kCTFontDescriptorMatchingDidFinishDownloading) {
            dispatch_async( dispatch_get_main_queue(), ^ {
                // Remove the progress bar

                NSLog(@"Finish downloading");
            });
        } else if (state == kCTFontDescriptorMatchingDownloading) {
            dispatch_async( dispatch_get_main_queue(), ^ {
                // Use the progress bar to indicate the progress of the downloading
                NSLog(@"Downloading %.0f%% complete", progressValue);
            });
        } else if (state == kCTFontDescriptorMatchingDidFailWithError) {
            // An error has occurred.
            // Get the error message
            NSError *error = [(__bridge NSDictionary *)progressParameter objectForKey:(id)kCTFontDescriptorMatchingError];
            NSString *_errorMessage;
            if (error != nil) {
                _errorMessage = [error description];
            } else {
                _errorMessage = @"ERROR MESSAGE IS NOT AVAILABLE!";
            }
            // Set our flag
            errorDuringDownload = YES;

            dispatch_async( dispatch_get_main_queue(), ^ {
                NSLog(@"Download error: %@", _errorMessage);
            });
        }
        return (bool)YES;
    });   
}

@end
