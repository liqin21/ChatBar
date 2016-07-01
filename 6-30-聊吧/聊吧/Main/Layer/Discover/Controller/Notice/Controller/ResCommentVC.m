//
//  ResCommentVC.m
//  聊吧
//
//  Created by m on 16/6/28.
//  Copyright © 2016年 m. All rights reserved.
//

#import "ResCommentVC.h"
#import "ResCommentCell.h"
#import "PublicResModel.h"
#import "FCCommentBar.h"
#import "ResCommentModel.h"


@interface ResCommentVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,FCCommentBarDelegate>

@property (nonatomic,strong) NSMutableArray *dataArray;



@end

@implementation ResCommentVC {
    UITableView *_tableView;
    UILabel *titleLabel;
    UILabel *timeLabel;
    UILabel *authoLabel;
    UILabel *countLabel;
    FCCommentBar *commentBar;
    UIView *fieldBgView;
    NSInteger currentCommCount;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评论";
    self.view.backgroundColor = [UIColor greenColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //设置导航栏
    [self setNavigationBar];
    
    //加载数据
    [self loadData];
    
    //创建表视图
    [self createTableView];
    
    //创建评论视图
    [self createCommentView];
    
     //创建评论输入框
    [self _createCommentBar];
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


#pragma mark - 加载数据
- (void)loadData {
    //地址
    NSString *urlStr = [NSString stringWithFormat:@"m30/m3002I/m3002I009/resId/%@",self.publicModel.Id];
    
    [kNetworkSingleton requestURL:urlStr httpMethod:kGET params:nil successBlock:^(id data) {
        NSLog(@"评论数据请求成功%@",data);
        //如果返回的不是字典，则返回错误
        if (![data isKindOfClass:[NSDictionary class]]) {
            return ;
        }
        //数据为0
        NSDictionary *dataDic = (NSDictionary *)data;
        if (dataDic.count == 0) {
            return;
        }
        _dataArray = [NSMutableArray array];
        NSArray *tempArray = dataDic[@"comment"];
        for (NSDictionary *dic in tempArray) {
            NSDictionary *commentData = dic[@"commentData"];
            ResCommentModel *model = [ResCommentModel objectWithKeyValues:commentData];
            [_dataArray addObject:model];
        }
        //个数
        NSNumber *totalCount = dataDic[@"totalCount"];
        currentCommCount = [totalCount integerValue];
        countLabel.text = [NSString stringWithFormat:@"评论数(%ld)",currentCommCount];
        //刷新表视图
        [_tableView reloadData];
    
    } failedBlock:^(NSError *error) {
        NSLog(@"评论数据请求失败%@",error);
    }];

}


#pragma mark - 创建表视图
- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight - 64 - 60) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = [self createTableHeaderView];
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
}

#pragma mark -表视图的头视图
- (UIView *)createTableHeaderView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 130)];
    headerView.backgroundColor = [UIColor whiteColor];
    //标题
    titleLabel = [[UILabel alloc] init];
//    titleLabel.text = @"国学大讲堂";
    titleLabel.text = self.publicModel.Title;
    titleLabel.textColor = [UIColor blackColor];

    //作者
    authoLabel = [[UILabel alloc] init];
    //    authoLabel.text = [NSString stringWithFormat:@"作者:%@",@"林语堂"];
    authoLabel.text = [NSString stringWithFormat:@"作者:%@",self.publicModel.UserName];
    authoLabel.textColor = [UIColor blackColor];
    authoLabel.font = [UIFont systemFontOfSize:12];
    
    //时间
    timeLabel = [[UILabel alloc] init];
    //    timeLabel.text = [NSString stringWithFormat:@"时间:%@",@"2016-6-27 14:05:23"];
    timeLabel.text = [NSString stringWithFormat:@"上传时间:%@",self.publicModel.UploadTime];
    timeLabel.textColor = [UIColor blackColor];
    timeLabel.font = [UIFont systemFontOfSize:12];
    
    //评论数量
   UIImageView *leftImage = [[UIImageView alloc] init];
    leftImage.image = [UIImage imageNamed:@"hot_ico"];
    
    countLabel = [[UILabel alloc] init];
    countLabel.text = @"评论数量(4)";
    
    countLabel.font = [UIFont systemFontOfSize:12];
    
    [headerView sd_addSubviews:@[titleLabel,authoLabel,timeLabel,leftImage,countLabel]];
    
    //设置约束
    titleLabel.sd_layout.leftSpaceToView(headerView,10).topSpaceToView(headerView,15).heightIs(20);
    [titleLabel setSingleLineAutoResizeWithMaxWidth:kWidth];
    
    authoLabel.sd_layout.leftSpaceToView(headerView,10).topSpaceToView(titleLabel,10).heightIs(15);
    [authoLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    timeLabel.sd_layout.leftSpaceToView(authoLabel,15).topEqualToView(authoLabel).heightIs(15);
    [timeLabel setSingleLineAutoResizeWithMaxWidth:180];
    
    leftImage.sd_layout.leftEqualToView(titleLabel).topSpaceToView(authoLabel,21).heightIs(12).widthIs(14);
    
    countLabel.sd_layout.leftSpaceToView(leftImage,10).topEqualToView(leftImage).heightIs(12);
    [countLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    return headerView;
}

#pragma mark - UITableView 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"commentCell";
    ResCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ResCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    //设置数据
    cell.model = _dataArray[indexPath.row];
    ResCommentModel *model = _dataArray[indexPath.row];
    model.indexPath = indexPath;
    return cell;
}

