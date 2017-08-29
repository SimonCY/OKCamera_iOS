//
//  CYSettingViewController.m
//  OKCamera
//
//  Created by DeepAI on 2017/8/15.
//  Copyright © 2017年 Chenyan. All rights reserved.
//

#import "CYSettingViewController.h"
#import "iPhoneMacro.h"
#import "CYTableViewSection.h"


@interface CYSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *sections;
@end

static NSString *CYSettingCellID = @"CYSettingCellID";

@implementation CYSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNav];
    [self setupUI];
}

- (void)setupNav {

    self.navigationItem.title = @"设置";
}

- (void)setupUI {

    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
}

#pragma mark - getter
- (NSMutableArray *)sections {
    if (_sections == nil) {
        _sections = [NSMutableArray array];

        CYTableViewSection *section0 = [CYTableViewSection new];
        section0.headerText = @"图片美化";
        CYTableViewItem *item00 = [[CYTableViewItem alloc] initWithImage:nil text:@"美化" detailText:nil desVC:nil accessoryType:UITableViewCellAccessoryDisclosureIndicator];


        CYTableViewSection *section1 = [CYTableViewSection new];
        section1.headerText = @"系统";
        CYTableViewItem *item10 = [[CYTableViewItem alloc] initWithImage:nil text:@"启动" detailText:nil desVC:nil accessoryType:UITableViewCellAccessoryDisclosureIndicator];
        CYTableViewItem *item11 = [[CYTableViewItem alloc] initWithImage:nil text:@"字号" detailText:nil desVC:nil accessoryType:UITableViewCellAccessoryDisclosureIndicator];

        [section0.items addObject:item00];
        [section1.items addObject:item10];
        [section1.items addObject:item11];

        [_sections addObject:section0];
        [_sections addObject:section1];
    }
    return _sections;
}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    CYTableViewSection *sectionModel = self.sections[section];
    return sectionModel.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    CYTableViewSection *sectionModel = self.sections[section];
    return (sectionModel.headerText.length)? sectionModel.headerHeight : 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    CYTableViewSection *sectionModel = self.sections[section];
    return (sectionModel.footerText.length)? sectionModel.footerHeight : 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    CYTableViewSection *section = self.sections[indexPath.section];
    CYTableViewItem *item = section.items[indexPath.row];
    return item.height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CYSettingCellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CYSettingCellID];

        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = CommonGraytTextColor;
    }

    CYTableViewSection *section = self.sections[indexPath.section];
    CYTableViewItem *item = section.items[indexPath.row];

    cell.textLabel.text = item.text;
    cell.detailTextLabel.text = item.detailText;
    cell.accessoryType  = item.accessoryType;

    if (item.desVc) {
        CYViewController *desVC = [[item.desVc alloc] init];
        [self.navigationController pushViewController:desVC animated:YES];
    }

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

    CYTableViewSection *sectionModel = self.sections[section];
    return sectionModel.headerText;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {

    CYTableViewSection *sectionModel = self.sections[section];
    return sectionModel.footerText;
}


@end
