//
//  NotificationWebVC.m
//  聊吧
//
//  Created by m on 16/6/24.
//  Copyright © 2016年 m. All rights reserved.
//

#import "NotificationWebVC.h"

@interface NotificationWebVC ()<UIWebViewDelegate>

@end

@implementation NotificationWebVC {
    NSDictionary *dicData;
    UIWebView *webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //设置导航栏
    [self setNavigationBar];
    
    //创建webView
    [self createWebView];
    
    //加载HTML数据
    [self loadHtml5];
    
    //加载数据
    [self loadData];

}

#pragma mark - 设置导航栏
- (void)setNavigationBar {
    
    //左边导航项
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"black"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(leftItemAction:)];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //右边导航项
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"下一条" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction:)];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
}

#pragma mark - 导航项点击事件
- (void)leftItemAction:(UIBarButtonItem *)item {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)rightItemAction:(UIBarButtonItem *)item {
    NSLog(@"下一条");
    if (dicData.count == 0) {
        //弹出提示框
        UIAlertController *alertCT = [UIAlertController alertControllerWithTitle:@"没有下一条" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertCT addAction:[UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertCT animated:YES completion:nil];
    }
    else {
        //设置数据
        self.htmlID = dicData[@"id"];
        self.htmlString = dicData[@"url"];
        
        //加载下一条数据
        [self loadHtml5];
        [self loadData];
    }
    
}

#pragma mark - 创建webView
- (void)createWebView {
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight)];
    
    webView.delegate = self;
    
    [self.view addSubview:webView];
}


#pragma mark - 加载html5数据
- (void)loadHtml5 {
    
    //加载数据
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:self.htmlString]];
    self.body = [NSString stringWithFormat:@"key=%@",@"UIH1guRH6Mhsboa7WX5j3Cs0cmgBSlWBBNfpRhAWlEY_c"];
    
    [request setHTTPBody:[self.body dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPMethod:kPOST];
    
    [webView loadRequest:request];
    
    
}

#pragma mark - 加载数据
- (void)loadData {
    //请求地址
    NSString *urlString = [NSString stringWithFormat:@"/m17/ClassNotice/GetNext/noticeid/%@/",self.htmlID];
    
    //请求参数
    NSDictionary *dic = @{
                          @"key":kUserModel.key
                          };
    //请求网络
    [NetworkSingleton requestURL:urlString httpMethod:kPOST params:dic successBlock:^(id data) {
        NSLog(@"通知详情数据加载成功%@",data);
        dicData = data;
        
    } failedBlock:^(NSError *error) {
       NSLog(@"通知详情数据加载失败%@",error);
        
    }];
    
}





@end
