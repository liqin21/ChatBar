//
//  MineDataViewController.m
//  家校通
//
//  Created by m on 16/6/8.
//  Copyright © 2016年 m. All rights reserved.
//

#import "MineDataViewController.h"
#import "MineDataTableViewCell.h"
#import "MineModel.h"
#import "TranslucentView.h"
#import "MineNicknameViewController.h"

#define kMineDataTabelViewCell @"mineDataTabelViewCell"

//屏幕的宽度，屏幕的高度
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width

@interface MineDataViewController () <UITableViewDelegate,UITableViewDataSource>

//@property(nonatomic,strong) UITableView *myInfoTableView;

@end

@implementation MineDataViewController {
    UITableView *_tableView;
    TranslucentView *translucentView;
    NSMutableArray *_data;
    UIButton *rightButton;
    UIView *transparentView;
    MineNicknameViewController *mineNicknameCT;
    NSArray *titleArr;
    NSArray *imageArr;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    
    //1.加载数据
    [self loadData];
    
    //2.设置导航栏
    [self setNavigaitionBar];
    
    //3.创建表视图
    [self createTableView];
    
    //4.覆盖全屏的透明视图
    [self createTransparentView];
    
    
    
    mineNicknameCT = [[MineNicknameViewController alloc] init];
}


#pragma mark -加载数据
- (void)loadData {
    _data = [NSMutableArray array];
    //标题
    titleArr = @[@"我的头像",@"我的昵称",@"我的性别",@"所在学校"];
    //头像
    imageArr = @[@"myZiliao_mytouxiang",@"myZiliao_myname",@"myZiliao_sex",@"myZiliao_school"];
    
    NSDictionary *dic = @{
                          @"uid":kUserModel.uid,
                          @"id":kUserModel.uid,
                          @"key":kUserModel.key
                          };
    
    [kNetworkSingleton requestURL:@"/m00/M0005I/M0005I02" httpMethod:kPOST params:dic successBlock:^(id data) {
        NSLog(@"个人信息数据加载成功%@",data);
        
        
    } failedBlock:^(NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:error.userInfo[@"NSLocalizedDescription"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];

    }];
    
    
    
    //创建数据
//    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"myZiliao_mytouxiang",@"imageName",@"我的头像",@"title",@"",@"content", nil];
//    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"myZiliao_myname",@"imageName",@"我的昵称",@"title",@"麦子小姐",@"content", nil];
//    NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"myZiliao_sex",@"imageName",@"我的性别",@"title",@"女",@"content", nil];
//    NSDictionary *dic4 = [NSDictionary dictionaryWithObjectsAndKeys:@"myZiliao_school",@"imageName",@"所在学校",@"title",@"长郡中学",@"content", nil];
//    NSArray *array = [NSArray array];
//  @[dic1,dic2,dic3,dic4];
    //利用MJ快速创建model
//    for (NSDictionary *dic in array) {
//        MineDataModel *model = [MineDataModel objectWithKeyValues:dic];
//        [_data addObject:model];
//    }
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
    rightButton = [self creatButtonWithTitle:@"编辑" target:self selector:@selector(navigationItemButtonAction:) tag:2];
    rightButton.frame = CGRectMake(0, 0, 40, 40);
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

////设置导航栏右边按钮
//- (void)setMyInfoEditType:(MyInfoEditType)myInfoEditType {
//    if (_myInfoEditType == MyInfoEdit) {
//        rightButton = [self creatButtonWithTitle:@"编辑" target:self selector:@selector(navigationItemButtonAction:) tag:2];
//        
//    }
//    else if (_myInfoEditType == MyInfoDone) {
//        rightButton = [self creatButtonWithTitle:@"完成" target:self selector:@selector(navigationItemButtonAction:) tag:2];
//        
//    }
//    
//}

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
    static BOOL click = YES;
    if (button.tag == 1) {
        [self.navigationController popViewControllerAnimated:YES];
        transparentView.hidden = NO;
        [rightButton setTitle:@"编辑" forState:UIControlStateNormal];
        click = YES;
    }
    else if (button.tag == 2) {
        NSLog(@"编辑");
        if (click) {
            click = NO;
            transparentView.hidden = YES;
            [rightButton setTitle:@"完成" forState:UIControlStateNormal];
        }
        else {
            click = YES;
            transparentView.hidden = NO;
            [rightButton setTitle:@"编辑" forState:UIControlStateNormal];
        }
    }
}

#pragma mark - 覆盖全屏的透明视图
- (void)createTransparentView {
    
    transparentView = [[UIView alloc] initWithFrame:self.view.frame];
    
    transparentView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:transparentView];
}





#pragma mark - 创建表视图
- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
    
    //点击我的头像单元格出现的视图
    translucentView = [[TranslucentView alloc] initWithFrame:self.view.bounds];
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:translucentView];
}

#pragma mark - UITabelView的代理方法
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *identifier = @"mineDataTabelViewCell";
    MineDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMineDataTabelViewCell];
    if (cell == nil) {
        cell = [[MineDataTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kMineDataTabelViewCell];
    }
    
    cell.titleLabel.text = titleArr[indexPath.row];
    cell.leftImage.image = [UIImage imageNamed:imageArr[indexPath.row]];
    
    if (indexPath.row == 0) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.contentLabel removeFromSuperview];
        UIImageView *iconImage = [[UIImageView alloc] init];
        iconImage.image = [UIImage imageNamed:@"005"];
        [cell.contentView addSubview:iconImage];
        
        iconImage.sd_layout.rightSpaceToView(cell.contentView,45).centerYEqualToView(cell.contentView).widthIs(50).heightIs(50);
    }
    
    

    if (indexPath.row == 2) {
        
    }
    
    //设置数据
//    cell.model = _data[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

#pragma mark - 单元格点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (indexPath.row == 0) {
        translucentView.hidden = NO;
        translucentView.selectBgView.hidden = NO;
    }
    if (indexPath.row == 1) {
        [self.navigationController pushViewController:mineNicknameCT animated:YES];
        MineDataTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        __weak typeof (mineNicknameCT) weakMineNicknameCT = mineNicknameCT;
        mineNicknameCT.clickTrueButtonBlock = ^() {
            cell.contentLabel.text = weakMineNicknameCT.textView.text;
        };
    }
    
    if (indexPath.row == 2) {
        translucentView.hidden = NO;
        translucentView.sexBgView.hidden = NO;
        
        MineDataTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        //男
        translucentView.maleBlock = ^() {
            
            cell.contentLabel.text = @"男";
        };
        //女
        translucentView.femaleBlock = ^() {
            cell.contentLabel.text = @"女";
        };
    }
    
    if (indexPath.row == 3) {
        [self.navigationController pushViewController:mineNicknameCT animated:YES];
        
        MineDataTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        __weak typeof (mineNicknameCT) weakMineNicknameCT = mineNicknameCT;
        mineNicknameCT.clickTrueButtonBlock = ^() {
            cell.contentLabel.text = weakMineNicknameCT.textView.text;
        };

    }
}


@end
