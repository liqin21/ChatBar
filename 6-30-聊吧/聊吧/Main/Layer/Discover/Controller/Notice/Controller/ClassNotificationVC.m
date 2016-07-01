//
//  ClassNotificationVC.m
//  聊吧
//
//  Created by m on 16/6/25.
//  Copyright © 2016年 m. All rights reserved.
//

#import "ClassNotificationVC.h"
#import "ClassNoticeModel.h"
#import "CalssNotificationCell.h"
#import "NotificationWebVC.h"

@interface ClassNotificationVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ClassNotificationVC {
    UITableView *_tableView;
    NSMutableArray *dataArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"查看通知";
    //设置导航栏
    [self setNavigationBar];
    
    //加载数据
    [self loadData];
    
    //创建表视图
    [self createTableViwe];
    
    [self createFlaglabel];
    
    
    
}

#pragma mark - 设置导航栏
- (void) setNavigationBar {
    //左边返回按钮
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"up"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(leftItemAction:)];
    
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)leftItemAction:(UIBarButtonItem *)item {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 创建表视图
- (void)createTableViwe {
   
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];

}

#pragma mark - UITableViwe代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return dataArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"classNoticeCell";
    CalssNotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[CalssNotificationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    //设置数据
    cell.classNoticeModel = dataArray[indexPath.row];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

#pragma mark - 单元格点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //导航到通知详情界面
    NotificationWebVC *notificationWebVC = [[NotificationWebVC alloc] init];
    
    [self.navigationController pushViewController:notificationWebVC animated:YES];
    
}

#pragma mark - 加载数据
- (void)loadData {

    NSString *urlString = @"/m17/ClassNotice/GetNoRead";
    NSDictionary *dic = @{
                          @"uid":kUserModel.uid,
                          @"key":kUserModel.key
                          };
    //请求网络
    [NetworkSingleton requestURL:urlString httpMethod:kPOST params:dic successBlock:^(id data) {
        NSLog(@"班级通知加载成功%@",data);
        if (![data isKindOfClass:[NSArray class]]) {
            return ;
        }
        NSArray *array = (NSArray *)data;
        if (array.count == 0) {
            _flagLabel.hidden = NO;
            return;
        }
        else {
            _flagLabel.hidden = YES;
        }
        
        dataArray = [NSMutableArray array];
        for (NSDictionary *dic in array) {
            ClassNoticeModel *classNoticeModel = [ClassNoticeModel objectWithKeyValues:dic];
            [dataArray addObject:classNoticeModel];
        }
        //刷新数据
        [_tableView reloadData];
        
    } failedBlock:^(NSError *error) {
        NSLog(@"班级数据加载失败%@",error);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:error.userInfo[@"NSLocalizedDescription"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }];
    
}

#pragma mark - 创建flagLabel
- (void) createFlaglabel {
    if (_flagLabel == nil) {
        _flagLabel = [[UILabel alloc] initWithFrame:CGRectMake(kWidth / 2.0 - 50, kHeight / 2.0, 100, 20)];
        _flagLabel.font = [UIFont systemFontOfSize:18];
        _flagLabel.textColor = [UIColor lightGrayColor];
        _flagLabel.backgroundColor = [UIColor clearColor];
        _flagLabel.text = NSLocalizedString(@"无新的数据!", @"Network disconnection");
        [self.view addSubview:_flagLabel];
    }
}

@end
