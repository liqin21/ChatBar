//
//  FriendsCirCleController.m
//  聊吧
//
//  Created by m on 16/5/25.
//  Copyright © 2016年 m. All rights reserved.
//

#import "FriendsCirCleController.h"
#import "FriendsCircleCell.h"
#import "FCHeadView.h"
#import "FriendsCircleModel.h"
#import "FCCommentBar.h"
#import "FCCommentBar.h"
#import "FCOprationMenuView.h"
#import "WriteDynamicVC.h"



@interface FriendsCirCleController ()<FriendsCircleCellDelegate,FCCommentBarDelegate> {
    UIView *fieldBgView;
    FCCommentBar *commentBar;
}

@end

@implementation FriendsCirCleController {
    UITableView *_tableView;
    UIImageView *refreshImg;

}

//状态栏样式
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //1.自定义导航栏
    [self _customNavigationBar];
    
    //2.加载数据
    [self.dataArray addObjectsFromArray:[self loadData:10]];
    
    //3.创建表视图
    [self _createTableView];
    
    //4.创建评论输入框
    [self _createCommentBar];

}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

#pragma mark - 1.自定义导航栏
- (void)_customNavigationBar {
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    
    //左边导航项
    //返回图案
    UIBarButtonItem *leftItem1 = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"ff_IconShowAlbum"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction:)];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"朋友圈";
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    [navigationBar addSubview:titleLabel];
    titleLabel.frame = CGRectMake(50, 10, 60, 20);
    UIBarButtonItem *leftItem2 = [[UIBarButtonItem alloc] initWithCustomView:titleLabel];
    
    self.navigationItem.leftBarButtonItems = @[leftItem1,leftItem2];
    
    //右边导航项
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"myquanzi_xiangji"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonAction:)];
    self.navigationItem.rightBarButtonItem = rightItem;
}


#pragma mark - 加载数据
- (NSArray *)loadData:(NSInteger)count {
    NSArray *iconImageNamesArray = @[@"icon0.jpg",
                                     @"icon1.jpg",
                                     @"icon2.jpg",
                                     @"icon3.jpg",
                                     @"icon4.jpg",
                                     ];
    
    NSArray *namesArray = @[@"GSD_iOS",
                            @"风口上的猪",
                            @"当今世界网名都不好起了",
                            @"我叫郭德纲",
                            @"Hello Kitty"];
    
    NSArray *textArray = @[@"当你的 app 没有提供 3x 的 LaunchImage 时，系统默认进入兼容模式，https://github.com/gsdios/SDAutoLayout大屏幕一切按照 320 宽度渲染，屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。",
                           @"然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，https://github.com/gsdios/SDAutoLayout等于把小屏完全拉伸。",
                           @"当你的 app 没有提供 3x 的 LaunchImage 时屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。屏幕宽度返回 320；https://github.com/gsdios/SDAutoLayout然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。",
                           @"但是建议不要长期处于这种模式下，否则在大屏上会显得字大，内容少，容易遭到用户投诉。",
                           @"屏幕宽度返回 320；https://github.com/gsdios/SDAutoLayout然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。"
                           ];
    
    NSArray *picImageNamesArray = @[ @"pic0.jpg",
                                     @"pic1.jpg",
                                     @"pic2.jpg",
                                     @"pic3.jpg",
                                     @"pic4.jpg",
                                     @"pic5.jpg",
                                     @"pic6.jpg",
                                     @"pic7.jpg",
                                     @"pic8.jpg"                                     ];
    //评论的数据数组
    NSArray *commentsArray = @[@"社会主义好！👌👌👌👌",
                               @"正宗好凉茶，正宗好声音。。。",
                               @"你好，我好，大家好才是真的好",
                               @"有意思",
                               @"你瞅啥？",
                               @"瞅你咋地？？？！！！",
                               @"hello，看我",
                               @"曾经在幽幽暗暗反反复复中追问，才知道平平淡淡从从容容才是真",
                               @"人艰不拆",
                               @"咯咯哒",
                               @"呵呵~~~~~~~~",
                               @"我勒个去，啥世道啊",
                               @"真有意思啊你💢💢💢"];
    
    NSMutableArray *resArr = [NSMutableArray new];
    for (int i = 0; i < count; i++) {
        int iconRandomIndex = arc4random_uniform(5);
        int nameRandomIndex = arc4random_uniform(5);
        int contentRandomIndex = arc4random_uniform(5);
        FriendsCircleModel *model = [FriendsCircleModel new];
        model.iconName = iconImageNamesArray[iconRandomIndex];
        model.name = namesArray[nameRandomIndex];
        model.content = textArray[contentRandomIndex];
        
        //模拟随机图片
        int random = arc4random_uniform(9);
        NSMutableArray *temp = [NSMutableArray array];
        for (int i = 0; i < random; i++) {
            int randomIndex = arc4random_uniform(9);
            [temp addObject:picImageNamesArray[randomIndex]];
        }
        if (temp.count) {
            model.pictureArray = [temp copy];
        }
        
        //模拟随机评论数据
        int commentRandom = arc4random_uniform(5);
        NSMutableArray *commentsTemp = [NSMutableArray array];
        for (int i = 0; i < commentRandom; i ++) {
            FCCellCommentItemModel *commentModel = [[FCCellCommentItemModel alloc] init];
            int commentIndex = arc4random_uniform((int)namesArray.count);
            commentModel.firstUserName = namesArray[commentIndex];
            commentModel.firstUsrID = @"555";
            
            //
            if (arc4random_uniform(10) < 5) {
                commentModel.secondUserName = namesArray[arc4random_uniform((int)namesArray.count)];
                commentModel.secondUsrID = @"9999";
            }
            commentModel.commentString = commentsArray[arc4random_uniform((int)commentsArray.count)];
            [commentsTemp addObject:commentModel];
        }
        model.commentItemsArray = [commentsTemp copy];
        
        //模拟随机点赞数据
        int likeRandom = arc4random_uniform(5);
        NSMutableArray *likesTemp = [NSMutableArray array];
        for (int i = 0; i < likeRandom; i ++) {
            FCCellLikeItemModel *likeModel = [[FCCellLikeItemModel alloc] init];
            int randomIndex = arc4random_uniform((int)namesArray.count);
            likeModel.userName = namesArray[randomIndex];
            likeModel.userID = namesArray[randomIndex];
            [likesTemp addObject:likeModel];
        }
        model.likeItemsArray = [likesTemp copy];
        
        [resArr addObject:model];
    }
    return [resArr copy];
    
}

 
#pragma mark - 3.创建表视图
- (void)_createTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    //创建表视图的头视图
    FCHeadView *tableHeadView = [[FCHeadView alloc] initWithFrame:CGRectMake(0, 0, 0, 300)];
    UIImageView *bgImageView = tableHeadView.bgImageView;
    _tableView.tableHeaderView = tableHeadView;
    _tableView.contentInset =  UIEdgeInsetsMake(-64, 0, 0, 0);
    [self.view addSubview:_tableView];
    
    //给头视图的bgImageView添加一个点击手势
    bgImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgImageViewTapAction:)];
    [bgImageView addGestureRecognizer:tap1];
    
    //加载视图
    refreshImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, 80, 25, 25)];
    refreshImg.image = [UIImage imageNamed:@"ff_IconShowAlbum"];
    refreshImg.transform = CGAffineTransformRotate(refreshImg.transform, 3.14/2);
    [self.view addSubview:refreshImg];
    
    [self createtranslucentView];
}

