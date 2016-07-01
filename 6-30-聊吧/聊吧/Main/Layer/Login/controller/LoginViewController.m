//
//  LoginViewController.m
//  聊吧
//
//  Created by m on 16/5/24.
//  Copyright © 2016年 m. All rights reserved.
//


#import "LoginViewController.h"
#import "MainTabBarController.h"
#import "SwitchAccountVC.h"



@interface LoginViewController () <UITextFieldDelegate>

@end

@implementation LoginViewController {
    UIView *translucentView;
    UIView *coverButtonView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    //创建内容视图
    [self _createSubViews];

}

/*
 flag = teacher;
 isHeader = 0;
 key = "UIH1guRH6Mhsboa7WX5j3McEmA6xoPKrOknvTJUmTBc_c";
 pwd = f3HDIyUTP;
 uid = 3237;
 user = 3237;
 */

#pragma mark - 获取登录数据
- (void)loadData {
    
    //请求地址
    NSString *urlString = @"m17/Login/Index";
    
    //请求参数
    NSDictionary *dic = @{
                          @"user":@"liuyisha",
                          @"pwd":@"666666"
                          };
    [NetworkSingleton requestURL:urlString httpMethod:kPOST params:dic successBlock:^(id data) {
        //成功回调
        NSLog(@"成功%@",data);

        NSDictionary *dataDic = (NSDictionary *)data;
        
        UserModel * userModel = [UserModel objectWithKeyValues:dataDic];
        
        //保存用户信息
        [[UserConfig shareInstance] setAllInformation:userModel];
        
        //获取classID
        [self loadClassIDData];
        
    } failedBlock:^(NSError *error) {
        //失败回调
        
    }];
}

#pragma mark - 请求ClassID
- (void)loadClassIDData {
    //请求地址
    NSString *urlString = [NSString stringWithFormat:@"/m17/UserSliderBar/Index"];
    
//    UserModel *userModel = [[UserConfig shareInstance] getAllInformation];

    //请求参数
    NSDictionary *dic = @{
                          @"uid":kUserModel.uid,
                          @"key":kUserModel.key
                          };
    [NetworkSingleton requestURL:urlString httpMethod:kPOST params:dic successBlock:^(id data) {
        //成功回调
        NSLog(@"成功：%@",data);
        ClassModel *classModel = [ClassModel objectWithKeyValues:data];
        
        kUserModel.classModel = classModel;
        //保存
        [[UserConfig shareInstance] setAllInformation:kUserModel];
    } failedBlock:^(NSError *error) {
        //失败回调
        
    }];
    
    
}

//2.创建内容视图
- (void)_createSubViews {
    //底部背景视图
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight - 200)];
    [self.view addSubview:_bgView];
    

    //1.用户头像
    UIImageView *useImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"myself.jpg"]];
    [_bgView addSubview:useImg];
    [useImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bgView).offset(80);
        make.centerX.equalTo(_bgView);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
        useImg.layer.cornerRadius = 40;
        useImg.layer.masksToBounds = YES;
    }];
    
    //2.用户账号
    _numberLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _numberLabel.textAlignment = NSTextAlignmentCenter;
    _numberLabel.text = @"123456";
    _numberLabel.font = [UIFont systemFontOfSize:16];
    _numberLabel.textColor = [UIColor blackColor];
    [_bgView addSubview:_numberLabel];
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(useImg.mas_bottom).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
        make.centerX.equalTo(_bgView);
    }];
    
    //3.密码输入框
    _passField = [[UITextField alloc] initWithFrame:CGRectZero];
    _passField.delegate = self;
    _passField.secureTextEntry = YES;
    _passField.borderStyle = UITextBorderStyleNone;
    _passField.placeholder = @"请输入密码";
    _passField.textColor = [UIColor blackColor];
