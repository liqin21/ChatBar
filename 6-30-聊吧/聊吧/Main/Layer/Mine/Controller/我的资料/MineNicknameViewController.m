//
//  MineNicknameViewController.m
//  家校通
//
//  Created by m on 16/6/10.
//  Copyright © 2016年 m. All rights reserved.
//

#import "MineNicknameViewController.h"

@interface MineNicknameViewController ()

@end

@implementation MineNicknameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"输入昵称";
    self.view.backgroundColor = RGB(245, 245, 245, 1);
//
    //1.设置导航栏
    [self setNavigaitionBar];
    
    //2.创建输入框
    [self creatTextVeiw];
    
}


#pragma mark -设置导航栏
- (void)setNavigaitionBar {
    //左边导航项
    UIButton *leftButton = [self creatButtonWithTitle:@"" target:self selector:@selector(navigationItemButtonAction:) tag:1];
    leftButton.frame = CGRectMake(0, 0, 25, 25);
    [leftButton setBackgroundImage:[UIImage imageNamed:@"black"] forState:UIControlStateNormal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //右边导航项
    UIButton *rightButton = [self creatButtonWithTitle:@"完成" target:self selector:@selector(navigationItemButtonAction:) tag:2];
    rightButton.frame = CGRectMake(0, 0, 40, 40);
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}


- (UIButton *)creatButtonWithTitle:(NSString *)title target:(id)target selector:(SEL)sel tag:(NSInteger)i {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    button.tag = i;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    return button;
}


#pragma mark - 导航项点击事件
- (void)navigationItemButtonAction:(UIButton *)button {
    
    if (button.tag == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (button.tag == 2) {
        NSLog(@"完成");
        [self.navigationController popViewControllerAnimated:YES];
        //调用Block
        if (_clickTrueButtonBlock) {
            _clickTrueButtonBlock();
        }
    }
}

#pragma mark - 输入框
- (void)creatTextVeiw {

    self.edgesForExtendedLayout = UIRectEdgeNone;
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 20,kWidth ,80)];

    
    [self.view addSubview:_textView];
}

@end
