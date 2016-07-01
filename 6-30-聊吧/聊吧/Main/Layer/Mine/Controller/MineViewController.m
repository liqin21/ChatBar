//
//  MineViewController.m
//  聊吧
//
//  Created by m on 16/5/23.
//  Copyright (c) 2016年 m. All rights reserved.
//

#import "MineViewController.h"
#import "MineCell.h"
#import "MineDataViewController.h"
#import "MineMessageVC.h"
#import "MyClassViewController.h"
#import "LoginViewController.h"



@interface MineViewController () {
    UITableView *_tableView;
    NSArray *imgViewArr;
    NSArray *titleArr;
}

@end

@implementation MineViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    self.view.backgroundColor = [UIColor greenColor];
    
    //创建数据
    [self _setData];
    
    //创建表视图
    [self _createTableView];
    
}

#pragma mark - 创建数据
- (void)_setData {
    //创建数据
    imgViewArr = @[@"mine_my_ziliao",@"mine_my_quanzi",@"mine_my_friends",@"mine_my_flower",@"mine_my_xiaoxi",@"myZiliao_aboutus",@"mine_abtico2"];
    
    titleArr = @[@"我的资料",@"我的班级",@"我的朋友",@"我的鲜花",@"我的消息",@"关于我们",@"切换账户"];
}

#pragma mark - 创建表视图
- (void)_createTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

#pragma mark - UITableView 代理方法
//指定组的数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    return 4;
}

//指定每一组中单元格的数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 2;
}

//创建单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"mineCell";
    MineCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (indexPath.row == 0 && indexPath.section == 0) {
        cell.countLabel.hidden = YES;
    }
    //设置数据
    static NSInteger index = 0;
    if (index < imgViewArr.count) {
        cell.imgView.image = [UIImage imageNamed:imgViewArr[index]];
        cell.titlelabel.text = titleArr[index];
        index ++;
    }
    if (index >= imgViewArr.count) {
        index = 0;
    }
    
    return cell;
}

//设置单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

//设置头视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 20;
    }
    else if (section == 1 || section == 2) {
        return 10;
    }
    return 60;
}

//设置尾视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

//单元格点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //点击颜色立即消失的效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        //导航到我的个人信息界面
        MineDataViewController *mineDataCT = [[MineDataViewController alloc] init];
        mineDataCT.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:mineDataCT animated:YES];
    }
    if (indexPath.section == 1 && indexPath.row == 0 ) {
        //导航到我的班级界面
        //        MineClassController *mineClassmateCT = [[MineClassController alloc] init];
        //        [self.navigationController pushViewController:mineClassmateCT animated:YES];
        
        MyClassViewController *myClassCT = [[MyClassViewController alloc] init];
        
        myClassCT.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:myClassCT animated:YES];
        
    }
    if (indexPath.section == 1 && indexPath.row == 1 ) {
        //导航到我的朋友界面
        NSLog(@"导航到我的朋友界面");
    }
    if (indexPath.section == 2 && indexPath.row == 0 ) {
        //导航到我的鲜花界面
        NSLog(@"导航到我的鲜花界面");
    }
    if (indexPath.section == 2 && indexPath.row == 1 ) {
        //导航到我的消息界面
        MineMessageVC *mineMessageVC = [[MineMessageVC alloc] init];
       
        mineMessageVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:mineMessageVC animated:YES];
    }
    
    if (indexPath.section == 3 && indexPath.row == 0 ) {
        //导航到关于我们界面
        NSLog(@"导航到关于我们界面");
    }
    if (indexPath.section == 3 && indexPath.row == 1 ) {
        //导航到切换账号界面
        NSLog(@"导航到切换账号界面");
        //弹出提示框
        [self setAlertController];
    }
}

//提示框
- (void)setAlertController {
    //创建提示框
    UIAlertController *alertCT = [UIAlertController alertControllerWithTitle:@"退出当前账号" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    //添加按钮
    [alertCT addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //确定退出
        //标记为未登录状态
        [kUserDefaults setBool:NO forKey:kIsLogin];
        [kUserDefaults synchronize];
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        LoginViewController *loginCT = [[LoginViewController alloc] init];
        UINavigationController *navCT = [[UINavigationController alloc] initWithRootViewController:loginCT];
        window.rootViewController = navCT;
    }]];
    
    [alertCT addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alertCT animated:YES completion:nil];
    
}


@end