//    _passField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_bgView addSubview:_passField];
    [_passField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_numberLabel.mas_bottom).offset(50);
        make.left.equalTo(_bgView.mas_left).offset(60);
        make.right.equalTo(_bgView.mas_right).offset(-60);
        make.height.mas_equalTo(40);
    }];
    NSLog(@"%f",_passField.bounds.size.width);
    
    //输入框的下划线
    UIView *sepView = [[UIView alloc] initWithFrame:CGRectZero];
    sepView.backgroundColor = [UIColor greenColor];
    [_bgView addSubview:sepView];
    [sepView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passField.mas_bottom);
        make.left.equalTo(_passField.mas_left).offset(-45);
        make.right.equalTo(_passField.mas_right).offset(45);
        make.height.mas_equalTo(0.5);
    }];
    
    //左边图片
    _lockButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_lockButton setImage:[UIImage imageNamed:@"lock1.jpg"] forState:UIControlStateNormal];
    [_lockButton addTarget:self action:@selector(lockAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:_lockButton];
    [_lockButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_passField.mas_left).offset(-5);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
        make.bottom.equalTo(sepView.mas_top).offset(-5);
    }];
    
    //右边清除按钮
    _clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _clearButton.hidden = YES;
    [_clearButton setImage:[UIImage imageNamed:@"叉.png"] forState:UIControlStateNormal];
    [_clearButton addTarget:self action:@selector(clearAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_bgView addSubview:_clearButton];
    [_clearButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_passField.mas_right).offset(5);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
        make.bottom.equalTo(sepView.mas_top).offset(-5);
        _clearButton.layer.cornerRadius = 15;
    }];
    
    //4.登录按钮
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    loginButton.backgroundColor = [UIColor greenColor];
    loginButton.layer.cornerRadius = 10;
    [loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_bgView addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lockButton.mas_left);
        make.right.equalTo(_clearButton.mas_right);
        make.top.equalTo(sepView.mas_bottom).offset(20);
        make.height.mas_equalTo(50);
    }];
    
    //覆盖登录按钮的半透明视图
    coverButtonView = [[UIView alloc] init];
    coverButtonView.backgroundColor = RGB(148, 153, 60, 0.3);
    
    [_bgView addSubview:coverButtonView];
    
    [coverButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lockButton.mas_left);
        make.right.equalTo(_clearButton.mas_right);
        make.top.equalTo(sepView.mas_bottom).offset(20);
        make.height.mas_equalTo(50);
        coverButtonView.layer.cornerRadius = 10;
    }];
    
    //遇到登录问题按钮
    UIButton *helpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    helpButton.backgroundColor = [UIColor clearColor];
    [helpButton setTitle:@"登录遇到问题？" forState:UIControlStateNormal];
    [helpButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [helpButton addTarget:self action:@selector(helpAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_bgView addSubview:helpButton];
    [helpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lockButton.mas_left);
        make.right.equalTo(_clearButton.mas_right);
        make.top.equalTo(loginButton.mas_bottom).offset(5);
        make.height.mas_equalTo(50);
    }];
    
    //5.更多内容按钮
    UIButton *moreButton = [self setButtonWithTitle:@"更多" tag:01 target:self selector:@selector(moreAction:)];
    moreButton.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:moreButton];
    
    [moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lockButton.mas_left);
        make.right.equalTo(_clearButton.mas_right);
        make.bottom.equalTo(self.view.mas_bottom).offset(-20);
        make.height.mas_equalTo(50);
    }];
    
}


#pragma mark - 密码锁按钮点击事件
//1.密码可见性按钮
- (void)lockAction:(UIButton *)button {
    static BOOL secureTextEntry = YES;
    if (secureTextEntry) {
        secureTextEntry = NO;
        _passField.secureTextEntry = YES;
    }
    else {
        secureTextEntry = YES;
        _passField.secureTextEntry = NO;
    }
}


#pragma mark - 2.清空输入框按钮点击事件
- (void)clearAction:(UIButton *)button {
    _passField.text = nil;
    _clearButton.hidden = YES;
    coverButtonView.hidden = NO;
}

#pragma mark - 3.登录按钮点击事件
- (void)loginAction:(UIButton *)button {
    NSLog(@"正在登录");
    
    MainTabBarController *tabBarCT = [[MainTabBarController alloc] init];
    [self.navigationController pushViewController:tabBarCT animated:YES];
    [self loadData];
    //登录成功之后,标记用户已经登录
//    [kUserDefaults setBool:YES forKey:kIsLogin];
//    [kUserDefaults synchronize];
    
}


#pragma mark - 4.遇到登录问题按钮
- (void)helpAction:(UIButton *)button {
    NSLog(@"遇到登录问题");
    
}


#pragma mark - 5.更多选择按钮
- (void)moreAction:(UIButton *)button {
    //覆盖全屏的阴影视图
    translucentView = [[UIView alloc] initWithFrame:self.view.bounds];
    translucentView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickedTranslucentViewAction:)];
    [translucentView addGestureRecognizer:tap];
    
    translucentView.backgroundColor = RGB(48, 53, 60, 0.5);
    [[UIApplication sharedApplication].keyWindow addSubview:translucentView];
    
    [self _createSelectionView];
    
}

