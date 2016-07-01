//
//  ResourceHandleVC.m
//  聊吧
//
//  Created by m on 16/6/27.
//  Copyright © 2016年 m. All rights reserved.
//

#import "ResourceHandleVC.h"
#import "PublicResourceVC.h"
#import "MineResourceVC.h"


@interface ResourceHandleVC ()

@end

@implementation ResourceHandleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

//设置导航栏
[self setNavigationBar];

//1.创建分段控件
[self createSegment];

//创建两个平级控制器
[self createChildViewControllers];

}

#pragma mark - 设置导航栏
- (void)setNavigationBar {
    //左边返回按钮
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"up"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(leftItemAction:)];
    self.navigationItem.leftBarButtonItem = leftItem;
}

#pragma mark - 返回按钮点击事件
- (void)leftItemAction:(UIBarButtonItem *)item {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 创建分段控件
- (void)createSegment {
    //1.创建分段控件
    NSArray *items = @[@"公共资源",@"我的资源"];
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:items];
    segment.frame = CGRectMake(0, 0, 120, 30);
    segment.selectedSegmentIndex = 0;
    
    segment.tintColor = [UIColor whiteColor];
    
    [segment addTarget:self action:@selector(segmentClickedAction:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:segment];
    
    //把分段控件作为导航栏的标题视图
    UIView *titleVeiw = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    [titleVeiw addSubview:segment];
    
    self.navigationItem.titleView = titleVeiw;
    
}


#pragma mark - 创建2个平级控制器
- (void)createChildViewControllers  {
    MineResourceVC *mineResourceVC = [[MineResourceVC alloc] init];
    
    PublicResourceVC *publicResourceVC = [[PublicResourceVC alloc] init];
    
    //添加到子控制器中
    [self addChildViewController:publicResourceVC];
    [self addChildViewController:mineResourceVC];
    
    [self.view addSubview:publicResourceVC.view];
    
    self.selectedIndex = 0;
    
}

#pragma mark - 分段控件点击事件方法
- (void)segmentClickedAction:(UISegmentedControl *)segment {
    if (self.selectedIndex != segment.selectedSegmentIndex) {
        //取得之前选中的控制器
        UIViewController *lastVC = self.childViewControllers[self.selectedIndex];
        //移除之前的子控制器视图
        [lastVC.view removeFromSuperview];
        //取得当前要显示的控制器
        UIViewController *currentVC = self.childViewControllers[segment.selectedSegmentIndex];
        //显示当前要显示的视图
        [self.view addSubview:currentVC.view];
        
        self.selectedIndex = segment.selectedSegmentIndex;
    }
}



@end
