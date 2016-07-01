//
//  ClassmateDetailVC.m
//  聊吧
//
//  Created by m on 16/6/20.
//  Copyright © 2016年 m. All rights reserved.
//

#import "ClassmateDetailVC.h"
#import "ClassmateDetailModel.h"
#import "MyClassViewController.h"
#import "ClassmateDetailCell.h"
#import "UIImageView+AFNetworking.h"

#define KMyClassmateCellID  @"MyClassmateCell"


@interface ClassmateDetailVC () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation ClassmateDetailVC {
    
    NSMutableArray *_data;
    
    UIButton *sendButton;
    
    UIButton *flowerButton;
    
    NSInteger index;
    
    UIImageView *imageView;
    
    UILabel *nameLabel;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //此代码隐藏当前页面的导航栏，当返回至上一界面的时候，会把上一界面的导航栏也隐藏掉
    //    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.navigationController.navigationBar.hidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //用[self.navigationController setNavigationBarHidden:YES animated:NO];隐藏导航栏时，在视图即将隐藏时显示导航栏，否则会把上一界面的导航栏隐藏掉
    //    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (instancetype)initWithID:(NSString *)ID
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _ID = ID;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(246, 246, 246, 1);
    
    //1.加载数据
    [self loadData];
    
    //2.创建表视图
    [self createTableView];
    
}

#pragma mark - 加载数据
- (void)loadData {

    NSDictionary *dic = @{
                          @"uid":kUserModel.uid,
                          @"id":self.ID,
                          @"key":kUserModel.key
      
                          };
    
    [NetworkSingleton requestURL:@"/m00/M0005I/M0005I02" httpMethod:kPOST params:dic successBlock:^(id data) {
    
        NSLog(@"成功获取好友详情%@",data);
        _classmateDetailModel = [ClassmateDetailModel objectWithKeyValues:data];
        [_tableView reloadData];
        [imageView setImageWithURL:[NSURL URLWithString:_classmateDetailModel.HeadImage]];
        nameLabel.text = _classmateDetailModel.RealName;
    
    } failedBlock:^(NSError *error) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:error.userInfo[@"NSLocalizedDescription"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }];
    
}

#pragma mark - 创建表视图
- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight - 160) style:UITableViewStyleGrouped];
    _tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    [self createTableViewHeaderView];
    
    [self createFooterView];
    
}

//表视图的头视图
- (void)createTableViewHeaderView {
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 220)];
    bgView.backgroundColor = RGB(39, 105, 100, 1);
    
    _tableView.tableHeaderView = bgView;
    
    //返回按钮
    UIButton *blackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [blackButton addTarget:self action:@selector(blackButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [blackButton setImage:[UIImage imageNamed:@"black"] forState:UIControlStateNormal];
    
    //头像
    imageView = [[UIImageView alloc] init];
    
    //姓名
    nameLabel = [[UILabel alloc] init];
    nameLabel.font = [UIFont systemFontOfSize:20];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    
    [bgView sd_addSubviews:@[blackButton,imageView,nameLabel]];
    
    blackButton.sd_layout.leftSpaceToView(bgView,5).topSpaceToView(bgView,20).widthIs(28).heightIs(28);
    
    imageView.sd_layout.centerXEqualToView(bgView).centerYEqualToView(bgView).heightIs(100).widthIs(100);
    imageView.layer.cornerRadius = 50;
    imageView.layer.masksToBounds = YES;
    nameLabel.sd_layout.centerXEqualToView(bgView).topSpaceToView(imageView,10).heightIs(20);
    [nameLabel setSingleLineAutoResizeWithMaxWidth:120];
}

//底部的两个按钮
- (void)createFooterView {
    UIView *footerView = [[UIView alloc] init];

    [self.view addSubview:footerView];
    footerView.sd_layout.rightEqualToView(self.view).leftEqualToView(self.view).bottomEqualToView(self.view).heightIs(160);
    
    //发送消息按钮
    sendButton = [self setButtonWithTitle:@"发消息" image:@"myinfFriend_xiaoxi" titleColor:[UIColor whiteColor] tag:1 action:@selector(buttonAction:)];
    
    //送鲜花按钮
    
    flowerButton = [self setButtonWithTitle:@"送鲜花" image:@"myinfFriend_hua" titleColor:[UIColor blackColor] tag:2 action:@selector(buttonAction:)];
    
    [footerView sd_addSubviews:@[sendButton,flowerButton]];
    
    //设置约束
    flowerButton.sd_layout.leftSpaceToView(footerView,10).rightSpaceToView(footerView,10).bottomSpaceToView(footerView,30).heightIs(42);
    sendButton.sd_layout.leftSpaceToView(footerView,10).rightSpaceToView(footerView,10).bottomSpaceToView(flowerButton,15).heightIs(42);
    
}

- (UIButton *)setButtonWithTitle:(NSString *)title image:(NSString *)image titleColor:(UIColor *)color tag:(NSInteger )tag action:(SEL)sel {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.tag = tag;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

#pragma mark -发消息按钮和送鲜花按钮点击事件
- (void)buttonAction:(UIButton *) button {
    if (button.tag == 2) {
        NSLog(@"送鲜花");
    }
    else {
        NSLog(@"发消息");
    }
}

#pragma mark - 头视图上返回按钮点击事件
- (void)blackButtonAction:(UIButton *)button {
    
    [self.navigationController popViewControllerAnimated:YES];
    
    //    MyClassViewController *myClassCT = [[MyClassViewController alloc] init];
    //
    //    [self.navigationController pushViewController:myClassCT animated:YES];
}

#pragma mark - UITableView 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"myClassmateCell";
    ClassmateDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ClassmateDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            cell.leftLabel.sd_layout.centerYEqualToView(cell.contentView);
            cell.rightLabel.sd_layout.centerYEqualToView(cell.contentView);
            
            if ([_classmateDetailModel.RoleName isEqualToString:@"老师"])
            {
                cell.leftLabel.text = @"所在学校:";
            }
            else {
                cell.leftLabel.text = @"孩子学校:";
            }
            cell.rightLabel.text = _classmateDetailModel.SchoolName;
        }
        
        else {
            cell.leftLabel.text = @"最新动态:";
            cell.rightLabel.text = ([_classmateDetailModel.Content isEqualToString:@""] || (_classmateDetailModel.Content == nil))?@"无内容":_classmateDetailModel.Content;
            cell.rightLabel.textColor = [UIColor darkGrayColor];
        }
    }
    if (indexPath.section == 1)
    {
        cell.leftLabel.text = @"备注好友:";
        cell.rightLabel.text = @"张黎黎";
    }
    
    return cell;
}

//设置单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    id model = _data[indexPath.row];
//    return [_tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[MyClassmateTableViewCell class] contentViewWidth:[self cellContentViewWidth]];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 44.0f;
        }
        else {
            return 100;
        }
    }
    else {
        return 44.0f;
    }
}


- (CGFloat)cellContentViewWidth {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    //适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.width;
    }
    return width;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 20;
    }
    else {
        return 25;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

@end
