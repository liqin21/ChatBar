//
//  MyClassViewController.m
//  聊吧
//
//  Created by m on 16/6/14.
//  Copyright © 2016年 m. All rights reserved.
//

#import "MyClassViewController.h"
#import "DetailedView.h"
#import "MyClassModel.h"
#import "ClassmateListModel.h"
#import "MyClassModel.h"
#import "MyClassCell.h"
#import "ClassmateDetailVC.h"
#import "MineViewController.h"
#import "TeacherListModel.h"
#import "MyClassCollectionView.h"
#import "SegmentHandleVC.h"




@interface MyClassViewController () <CollectionViewCellDidSelectedDelegate>

@end

@implementation MyClassViewController {
    DetailedView *detailedView;
    UIView *translucentView;
    MyClassCollectionView *teacherVeiw;
    MyClassCollectionView *classView;
    NSString *identifier;
    NSArray *nameArray;
    NSArray *iconArray;
    MyClassModel *myClassModel;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor darkGrayColor];
    //设置初始的classID
//    UserModel *userModel = [[UserConfig shareInstance]getAllInformation];
    self.title = kUserModel.classModel.classname;
    
    //1.加载数据
    [self loadData:kUserModel.classModel.classid];
    
    //2.设置导航栏
    [self setNavigationBar];
    
    //3.创建老师列表
    [self createTeacherListView];
    
    //4.创建学生列表
    [self createStudentsListView];
    
    //4.点击右边导航项出现的视图
    [self createDetailedView];
}


#pragma mark - 加载数据
- (void)loadData:(NSString *)classID {
    //设置当前班级的ID
    NSString *urlString = @"/m17/Seat/Index";
    
//    UserModel *userModel = [[UserConfig shareInstance]getAllInformation];
    
    if (kUserModel.uid == nil || kUserModel.classModel.classid == nil || kUserModel.key == nil) {
        return;
    }
    
    NSDictionary *dic = @{
                          @"uid":kUserModel.uid,
                          @"classid":classID,
                          @"key":kUserModel.key
                          };

    [NetworkSingleton requestURL:urlString httpMethod:kPOST params:dic successBlock:^(id data) {
        
        //设置当前标题
        
        NSLog(@"成功：%@",data);
        self.title = kUserModel.classModel.classname;
        
        //成功
        NSDictionary *dicData = (NSDictionary *)data;
        if (dicData.count != 0) {
            myClassModel = [MyClassModel objectWithKeyValues:dicData];
        }
        
        NSArray *tempArray = myClassModel.studentinfo;
        NSMutableArray *classArray = [NSMutableArray array];
        for (NSDictionary *dic  in tempArray) {
            ClassmateListModel *classmateListModel = [ClassmateListModel objectWithKeyValues:dic];
            [classArray addObject:classmateListModel];
        }
        
        NSArray *teacherTempArr = myClassModel.teacherlist;
        NSMutableArray *teacherArr = [NSMutableArray array];
        for (NSDictionary *dic in teacherTempArr) {
            TeacherListModel *teacherListModel = [TeacherListModel objectWithKeyValues:dic];
            [teacherArr addObject:teacherListModel];
        }
        
        //设置数据
        classView.dataSouce = classArray;
        teacherVeiw.dataSouce = teacherArr;
        //刷新表格
        [classView reloadData];
        
        [teacherVeiw reloadData];
        
    } failedBlock:^(NSError *error) {
        //失败
        NSLog(@"%@",error);
        [AlertHelper dissmissRequestView];
    }];
}

#pragma mark - 设置导航栏
- (void)setNavigationBar {
    
    //左边导航项
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"black"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(leftItemAction:)];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //右边导航项
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"myinfo_topright_icon"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction:)];
  
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

#pragma mark - 导航项点击事件
- (void)leftItemAction:(UIBarButtonItem *)item {
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)rightItemAction:(UIBarButtonItem *)item {
    //进入课表界面
    SegmentHandleVC *segmentHandleVC = [[SegmentHandleVC alloc] init];
    [self.navigationController pushViewController:segmentHandleVC animated:YES];
}

