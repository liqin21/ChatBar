//
//  MineNotificationController.m
//  聊吧
//
//  Created by m on 16/6/11.
//  Copyright © 2016年 m. All rights reserved.
//

#import "MineNotificationController.h"
#import "MineNotificationCell.h"
#import "NetworkSingleton.h"
#import "SchoolNoticeController.h"
#import "ClassNotificationVC.h"
#import "ResourceHandleVC.h"



@interface MineNotificationController () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation MineNotificationController {
    UITableView *_tableView;
    NSArray *imageArray;
    NSArray *titleArray;
    NSArray *numberArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发现";
    //1.设置导航栏
    [self setNavigaitionBar];
    
    //2.创建表视图
    [self createTableView];
    
    //3.创建数据
    [self loadData];
    
}

#pragma mark - 自定义导航栏
- (void)setNavigaitionBar {
    
    self.title = @"公告";
    //左边导航项
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 25, 25);
    [leftButton addTarget:self  action:@selector(blackAction:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"black"] forState:UIControlStateNormal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}


- (void)blackAction:(UIButton *) button {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -创建表视图
- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.contentInset = UIEdgeInsetsMake(-0, 0, 0, 0);
    
    //表视图的头视图
    [self createTableHeaderView];
    
}

#pragma mark - 表视图的头视图
- (void)createTableHeaderView  {
    
    UIImageView *headerVeiw = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 222)];
    headerVeiw.image = [UIImage imageNamed:@"home_01_bg"];
    _tableView.tableHeaderView = headerVeiw;
    
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.text = @"        中共中央总书记、国家主席、中央军委主席习近平发表重要讲话。新华社记者 鞠鹏 摄 “办好中国的事情,关键在党,关键在人,关键在人才。”习近平总书记近日对人才工作...";
    contentLabel.font = [UIFont systemFontOfSize:15];
    
    [headerVeiw addSubview:contentLabel];
    
    //设置约束
    contentLabel.sd_layout.topSpaceToView(headerVeiw,40).leftSpaceToView(headerVeiw,15).rightSpaceToView(headerVeiw,10).autoHeightRatio(0);
    
}


#pragma mark - 创建数据
- (void)loadData {
    //左边图片
    imageArray = @[@"home_01_icogg",@"home_01_ico2",@"jiao_xue"];
    
    //右边标题
    titleArray = @[@"学校通告( 1 )",@"班级通告( 3 )",@"教学资源"];
    
    NSString *urlString = @"m17/Login/Index";
    NSDictionary *dic = @{@"user":@"liuyisha",
                          @"pwd":@"666666"
                    };
    [NetworkSingleton requestURL:urlString httpMethod:kPOST params:dic successBlock:^(id data) {
       
        NSLog(@"请求成功");
        
    }failedBlock:^(NSError *error) {
        
        NSLog(@"请求失败");
        
                     }];
    
}


#pragma mark - UITableView 代理方法
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"MineNotificationCell";
    MineNotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MineNotificationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    //设置数据
    cell.lefeImage.image = [UIImage imageNamed:imageArray[indexPath.row]];
    
    //设置Label中段字体的颜色
    if (indexPath.row < 2) {
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:titleArray[indexPath.row]];
    NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:@"("].location + 1, [[noteStr string] rangeOfString:@")"].location - [[noteStr string] rangeOfString:@"("].location - 1);
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:redRange];
    [cell.titleLabel setAttributedText:noteStr] ;
    }
    else {
        cell.titleLabel.text = titleArray[2];
    }
    [cell.titleLabel sizeToFit];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

#pragma mark - 单元格点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        //导航到学校通知页面
        SchoolNoticeController *schoolNoticeCT = [[SchoolNoticeController alloc] init];
        [self.navigationController pushViewController:schoolNoticeCT animated:YES];
        
    }
    if (indexPath.row == 1) {
        //导航到班级通知页面
        ClassNotificationVC *classNotificationVC = [[ClassNotificationVC alloc] init];
        [self.navigationController pushViewController:classNotificationVC animated:YES];
    }
    else {
        //进入教学资源界面
        ResourceHandleVC *resourceHandleVC = [[ResourceHandleVC alloc] init];
        
        [self.navigationController pushViewController:resourceHandleVC animated:YES];
    }
}






@end
