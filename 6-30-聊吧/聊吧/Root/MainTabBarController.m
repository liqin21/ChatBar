//
//  MainTabBarController.m
//  聊吧
//
//  Created by m on 16/5/23.
//  Copyright (c) 2016年 m. All rights reserved.
//

#import "MainTabBarController.h"
#import "BaseNavigationController.h"
#import "MessageViewController.h"
#import "FriendsViewController.h"
#import "DiscoverViewController.h"
#import "MineViewController.h"
#import "MainTabItems.h"

@interface MainTabBarController () {
    NSArray *_normalImg;
    NSArray *_selectedImg;
    NSMutableArray *_items;
    UIImageView *imgView;
    UILabel *titleLabel;
    MainTabItems *selectedItem;

}

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.创建4个三级控制器作为导航控制器的根控制器
    [self _createViewControllers];
    
    //2.自定义tabBar栏
    [self _buildTabBar];
    
    
}

#pragma mark - 创建4个三级控制器作为导航控制器的根控制器
- (void)_createViewControllers {
    MessageViewController *messageVC = [[MessageViewController alloc] init];
    FriendsViewController *friendsVC = [[FriendsViewController alloc] init];
    DiscoverViewController *discoverVC = [[DiscoverViewController alloc] init];
    MineViewController *mineVC = [[MineViewController alloc] init];
    
    NSArray *VCs = @[messageVC,friendsVC,discoverVC,mineVC];
    
    NSMutableArray *viewControllers = [NSMutableArray array];

    //通过遍历数组创建导航控制器
    [VCs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        BaseNavigationController *navCT = [[BaseNavigationController alloc] initWithRootViewController:obj];
        [viewControllers addObject:navCT];
    }];
    
    self.viewControllers = viewControllers;
}

#pragma mark - 自定义tabBar栏
- (void)_buildTabBar {
    //1.按钮常态下显示的图片
    _normalImg = @[@"mine_class_h",@"mine_mine_h",@"mine_discover",@"mine_mine_h"];
    
    //2.按钮高亮状态下显示的图片
    _selectedImg = @[@"mine_class_c",@"mine_mine_c",@"mine_discover_c",@"mine_mine_c"];
    
    //3.按钮下面的标题
    NSArray *titleArray = @[@"消息",@"朋友",@"发现",@"我的"];
    
    //4.自定义button UIButton 继承自UIControl
    CGFloat width = kWidth / 4.0;
    CGFloat height = self.tabBar.bounds.size.height;
    UIColor *normalTitleColor = [UIColor blackColor];
    UIColor *selectedTitleColor = RGB(86, 185, 51, 1);

    
    for (int i = 0; i < 4; i ++) {
        
        CGRect itemFrame = CGRectMake(width * i, 0, width, height);
        MainTabItems *itemControl = [[MainTabItems alloc] initWithFrame:itemFrame normalImageName:_normalImg[i] selectedImageNemd:_selectedImg[i] normalFontColor:normalTitleColor selectedFontColor:selectedTitleColor title:titleArray[i]];
        
        itemControl.tag = i;
        itemControl.isSelected = NO;
        if (i == self.selectedIndex) {
            itemControl.isSelected = YES;
            selectedItem = itemControl;
            
        }
        
        [itemControl addTarget:self action:@selector(itemControlAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.tabBar addSubview:itemControl];
        
    }
}

#pragma mark - tabBar栏中的按钮点击事件
- (void)itemControlAction:(MainTabItems *)sender {
    
    if (sender != selectedItem)
    {
        sender.isSelected = YES;
        selectedItem.isSelected = NO;
        selectedItem = sender;
        //跳转至对应的控制器
        self.selectedIndex = sender.tag;
    }
}

#pragma mark - 删除系统自带的导航栏里面的子视图
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSArray *subViews = self.tabBar.subviews;
    for (UIView *view in subViews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [view removeFromSuperview];
        }
    }

}


#pragma mark - 识别班级模块的跳转
- (void) setSelectIndex:(NSInteger)selectIndex {
    
    if (selectIndex != _selectIndex) {
        _selectIndex = selectIndex;
    }
    self.selectedIndex = selectIndex;
    
}



@end
