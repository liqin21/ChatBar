//
//  DetailNotificationVC.m
//  聊吧
//
//  Created by m on 16/6/25.
//  Copyright © 2016年 m. All rights reserved.
//

#import "DetailNotificationVC.h"

@interface DetailNotificationVC ()

@end

@implementation DetailNotificationVC {
    UIWebView *_webView;
    NSDictionary *dataDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [self setNavigationBar];
    
    //创建webView
    [self createWebView];
    
    //加载数据
    [self loadHtlm5];
    [self loadData];
}

#pragma mark - 设置导航栏
- (void)setNavigationBar {
    //左边返回按钮
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"up"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(leftitemAction:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //右边下一条按钮
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"下一条" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction:)];
    self.navigationItem.rightBarButtonItem = rightItem ;
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
}

#pragma mark - 导航项点击事件
- (void)leftitemAction:(UIBarButtonItem *)item {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightItemAction:(UIBarButtonItem *)item {
    
    if (dataDic.count == 0) {
        //弹出提示框
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"没有下一条" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertVC animated:YES completion:nil];
        return;
    }
    else {
        //设置数据
        self.htmlID = dataDic[@"id"];
        self.htlmString = dataDic[@"url"];
        //加载下一条数据
        [self loadHtlm5];
        [self loadData];
    }
    
}

#pragma mark - 创建webView 
- (void)createWebView {
    
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_webView];
    
}


#pragma mark - 加载数据
- (void)loadHtlm5 {
   
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:self.htlmString]];
    self.body = [NSString stringWithFormat:@"key=%@",@"UIH1guRH6Mhsboa7WX5j3Cs0cmgBSlWBBNfpRhAWlEY_c"];
    [request setHTTPBody:[self.body dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPMethod:kPOST];
    [_webView loadRequest:request];

}


- (void)loadData {
    //地址
    NSString *urlString = [NSString stringWithFormat:@"/m17/SchoolNotice/GetNext/noticeid/%@/uid/%@",self.htmlID,kUserModel.uid];
    
    NSDictionary *dic = @{
                          @"key":kUserModel.key
                          };
    
    [NetworkSingleton requestURL:urlString httpMethod:kPOST params:dic successBlock:^(id data) {
        NSLog(@"通知详情加载成功%@",data);
        dataDic = data;
        
    } failedBlock:^(NSError *error) {
        NSLog(@"数据加载失败%@",error);
        
    }];
}




@end
