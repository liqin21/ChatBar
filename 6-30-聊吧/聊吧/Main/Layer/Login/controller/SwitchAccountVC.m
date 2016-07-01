//
//  SwitchAccountVC.m
//  聊吧
//
//  Created by m on 16/6/24.
//  Copyright © 2016年 m. All rights reserved.
//

#import "SwitchAccountVC.h"

@interface SwitchAccountVC ()

@end

@implementation SwitchAccountVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.navigationController.navigationBar.barTintColor = RGB(93, 190, 91, 1);
//    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]
//                                                                    };
    
    [self setNavigationBar];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

#pragma mark - 设置导航栏
- (void)setNavigationBar {
    
    //左边导航项
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"up"] style:UIBarButtonItemStylePlain target:self action:@selector(leftItemAction:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"black"] style:UIBarButtonItemStyleDone target:self action:@selector(leftItemAction:)];
    self.navigationItem.rightBarButtonItem = rightItem;

    
}

#pragma mark - 导航项点击事件
- (void)leftItemAction:(UIBarButtonItem *)item {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)leftButtonAction:(UIButton *)item {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
