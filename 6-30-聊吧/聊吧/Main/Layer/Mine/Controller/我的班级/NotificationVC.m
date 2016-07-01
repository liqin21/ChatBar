//
//  NotificationVC.m
//  聊吧
//
//  Created by m on 16/6/17.
//  Copyright © 2016年 m. All rights reserved.
//

#import "NotificationVC.h"
#import "ClassCourseVC.h"
#import "MyClassViewController.h"
#import "MainTabBarController.h"
#import "AppDelegate.h"
#import "NotificationCell.h"
#import "NotificationModel.h"
#import "NotificationWebVC.h"



@interface NotificationVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation NotificationVC {
    UITableView *_tableView;
    NSString *identifier;
    NSMutableArray *dataArray;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //加载数据
    [self loadData];
    
    //创建表视图
    [self createTableView];
    
}

#pragma mak - 加载数据
- (void)loadData {
    
    //请求地址
    NSString *urlString = [NSString stringWithFormat:@"m17/ClassNotice/GetClassNotice/classid/%@/uid/%@",kUserModel.classModel.classid,kUserModel.uid];
    
    NSDictionary *dic = @{
                          @"key":kUserModel.key
                          };
    
    
    [NetworkSingleton requestURL:urlString httpMethod:kPOST params:dic successBlock:^(id data) {
        NSLog(@"通知数据加载成功：%@",data);
        //构建数据模型
        if ([data isKindOfClass:[NSArray class]] == NO) {
            return ;
        }
        NSArray *array = (NSArray *)data;
        if (array.count == 0) {
            return;
        }
        
        dataArray = [NSMutableArray array];
        for (NSDictionary *dic in data) {
            
            NotificationModel *notificationModel = [NotificationModel objectWithKeyValues:dic];
            [dataArray addObject:notificationModel];
        }
        //刷新表视图
        [_tableView reloadData];

    } failedBlock:^(NSError *error) {
        NSLog(@"通知数据加载失败%@",error);
        
    }];
    
}

#pragma mark - 创建表视图
- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    [self.view addSubview:_tableView];
}

#pragma mark - UITableView 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    identifier = @"notificationCell";
    NotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[NotificationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    //设置数据
    cell.notificationModel = dataArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85;
}

#pragma mark - 单元格点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //导航到通知详情界面
    NotificationWebVC *notificationWebVC = [[NotificationWebVC alloc] init];
    
    NotificationModel *model = dataArray[indexPath.row];
    notificationWebVC.htmlID = model.notificationID;
    notificationWebVC.htmlString = model.url;
    
    [self.navigationController pushViewController:notificationWebVC animated:YES];
    
}


@end