#pragma mark -向左拖拽出现的视图
- (void)createDetailedView {
    //添加阴影视图
    translucentView = [[UIView alloc] initWithFrame:self.view.bounds];
    translucentView.userInteractionEnabled = YES;
    //添加点击手势
    UITapGestureRecognizer *touchTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTranslucentViewAction:)];
    //添加滑动手势
    UISwipeGestureRecognizer *leftSwipeTap = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    //设置滑动方向
    leftSwipeTap.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [translucentView addGestureRecognizer:touchTap];
    [translucentView addGestureRecognizer:leftSwipeTap];
    
    translucentView.hidden = YES;
    translucentView.backgroundColor = RGB(48, 53, 60, 0.7);
    [[UIApplication sharedApplication].keyWindow addSubview:translucentView];
    
    detailedView = [[DetailedView alloc] initWithFrame:CGRectMake(-220 , 20, 220, kHeight - 20)];
    
    detailedView.backgroundColor = RGB(19, 23, 20, 0.9);
    
    [[UIApplication sharedApplication].keyWindow addSubview:detailedView];
    
    //为self.view 添加滑动手势
    UISwipeGestureRecognizer *rightSwipeTap = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    rightSwipeTap.direction = UISwipeGestureRecognizerDirectionRight;
    
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:rightSwipeTap];
    
}

#pragma mark - 阴影视图点击事件
- (void)clickTranslucentViewAction:(UITapGestureRecognizer *)tap {
    translucentView.hidden = YES;
    
    [UIView animateWithDuration:0.3 animations:^{
        detailedView.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark - 添加一个滑动手势
- (void)handleSwipes:(UISwipeGestureRecognizer *) tap {
    if (tap.direction == UISwipeGestureRecognizerDirectionRight) {
        [UIView animateWithDuration:0.3 animations:^{
            detailedView.transform = CGAffineTransformMakeTranslation(220, 0);
            translucentView.alpha = 0.5;
        }];
        translucentView.hidden = NO;
        
    }
    if (tap.direction == UISwipeGestureRecognizerDirectionLeft) {
        [UIView animateWithDuration:0.3 animations:^{
            
            detailedView.transform = CGAffineTransformIdentity;
        }];
        translucentView.hidden = YES;
    }
}


#pragma mark - 创建老师列表
- (void)createTeacherListView {
    
    //1.创建布局对象
    UICollectionViewFlowLayout *flowLayout1 = [[UICollectionViewFlowLayout alloc] init];
    
    //2.设置滑动方向
    flowLayout1.scrollDirection =  UICollectionViewScrollDirectionHorizontal;
    
    //3.创建视图
    self.automaticallyAdjustsScrollViewInsets = NO;
    teacherVeiw = [[MyClassCollectionView alloc] initWithFrame:CGRectMake(0, 64, kWidth, (kWidth - 10 * 2 - 3 * 10) / 4.0 + 40) collectionViewLayout:flowLayout1];
    
    teacherVeiw.backgroundColor = [UIColor whiteColor];
    teacherVeiw.contentSize = CGSizeMake(100 * 100, 100);
    teacherVeiw.selectedDelegate = self;
    
    [self.view addSubview:teacherVeiw];
    
    //创建分割线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, (kWidth - 10 * 2 - 3 * 10) / 4.0 + 40 + 64, kWidth, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView];

}

#pragma mark - 创建学生列表
- (void)createStudentsListView {
    
    //1.创建布局对象
    UICollectionViewFlowLayout *flowLayout2 = [[UICollectionViewFlowLayout alloc] init];
    
    //2.设置滑动方向
    flowLayout2.scrollDirection =  UICollectionViewScrollDirectionVertical;
    
    //3.创建视图
    self.automaticallyAdjustsScrollViewInsets = NO;
    classView = [[MyClassCollectionView alloc] initWithFrame:CGRectMake(0, (kWidth - 10 * 2 - 3 * 10) / 4.0 + 40 + 64 + 1, kWidth, kHeight - (kWidth - 10 - 3 * 10) / 4.0 - 40 - 65) collectionViewLayout:flowLayout2];
    classView.contentSize = CGSizeMake(kWidth, 100 * 25);
    classView.backgroundColor = RGB(245, 246, 247, 1);
    classView.selectedDelegate = self;
    
    [self.view addSubview:classView];
}

#pragma mark - 实现代理方法（点击协议）
- (void)collectionViewCellDidSelected:(id)model {
    ClassmateDetailVC *classmateDetailVC = [[ClassmateDetailVC alloc] init];
    if ([model isKindOfClass:[TeacherListModel class]]) {
        TeacherListModel *tModel = (TeacherListModel *)model;
        classmateDetailVC.ID = tModel.uid;
    }
    else if ([model isKindOfClass:[ClassmateListModel class]]) {
        ClassmateListModel *cModel = (ClassmateListModel *)model;
        classmateDetailVC.ID = cModel.studentID;
    }
    
    [self.navigationController pushViewController:classmateDetailVC animated:YES];
}


@end
