//
//  MineResourceVC.m
//  聊吧
//
//  Created by m on 16/6/27.
//  Copyright © 2016年 m. All rights reserved.
//

#import "MineResourceVC.h"
#import "FCTopBarView.h"
#import "TeachResourceCell.h"
#import "ResourceDetailVC.h"
#import "PublicResModel.h"



@interface MineResourceVC () <UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource> {
    BOOL TeachResCellIsClicked;
}

@property (nonatomic,strong) FCTopBarView *topBarView;
@property (nonatomic, strong) NSMutableArray *tableViewArr;
@property (nonatomic, strong) UIScrollView    *listContentView;
@property (nonatomic, strong) NSArray *gradeTitle;

- (void)updateTopBarView;

@end

@implementation MineResourceVC {
    NSMutableArray *buttonArr;
    BOOL _isDragging;
    NSMutableArray *dataArray;
    NSInteger currentIndex;
    NSInteger nowPage;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    TeachResCellIsClicked = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //加载数据
    currentIndex = 0;
    [self loadData:currentIndex];
    
    //创建滑动视图
    [self createScrollView];
    
    //创建分割线
    [self createSepView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (TeachResCellIsClicked) {
        
        [self.listContentView setContentOffset:CGPointMake(0, 64)];
    }
}

#pragma mark - 加载数据
- (void)loadData:(NSInteger)index {
    nowPage = 1;
    NSString *type;
    if (index == 0) {
        //教案
        type = @"5";
    }
    else if (index == 1) {
        //课件
        type = @"3";
    }
    else if (index == 2) {
        //音频
        type = @"4";
    }
    else if (index == 3) {
        //视频
        type = @"1";
    }
    else {
        //教案
        type = @"5";
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"m30/M3001I/M3001I004/userId/%@/nowPage/%ld/searchType/%@",kUserModel.uid,nowPage,type];
    [kNetworkSingleton requestURL:urlStr httpMethod:kGET params:nil successBlock:^(id data) {
        
//        NSLog(@"成功%@",data);
        UITableView *cutableViw = self.tableViewArr[index];
        //如果返回的不是一个字典则返回错误
        if (![data isKindOfClass:[NSDictionary class]]) {
            return;
        }
        //数据为0
        NSDictionary *dataDic = (NSDictionary *)data;
        if (dataDic.count == 0) {
            return;
        }
        //返回错误
        NSNumber *errorFlag = dataDic[@"errorFlag"];
        BOOL isSuccess = [errorFlag boolValue];
        
        if (isSuccess) {
            return;
        }
        
        //成功
        dataArray = [NSMutableArray array];
        NSDictionary *res = dataDic[@"res"];
        if (res.count == 0) {
            return;
        }
        NSArray *tempArray = res[@"data"];
        for (NSDictionary *dic in tempArray) {
            PublicResModel *publicResModel = [PublicResModel objectWithKeyValues:dic];
            [dataArray addObject:publicResModel];
        }
        
        [cutableViw reloadData];
        
    } failedBlock:^(NSError *error) {
        NSLog(@"请求失败%@",error);
        
        
    }];
    
}


#pragma mark - 分割线
- (void)createSepView {
    //分割线
    UIView *sepView = [[UIView alloc] initWithFrame:CGRectMake(0, 113, kWidth, 1)];
    sepView.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:sepView];
}

#pragma mark - 滑动视图
- (void)createScrollView {

    _tableViewArr = [[NSMutableArray alloc] init];
    self.gradeTitle = @[@"教案",@"课件",@"音频",@"视频"];
    
    [self.view addSubview:self.listContentView];
    
    self.listContentView.contentSize = CGSizeMake(self.listContentView.bounds.size.width * self.gradeTitle.count, self.listContentView.bounds.size.height);
    //循环创建表视图并添加到滑动视图上
    for (int i = 0; i < self.gradeTitle.count; i++) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(i * self.listContentView.bounds.size.width, 0, self.listContentView.bounds.size.width, self.listContentView.bounds.size.height) style:UITableViewStyleGrouped];
        tableView.tag = i+100;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.showsVerticalScrollIndicator = NO;
        [self.listContentView addSubview:tableView];
        [_tableViewArr addObject:tableView];
    }
    
    [self.view addSubview:self.topBarView];
    [self updateTopBarView];
    
}

#pragma mark - 顶部滑动视图
- (FCTopBarView *)topBarView {
    //年级滑动视图
    if (!_topBarView) {
        _topBarView = [[FCTopBarView alloc] initWithFrame:CGRectMake(0, 64, kWidth, 49)];
        _topBarView.backgroundColor = [UIColor whiteColor];
        _topBarView.titleArr = self.gradeTitle;
        __weak typeof(self) weakSelf = self;
        _topBarView.didSelectedAt = ^(NSInteger index){
            [weakSelf didChangeToIndex:index byClick:YES];
        };
    }
    
    return _topBarView;
}

- (void)didChangeToIndex:(NSInteger)index byClick:(BOOL)bClick {
    if (index >= _tableViewArr.count)
        return;
    [self.listContentView setContentOffset:CGPointMake(index * self.listContentView.bounds.size.width, 0) animated:YES];
    
    //切换页面就重新加载数据
    currentIndex = index;
    [self loadData:currentIndex];
    
    //刷新当前页面
    UITableView *cutableView = self.tableViewArr[index];
    [cutableView reloadData];
    
}

#pragma mark - 加载表视图的滑动视图
- (UIScrollView*)listContentView {
    if (!_listContentView) {
        _listContentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50 + 64, kWidth, kHeight - 50 - 64)];
        _listContentView.showsHorizontalScrollIndicator = NO;
        _listContentView.showsVerticalScrollIndicator = NO;
        _listContentView.alwaysBounceHorizontal = YES;
        _listContentView.pagingEnabled = YES;
        _listContentView.bounces = YES;
        _listContentView.delegate = self;
        _listContentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _listContentView.directionalLockEnabled = YES;
    }
    
    return _listContentView;
}


- (void)updateTopBarView {
    if (self.gradeTitle.count > 0) {
        NSInteger oldCount = self.topBarView.titleArr.count;
        self.topBarView.titleArr = self.gradeTitle;
        if (oldCount != self.gradeTitle.count) {
            self.topBarView.curIndex = 0;
        }
    }
    
}

#pragma mark - 年级按钮点击事件
- (void)gradeButtonAction:(UIButton *)button {
    NSLog(@"点击了年级按钮");
}

#pragma mark - UIScrollView delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView == _listContentView) {
        _isDragging = YES;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView == _listContentView && !decelerate) {
        _isDragging = NO;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_isDragging && scrollView == _listContentView) {
        self.topBarView.thumbPos = scrollView.contentOffset.x / scrollView.bounds.size.width;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == _listContentView){
        _isDragging = NO;
        NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width ;
        [self didChangeToIndex:index byClick:NO];
    }
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier= @"cell";
    
    TeachResourceCell *cell= [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[TeachResourceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.publicResModel = dataArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

#pragma mark - 单元格点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TeachResCellIsClicked = YES;
    ResourceDetailVC *resourceDetailVC = [[ResourceDetailVC alloc] init];
    resourceDetailVC.publicModel = dataArray[indexPath.row];
    [self.navigationController pushViewController:resourceDetailVC animated:YES];
    
}


@end
