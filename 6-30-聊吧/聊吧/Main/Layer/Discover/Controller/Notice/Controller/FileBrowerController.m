
//
//  FileBrowerController.m
//  聊吧
//
//  Created by m on 16/6/29.
//  Copyright © 2016年 m. All rights reserved.
//

#import "FileBrowerController.h"

@interface FileBrowerController ()

@end

@implementation FileBrowerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.fileTitle;
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //设置导航栏
    [self setNavigationBar];
    
    //创建webView
    [self createWebView];
    
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

#pragma mark - 创建webView
- (void)createWebView {
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight - 64)];
    //页面尺寸自适应
    webView.scalesPageToFit = YES;
    
    [self.view addSubview:webView];
    
    //加载页面
    NSURLRequest *request = [NSURLRequest requestWithURL:self.fileURL];
    [webView loadRequest:request];

}



@end
