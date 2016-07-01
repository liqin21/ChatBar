//
//  ClassCourseVC.m
//  聊吧
//
//  Created by m on 16/6/17.
//  Copyright © 2016年 m. All rights reserved.
//

#import "ClassCourseVC.h"
#import "NotificationVC.h"
#import "MyClassViewController.h"
#import "AppDelegate.h"
#import "MainTabBarController.h"

@interface ClassCourseVC ()

@end

@implementation ClassCourseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //创建UIWebView
    [self createWebView];

}

#pragma mark - 创建UIWebView
- (void)createWebView {
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    
    //加载数据
    NSString *string = [NSString stringWithFormat:@"m06/M0627P01/M0627P01002/userid/%@/classid/%@",kUserModel.uid,kUserModel.classModel.classid];
    
    //拼接地址
    NSString *urlString = [baseUrl stringByAppendingString:string];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    
    NSString *body = [NSString stringWithFormat:@"key =  %@",kUserModel.key];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    [webView loadRequest:request];
}
    

@end
