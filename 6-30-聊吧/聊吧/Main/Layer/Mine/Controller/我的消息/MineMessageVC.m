//
//  MineMessageVC.m
//  家校通
//
//  Created by m on 16/6/11.
//  Copyright © 2016年 m. All rights reserved.
//

#import "MineMessageVC.h"

@interface MineMessageVC ()

@end

@implementation MineMessageVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.tabBarController.tabBar.hidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    //自定义导航栏
    [self setNavigaitionBar];

    
    //加载数据
    
    
    //创建表视图
    
    
    
}

#pragma mark - 自定义导航栏
- (void)setNavigaitionBar {
    
    self.title = @"我的消息";
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



#pragma mark - 加载数据



#pragma mark - 创建表视图


@end