//点击封面相册时出现的视图
- (void)createtranslucentView {
    //更换背景图片提示框
    //覆盖全屏的半透明视图
    _translucentView = [[UIImageView alloc] init];
    _translucentView.backgroundColor = [UIColor colorWithRed:43 / 255.0 green:44 / 255.0 blue:48 / 255.0 alpha:0.6];
    _translucentView.frame = self.view.bounds;
    _translucentView.hidden = YES;
    //为视图添加点击事件
    _translucentView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(translucentViewTapAction:)];
    [_translucentView addGestureRecognizer:tap3];
    [self.view addSubview:_translucentView];
    
    _cueButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cueButton.backgroundColor = [UIColor whiteColor];
    [_cueButton setTitle:@"更换相册封面" forState:UIControlStateNormal];
    _cueButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_cueButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_cueButton addTarget:self action:@selector(cueButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_translucentView addSubview:_cueButton];
    _cueButton.sd_layout.leftSpaceToView(_translucentView,40).rightSpaceToView(_translucentView,40).heightIs(40).topSpaceToView(_translucentView,235);
    _cueButton.layer.cornerRadius = 5;
    _cueButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _cueButton.contentEdgeInsets = UIEdgeInsetsMake(0, 18, 0, 0);


}

#pragma mark - UITableView 代理方法
//指定每组中单元格的数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

//创建单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FriendsCircleCell *cell = [tableView dequeueReusableCellWithIdentifier:kFriendsCircleCellID];
    if (cell == nil) {
        cell = [[FriendsCircleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kFriendsCircleCellID];
    }
    cell.delegate = self;
    //实现cell的frame的缓存，可以使得表视图滑动流畅
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    //设置内容
    cell.friendsCircleModel = _dataArray[indexPath.row];
    
    return cell;
}


//设置单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id model = _dataArray[indexPath.row];
    return [_tableView cellHeightForIndexPath:indexPath model:model keyPath:@"friendsCircleModel" cellClass:[FriendsCircleCell class] contentViewWidth:[self cellContentViewWidth]];
    
}

- (CGFloat)cellContentViewWidth {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    //适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.width;
    }
    return width;
}