//3.创建选择对话框
- (void)_createSelectionView {
    //背景图
    _selectionView = [[UIView alloc] initWithFrame:CGRectZero];
    _selectionView.backgroundColor = [UIColor clearColor];
    
    [translucentView addSubview:_selectionView];
    
    [_selectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(translucentView.mas_left).offset(60);
        make.right.equalTo(translucentView.mas_right).offset(-60);
        make.bottom.equalTo(translucentView.mas_bottom).offset(-270);
        make.height.mas_equalTo(151);
        
        _selectionView.layer.cornerRadius = 3;
        _selectionView.layer.masksToBounds = YES;
    }];
    
    //切换账号按钮
    UIButton *changeNumButton = [self setButtonWithTitle:@"切换账号" tag:10 target:self selector:@selector(ButtonClickedAction:)];
    
    [_selectionView addSubview:changeNumButton];
    
    [changeNumButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_selectionView.mas_left);
        make.right.equalTo(_selectionView.mas_right);
        make.top.equalTo(_selectionView.mas_top);
        make.height.mas_equalTo(50);
        
    }];
    
    //注册按钮
    UIButton *registButton = [self setButtonWithTitle:@"注册" tag:20 target:self selector:@selector(ButtonClickedAction:)];
    
    [_selectionView addSubview:registButton];
    [registButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_selectionView.mas_left);
        make.right.equalTo(_selectionView.mas_right);
        make.top.equalTo(changeNumButton.mas_bottom).offset(0.5);
        make.height.mas_equalTo(50);
    }];
    
    //安全中心按钮
    UIButton *securityButton = [self setButtonWithTitle:@"安全种中心" tag:30 target:self selector:@selector(ButtonClickedAction:)];
    
    [_selectionView addSubview:securityButton];
    
    [securityButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_selectionView.mas_left);
        make.right.equalTo(_selectionView.mas_right);
        make.top.equalTo(registButton.mas_bottom).offset(0.5);
        make.height.mas_equalTo(50);
    }];
    
}

//设置button
- (UIButton *)setButtonWithTitle:(NSString *)title tag:(NSInteger) tag target:(id)target selector:(SEL)sel {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor whiteColor];
    button.tag = tag;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}


#pragma mark - 半透明视图点击事件
- (void)clickedTranslucentViewAction:(UITapGestureRecognizer *)tap {
    translucentView.hidden = YES;
    
}

#pragma mark - 选项按钮点击事件
- (void)ButtonClickedAction:(UIButton *)button {
    //切换账号按钮
    if (button.tag == 10) {
        NSLog(@"切换账号");
        SwitchAccountVC *switchAccountVC = [[SwitchAccountVC alloc] init];
        [self.navigationController pushViewController:switchAccountVC animated:YES];
        
    }
    //注册按钮
    if (button.tag == 20) {
        NSLog(@"注册");
    

    }
    //安全中心按钮
    else if (button.tag == 30) {
       NSLog(@"安全中心");

    }
    translucentView.hidden = YES;
}

#pragma mark - 屏幕点击事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    _bgView.transform = CGAffineTransformIdentity;
}


#pragma mark - UITextField 代理方法
//清除文字按钮点击事件
- (BOOL)textFieldShouldClear:(UITextField *)textField {
    _passField.text = nil;
    return YES;
}

//将要开始输入时
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    //bgView位置上移
    _bgView.transform = CGAffineTransformMakeTranslation(0, -60);
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    
    return YES;
}

//输入框的内容开始改变的时候调用
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (_passField.text != nil) {
        _clearButton.hidden = NO;
        coverButtonView.hidden = YES;
    }
//    if (_passField.text.length == 1) {
//        _clearButton.hidden = YES;
//    }
    
    return YES;
}

//return 按钮点击事件
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    //_bgView 的位置复原
    _bgView.transform = CGAffineTransformIdentity;
    
    //如果账号或者密码为空，则弹出提示框
    if ([_passField.text isEqualToString:@""] || [_numberLabel.text isEqual:@""]) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"登录失败" message:@"密码及账号不能为空" preferredStyle:UIAlertControllerStyleAlert];
        //添加确定按钮
        [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            //点击确定按钮的事件
            
        }]];
        
        //显示提示框
        [self presentViewController:alertVC animated:YES completion:nil];
        
    }
    //直接登录
    else if  ([_numberLabel.text isEqualToString: @"123456"] && [_passField.text isEqualToString:@"654321"]) {
        MainTabBarController *tabBarCT = [[MainTabBarController alloc] init];
        [self.navigationController pushViewController:tabBarCT animated:YES];
        
    }
    else {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"登录失败" message:@"密码与账号匹配" preferredStyle:UIAlertControllerStyleAlert];
        //添加确定按钮
        [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            //点击确定按钮的事件
            //清除输入框的内容
            _passField.text = nil;
            _clearButton.hidden = YES;
            
        }]];
        //显示提示框
        [self presentViewController:alertVC animated:YES completion:nil];
        
    }
    
    return YES;
}


@end
