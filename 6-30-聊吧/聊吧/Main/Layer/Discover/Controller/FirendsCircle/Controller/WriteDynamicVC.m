//
//  WriteDynamicVC.m
//  聊吧
//
//  Created by m on 16/6/19.
//  Copyright © 2016年 m. All rights reserved.
//

#import "WriteDynamicVC.h"

@interface WriteDynamicVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextViewDelegate>

@end

@implementation WriteDynamicVC {
    UITextView *textVeiw;
    UICollectionView *_collectionView;
    NSString *identifier;
    UIView *shadowView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发说说";
//    self.view.backgroundColor = [UIColor redColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //设置导航栏
    [self setNavigationBar];
    
    //创建输入框
    [self createTextVeiw];
    
    //创建UICollectionView
    [self createCollectionView];
    
    //创建阴影视图
    [self createShadowView];
    
}

#pragma mark - 设置导航栏
- (void)setNavigationBar {
    
    //左边导航项
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 25, 25);
    [leftButton setBackgroundImage:[UIImage imageNamed:@"black"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //右边导航项
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 40, 20);
    [rightButton setTitle:@"发表" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

#pragma mark - 导航项点击事件
- (void)leftButtonAction:(UIButton *)button {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)rightButtonAction:(UIButton *)button {
    //进入我的动态界面
    NSLog(@"进入我的动态界面");
    
}

#pragma mark - 创建输入框
- (void)createTextVeiw {
    
    textVeiw = [[UITextView alloc] init];
//                WithFrame:CGRectMake(0, 64, kWidth, 160)];
    textVeiw.delegate = self;
    textVeiw.font = [UIFont systemFontOfSize:14];
    textVeiw.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textVeiw];
    
    //设置是否可以编辑
    textVeiw.editable = YES;
    
    //设置内容
    textVeiw.text = @"说点什么吧...";
    
    //字体颜色
    textVeiw.textColor = [UIColor lightGrayColor];
    
    //设置是否可以滚动
    //UITextView继承于UIScrollView
    textVeiw.scrollEnabled = NO;
    
    [self.view addSubview:textVeiw];
    
    textVeiw.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.view,64).heightIs(160);
    
    //动态改变高度
//    CGSize constraintSize;
//    constraintSize.width = kWidth;
//    constraintSize.height = MAXFLOAT;
//    CGSize sizeFrame =[textVeiw.text sizeWithFont:textVeiw.font constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
//    textVeiw.frame = CGRectMake(0,0,sizeFrame.width,sizeFrame.height);
    
}

//.在开始编辑的代理方法中进行如下操作
- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"说点什么吧..."]) {
        textView.text = @"";
        textVeiw.textColor = [UIColor blackColor];
    }
}
//.在结束编辑的代理方法中进行如下操作
//- (void)textViewDidEndEditing:(UITextView *)textView {
//    if (textView.text.length<1) {
//        textView.text = @"说点什么吧...";
//    }
//}


#pragma mark - 创建UICollectionView
- (void)createCollectionView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumInteritemSpacing = 3;
    flowLayout.minimumLineSpacing = 3;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    CGFloat width = (kWidth - 10 * 2 - 3 * 3) / 4.0;
    flowLayout.itemSize = CGSizeMake(width, width);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 224, kWidth, kHeight - 224) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    identifier = @"writeDynamicCell";
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    
    [self.view addSubview:_collectionView];
    
}



#pragma mark - collectionView 代理方法
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"AlbumAddBtn"];
    
    [cell.contentView addSubview:imageView];
    imageView.frame = cell.contentView.frame;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //弹出阴影视图及对话框
    shadowView.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        
        shadowView.alpha = 0.7;
        shadowView.hidden = NO;
    }];
}

#pragma mark - 创建阴影视图
- (void)createShadowView {
    //阴影视图
    shadowView = [[UIView alloc] initWithFrame:self.view.bounds];
    shadowView.backgroundColor = RGB(48, 53, 60, 0.7);
    shadowView.hidden = YES;
    //添加点击手势
    shadowView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickShadowViewAction:)];
    [shadowView addGestureRecognizer:tap];
    [self.view addSubview:shadowView];
    
    //选照片按钮和取消按钮
    UIButton *selectPhotoBut = [self setButtonWithTitle:@"从手机中选则" tag:1 action:@selector(selectPhoto)];
    
    UIButton *cancelBut = [self setButtonWithTitle:@"取消" tag:2 action:@selector(cancelAction)];
    
    [shadowView sd_addSubviews:@[selectPhotoBut,cancelBut]];
    
    //设置约束
    cancelBut.sd_layout.leftSpaceToView(shadowView,10).rightSpaceToView(shadowView,10).bottomSpaceToView(shadowView,10).heightIs(50);
    
    selectPhotoBut.sd_layout.leftSpaceToView(shadowView,10).rightSpaceToView(shadowView,10).bottomSpaceToView(shadowView,80).heightIs(50);
    
}

- (UIButton *)setButtonWithTitle:(NSString *)title tag:(NSInteger) tag action:(SEL) sel {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = tag;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor whiteColor];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    
    return button;
}

#pragma mark - 从手机中选择照片
- (void)selectPhoto {
    NSLog(@"从手机中选择照片");
    [UIView animateWithDuration:0.3 animations:^{
        shadowView.alpha = 0;
        [self performSelector:@selector(hiddenShadowAction) withObject:nil afterDelay:0.3];
    }];
}

- (void)hiddenShadowAction {
    shadowView.hidden = YES;
}

- (void)cancelAction {
    NSLog(@"取消");
    [UIView animateWithDuration:0.3 animations:^{
        shadowView.alpha = 0;
        [self performSelector:@selector(hiddenShadowAction) withObject:nil afterDelay:0.3];
    }];
}

#pragma mark - 阴影视图点击事件
- (void)clickShadowViewAction:(UITapGestureRecognizer *)tap {
    [UIView animateWithDuration:0.3 animations:^{
        shadowView.alpha = 0;
        [self performSelector:@selector(hiddenShadowAction) withObject:nil afterDelay:0.3];
    }];
}

@end