#pragma mark - 单元格点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [commentBar endInputing];
    
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kCommentButtonClickNotification object:self];
    

}

//滑动事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [UIView animateWithDuration:0.1 animations:^{
    refreshImg.transform = CGAffineTransformRotate(refreshImg.transform, 3.14/2);
    }];
    
    [commentBar endInputing];
    
}


#pragma mark - 导航栏上返回按钮点击事件
- (void)backButtonAction:(UIButton *)button {
    //导航到朋友圈界面
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)rightButtonAction:(UIButton *)button {
    //导航到写说说界面
    NSLog(@"发动态");
    WriteDynamicVC *writeDynamicVC = [[WriteDynamicVC alloc] init];
    [self.navigationController pushViewController:writeDynamicVC animated:YES];

}

#pragma mark - 背景视图点击事件方法
//封面相册点击事件
- (void)bgImageViewTapAction:(UIGestureRecognizer *)tap {
    //弹出对话框
    _translucentView.hidden = NO;
    
}

//更换封面图片按钮点击事件
- (void)cueButtonAction:(UIButton *)button {
    //更换背景图片
    NSLog(@"更换封面相册");
}

//覆盖全屏的半透明视图点击事件
- (void)translucentViewTapAction:(UIGestureRecognizer *)tap {
    _translucentView.hidden = YES;
    
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
    commentBar.frame = CGRectMake(0, Y, kWidth, 40);
    
    [commentBar setSuperViewHeight:kHeight - (self.navigationController.navigationBar.isTranslucent ? 0 : 64)];
    commentBar.delegate = self;
    [self.view addSubview:commentBar];
}

#pragma mark - FriendsCircleCellDelegate 代理方法
//点赞按钮
- (void)didClickLikeButtonInCell:(UITableViewCell *)cell {
    NSLog(@"我为你点赞");
//   static NSInteger index = 0;
        //取得当前点击的单元格的indePath
        _currentEditingIndexthPath = [_tableView indexPathForCell:cell];
        //拿到点击的单元格的Model
        FriendsCircleModel *model = self.dataArray[_currentEditingIndexthPath.row];

        
        NSMutableArray *likesTemp = [NSMutableArray array];
        FCCellLikeItemModel *likeModel = [[FCCellLikeItemModel alloc] init];
        //在原来的点赞数据侯敏添加数据
        [likesTemp addObjectsFromArray:model.likeItemsArray];
        likeModel.userName = @"有晴有雨";
        likeModel.userID = @"333";
    
    if (!model.isLiked) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kLikeButtonClickNotification object:self];
        [likesTemp addObject:likeModel];
        model.likeItemsArray = [likesTemp copy];
       model.liked = YES;
    }
    else {
        for (FCCellLikeItemModel *likeModel in model.likeItemsArray) {
            if ([likeModel.userID isEqualToString:@"333"]) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:kCancelLikeNotification object:self];
                
                [likesTemp removeLastObject];
                model.likeItemsArray = [likesTemp copy];
               model.liked = NO;
            }
        }
    }
    //延迟刷新当前单元格
    [self performSelector:@selector(reloadCell) withObject:nil afterDelay:0.7];
}

//刷新单元格
- (void)reloadCell {
    
    [_tableView reloadRowsAtIndexPaths:@[_currentEditingIndexthPath] withRowAnimation:UITableViewRowAnimationNone];
}

//评论按钮
- (void)didClickCommentButtonInCell:(UITableViewCell *)cell {
    //如果键盘已经弹出，再点击时就隐藏
    if (commentBar.frame.origin.y < kHeight) {
        [commentBar endInputing];
    }
    else {
    //弹出键盘
    [commentBar startInputing];
    }
    //取得当前点击的单元格的indePath
    _currentEditingIndexthPath = [_tableView indexPathForCell:cell];
}

#pragma mark - FCCommentBarDelegate 代理方法
- (void)chatBar:(FCCommentBar *)chatBar sendComment:(NSString *)comment {
    //拿到点击的单元格的Model
    FriendsCircleModel *model = self.dataArray[_currentEditingIndexthPath.row];
    NSMutableArray *temp = [NSMutableArray array];
    
    //在原来的评论数据后面添加评论数据
    [temp addObjectsFromArray:model.commentItemsArray];
    FCCellCommentItemModel *commentModel = [[FCCellCommentItemModel alloc] init];
    commentModel.firstUserName = @"有晴有雨";
    commentModel.firstUsrID = @"333";
    
    commentModel.secondUserName = @"风口上的猪";
    commentModel.secondUsrID = @"888";
    
    commentModel.commentString = comment;
    [temp addObject:commentModel];
    
    model.commentItemsArray = [temp copy];
    
    //刷新当前单元格
    [_tableView reloadRowsAtIndexPaths:@[_currentEditingIndexthPath] withRowAnimation:UITableViewRowAnimationNone
     ];
    
}



@end

