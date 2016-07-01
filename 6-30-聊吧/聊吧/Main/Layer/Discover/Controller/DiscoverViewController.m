//
//  DiscoverViewController.m
//  聊吧
//
//  Created by m on 16/5/23.
//  Copyright (c) 2016年 m. All rights reserved.
//

#import "DiscoverViewController.h"
#import "FriendsCirCleController.h"
#import "DiscoverCell.h"
#import "Masonry.h"
#import "MineNotificationController.h"

@interface DiscoverViewController () {
    UITableView *_tableView;
    
}

@end

@implementation DiscoverViewController {
    NSArray *imgArray;
    NSArray *titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发现";
    //创建数据
    [self _setData];
    
    //创建表视图
    [self _createTableView];
    
}

#pragma mark - 创建数据
- (void)_setData {
    imgArray = @[@"ff_IconShowAlbum",@"xhr",@"ff_IconShake",@"ff_IconLocationService",@"ff_IconBottle",@"CreditCard_ShoppingBag",@"MoreGame"];
    
    titleArray = @[@"朋友圈",@"公告",@"摇一摇",@"附近的人",@"漂流瓶",@"购物",@"游戏"];
    
}

#pragma mark - 创建表视图
- (void)_createTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}

#pragma mark - UITableView 代理方法
//1.指定组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

//2.指定每一组的单元格数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 2;
}

//创建单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"disCell";
    DiscoverCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[DiscoverCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }

    //设置数据
    static NSInteger index = 0;
    if (index < imgArray.count) {
        cell.imgView.image = [UIImage imageNamed:imgArray[index]];
        cell.titleLabel.text = titleArray[index];
        index ++;
    }
    if (index >= imgArray.count) {
        index = 0;
    }
    
    return cell;
}

//设置单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

//设置单元格的头视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 20;
}

//设置单元格的尾视图的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

//单元格点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //设置点击后立即去除颜色的效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //导航到相应的页面
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        FriendsCirCleController *friendsCiecleVC = [[FriendsCirCleController alloc] init];
        friendsCiecleVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:friendsCiecleVC animated:YES];
    }
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        MineNotificationController *mineNotVC = [[MineNotificationController alloc] init];
        mineNotVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:mineNotVC animated:YES];

    }
    
    
    
    
}


@end
