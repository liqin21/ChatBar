//
//  ResourceShareVC.m
//  聊吧
//
//  Created by m on 16/6/28.
//  Copyright © 2016年 m. All rights reserved.
//

#import "ResourceShareVC.h"

@interface ResourceShareVC ()

@end

@implementation ResourceShareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"分享";
    self.view.backgroundColor = [UIColor greenColor];
    //设置导航栏
    [self setNavigationBar];
    
    //加载数据
    [self loadData];
    
    //创建表视图
    [self createTableView];
    
}

#pragma mark - 设置导航栏
- (void)setNavigationBar {
    //左边返回按钮
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"up"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(leftItemAction:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //右边导航项
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}

#pragma mark - 返回按钮点击事件
- (void)leftItemAction:(UIBarButtonItem *)item {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightItemAction:(UIBarButtonItem *)item {
   
    NSLog(@"确定");
    
}


#pragma mark - 加载数据
- (void)loadData {
    
    
    
}


#pragma mark - 创建表视图
- (void)createTableView {
    
}




@end