#pragma mark - 设置单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //>>>>>>>>>>>>>>>> * cell自适应>>>>>>>>>>>>>>>>>>>
    id model = self.dataArray[indexPath.row];
    
    return [_tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[ResCommentCell class] contentViewWidth:[self cellContentViewWith]];
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

#pragma mark - 单元格点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -滑动事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}


#pragma mark - 创建评论视图
- (void)createCommentView {
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kHeight - 60, kWidth, 60)];
    bgView.backgroundColor = RGB(236, 237, 239, 1);
    [self.view addSubview:bgView];
    
    UIView *commentView = [[UIView alloc] init];
    commentView.backgroundColor = [UIColor whiteColor];
    commentView.layer.cornerRadius = 5;
    commentView.layer.masksToBounds = YES;
    commentView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCommentViewAction:)];
    [commentView addGestureRecognizer:tap];
    
    //左边图片
    UIImageView *leftImage = [[UIImageView alloc] init];
    leftImage.image = [UIImage imageNamed:@"pinglun_icon"];
    
    //中间输入框
    UILabel *comLabel = [[UILabel alloc] init];
    comLabel.text = @"我也要评论";
    comLabel.font = [UIFont systemFontOfSize:12];
    comLabel.textColor = [UIColor lightGrayColor];
    
    [commentView sd_addSubviews:@[leftImage,comLabel]];
    
    //设置约束
    leftImage.sd_layout.leftSpaceToView(commentView,10).centerYEqualToView(commentView).heightIs(18).widthIs(18);
    
    comLabel.sd_layout.leftSpaceToView(leftImage,10).centerYEqualToView(commentView).heightIs(20);
    [comLabel setSingleLineAutoResizeWithMaxWidth:160];
    
    //右边发送按钮
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendButton.backgroundColor = RGB(230, 231, 233, 1);
    [sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
    [bgView sd_addSubviews:@[commentView,sendButton]];
    
    //设置约束
    sendButton.sd_layout.rightSpaceToView(bgView,10).topSpaceToView(bgView,12).heightIs(40).widthIs(60);
    sendButton.layer.cornerRadius = 5;
    sendButton.layer.masksToBounds = YES;
    
    commentView.sd_layout.leftSpaceToView(bgView,10).rightSpaceToView(sendButton,10).topSpaceToView(bgView,12).heightIs(40);

}

#pragma mark -键盘将要出现时的事件方法
- (void)showKewboard:(NSNotification *)notification {
    //取得键盘尺寸
    NSDictionary *userInfo = notification.userInfo;
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    float height = keyboardRect.size.height;
    
    //输入框的宽
    float W = kWidth + 10;
    //输入框的y坐标
    float Y = kHeight - height - 36;
    //设置fieldBgView的frame
    fieldBgView.frame = CGRectMake(-5, Y, W, 36);
    fieldBgView.hidden = NO;
}

#pragma mark - 创建评论输入框
- (void)_createCommentBar {
    commentBar = [[FCCommentBar alloc] init];
    CGFloat Y = kHeight + 20 - (self.navigationController.navigationBar .isTranslucent ? 0 : 64);
    commentBar.frame = CGRectMake(0, Y, kWidth, kMinHeight);
    
    [commentBar setSuperViewHeight:kHeight - (self.navigationController.navigationBar.isTranslucent ? 0 : 64)];
    
    commentBar.delegate = self;
    [self.view addSubview:commentBar];
}

#pragma mark - commentBar 代理方法
- (void)chatBar:(FCCommentBar *)chatBar sendComment:(NSString *)comment {
    
    ResCommentModel *model = [[ResCommentModel alloc] init];
    model.RealName = kUserModel.classModel.realname;
    model.CommentTime = [self getCurrentTime];
    model.CommentContent = comment;
    [self.dataArray addObject:model];
    
    [_tableView reloadData];
    
    currentCommCount ++;
    
    countLabel.text = [NSString stringWithFormat:@"评论数(%ld)",currentCommCount];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataArray.count - 1 inSection:0];
    [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    //上传给服务器
    NSString *urlStr = [NSString stringWithFormat:@"m30/M3004I/M3004I004/content/%@/parentId/0/replyType/2/resId/%@/userId/%@",comment,self.publicModel.Id,kUserModel.uid];
    [kNetworkSingleton requestURL:urlStr httpMethod:kGET params:nil successBlock:^(id data) {
        NSLog(@"评论成功啦%@",data);
        //如果返回的不是一个字典数据类型，则返回
        if (![data isKindOfClass:[NSDictionary class]]) {
            return ;
        }
        //数据为0
        NSDictionary *dataDic = (NSDictionary *)data;
        if (dataDic.count == 0) {
            return;
        }
        //返回出错
        NSNumber *errorFlag = dataDic[@"errorFlag"];
        BOOL isSuccess= [errorFlag boolValue];
        if (isSuccess) {
            NSString *errorMsg = dataDic[@"errorFlag"];
            [self showErrorMesg:errorMsg];
            return;
        }

    } failedBlock:^(NSError *error) {
        NSLog(@"评论失败%@",error);
    }];
}

- (void)showErrorMesg:(NSString *)message {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil];
    [alertVC addAction:action];
    [self presentViewController:alertVC animated:YES completion:nil];
}


#pragma mark - 评论视图点击事件
- (void)clickCommentViewAction:(UITapGestureRecognizer *)tap {
    //弹出键盘
    [commentBar startInputing];
}

#pragma mark - 获取当前日期
- (NSString *)getCurrentTime {
    
    NSDate *currentDate = [NSDate date];
    //获取当前时间，日期
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; [dateFormatter setDateFormat:@"YYYY:MM:dd hh:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    NSLog(@"dateString:%@",dateString);
    
    return dateString;
}



@end
