//
//  PublicResourceVC.m
//  聊吧
//
//  Created by m on 16/6/27.
//  Copyright © 2016年 m. All rights reserved.
//

#import "PublicResourceVC.h"
#import "FCTopBarView.h"
#import "TeachResourceCell.h"
#import "ResourceDetailVC.h"
#import "PublicResModel.h"




@interface PublicResourceVC () <UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) FCTopBarView *topBarView;
@property (nonatomic, strong) NSMutableArray *tableViewArr;
@property (nonatomic, strong) UIScrollView    *listContentView;
@property (nonatomic, strong) NSMutableArray *gradeTitle;

- (void)updateTopBarView;

@end

@implementation PublicResourceVC {
    UIView *topView;
    UIView *searchBar;
    NSMutableArray *buttonArr;
    UIView *columView;
    NSInteger currentIndex;
    BOOL _isDragging;
    NSMutableArray *dataArray;
    NSString *searchType;
    UITextField *textField;
    NSString *searchGrade;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
     //加载数据
    currentIndex = 0;
    [self loadData:currentIndex];
    
    //创建顶部视图
    [self createTopView];
        
}


#pragma mark - 加载数据
- (void)loadData:(NSInteger)index {
    NSString *urlStr;
    //全部资源的地址
    if (index == 0) {
        urlStr = [NSString stringWithFormat:@"m30/M3001I/M3001I003/userid/%@/nowPage/1",kUserModel.uid];
        searchGrade = @"全部";
    }
    //一年级资源的地址
    else if (index == 1) {
        urlStr = [NSString stringWithFormat:@"m30/M3001I/M3001I003/userid/%@/nowPage/1/searchGrade/%@/searchPhase/%@",kUserModel.uid,@"一年级",@"1"];
        searchGrade = @"一年级";
    }
    
   //二年级资源的地址
    else if (index == 2) {
        urlStr = [NSString stringWithFormat:@"m30/M3001I/M3001I003/userid/%@/nowPage/1/searchGrade/%@/searchPhase/%@",kUserModel.uid,@"二年级",@"1"];
        searchGrade = @"二年级";
    }
    //三年级资源的地址
    else if (index == 3) {
        urlStr = [NSString stringWithFormat:@"m30/M3001I/M3001I003/userid/%@/nowPage/1/searchGrade/%@/searchPhase/%@",kUserModel.uid,@"三年级",@"1"];
        searchGrade = @"三年级";
    }
    //四年级资源的地址
    else if (index == 4) {
        urlStr = [NSString stringWithFormat:@"m30/M3001I/M3001I003/userid/%@/nowPage/1/searchGrade/%@/searchPhase/%@",kUserModel.uid,@"四年级",@"1"];
       searchGrade = @"四年级";
    }
    //五年级资源的地址
    else if (index == 5) {
        urlStr = [NSString stringWithFormat:@"m30/M3001I/M3001I003/userid/%@/nowPage/1/searchGrade/%@/searchPhase/%@",kUserModel.uid,@"五年级",@"1"];
        searchGrade = @"五年级";
    }
    //六年级资源的地址
    else if (index == 6) {
        urlStr = [NSString stringWithFormat:@"m30/M3001I/M3001I003/userid/%@/nowPage/1/searchGrade/%@/searchPhase/%@",kUserModel.uid,@"六年级",@"1"];
        searchGrade = @"六年级";
    }

    //请求网络
    [NetworkSingleton requestURL:urlStr httpMethod:kGET params:nil successBlock:^(id data) {
        
        UITableView *currentTableViw = self.tableViewArr[currentIndex];
        //如果返回的不是一个字典，则返回错误
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
        BOOL isSuccess = [errorFlag boolValue];
        if (isSuccess) {
            return;
        }
        //成功
//        NSLog(@"公共资源数据请求成功%@",data);
        dataArray = [NSMutableArray array];
        NSArray *tempArray = dataDic[@"data"];
        for (NSDictionary *dic in tempArray) {
            PublicResModel *model = [PublicResModel objectWithKeyValues:dic];
            [dataArray addObject:model];
        }
        
        //刷新数据
        [currentTableViw reloadData];
        
    } failedBlock:^(NSError *error) {
       //网络请求失败
        NSLog(@"失败%@",error);

    }];

}

#pragma mark - 创建顶部视图
- (void)createTopView {
    topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kWidth, 150)];
    [self.view addSubview:topView];
    
    //创建搜索输入框视图
    searchBar = [[UIView alloc] init];
    searchBar.backgroundColor = RGB(237, 237, 237, 1);
    searchBar.layer.cornerRadius = 5;
    searchBar.layer.masksToBounds = YES;
    [topView addSubview:searchBar];
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView).offset(10);
        make.right.equalTo(topView).offset(-10);
        make.top.equalTo(topView).offset(10);
        make.height.mas_equalTo(50);
    }];
    
    UIImageView *searchImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 17, 16, 16)];
    searchImg.image = [UIImage imageNamed:@"search"];
    [searchBar addSubview:searchImg];
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.backgroundColor = RGB(89, 183, 58, 1);
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(seachButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [searchBar addSubview:searchButton];
    
    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(searchBar);
        make.top.equalTo(searchBar);
        make.bottom.equalTo(searchBar);
        make.width.mas_equalTo(90);
    }];
    
    textField = [[UITextField alloc] init];
    textField.placeholder = @"按输入源标题进行查询";
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [searchBar addSubview:textField];
    
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchImg.mas_right).offset(3);
        make.right.equalTo(searchButton.mas_left).offset(-1);
        make.top.equalTo(searchBar).offset(5);
        make.bottom.equalTo(searchBar).offset(-5);
    }];
    
    //创建创建分栏按钮视图
    [self createColumButton];
    
    //创建年级滑动视图
    [self createGradeScrollView];
    
    //分割线
    UIView *sepView = [[UIView alloc] initWithFrame:CGRectMake(0, 149, kWidth, 1)];
    sepView.backgroundColor = [UIColor lightGrayColor];
    
    [topView addSubview:sepView];

}


#pragma mark - 搜索按钮点击事件
- (void)seachButtonAction:(UIButton *)button {
    NSLog(@"点击了搜索按钮");
    [self.view endEditing:YES];
    NSString *urlStr;
    //按输入、年级、类型搜索
    if (!(textField.text.length == 0) && ![searchType isEqualToString:@"0"] && [searchGrade isEqualToString:@"全部"]) {
        urlStr = [NSString stringWithFormat:@"m30/M3001I/M3001I003/nowPage/1/searchGrade/%@/searchTitle/%@/searchType/%@/searchPhase/%@",searchGrade,textField.text,searchType,@"1"];
    }
    //按输入、类型搜索，年级为全部
    else if (!(textField.text.length == 0) && ![searchType isEqualToString:@"0"] && [searchGrade isEqualToString:@"全部"]) {
        urlStr = [NSString stringWithFormat:@"m30/M3001I/M3001I003/nowPage/1/searchTitle/%@/searchType/%@",textField.text,searchType];
    }
     //按输入、年级搜索，类型为全部
    else if (!(textField.text.length == 0) && [searchType isEqualToString:@"0"] && ![searchGrade isEqualToString:@"全部"]) {
        urlStr = [NSString stringWithFormat:@"m30/M3001I/M3001I003/nowPage/1/searchGrade/%@/searchTitle/%@/searchPhase/%@",searchGrade,textField.text,@"1"];
    }
    //输入为空，全部年级和类型
    else if ((textField.text.length == 0) && [searchType isEqualToString:@"0"] && [searchGrade isEqualToString:@"全部"]) {
        urlStr = [NSString stringWithFormat:@"m30/M3001I/M3001I003/nowPage/1"];
    }
    //输入为空，按类搜索，年级为全部
    else if (textField.text.length == 0 && ![searchType isEqualToString:@"0"] && [searchGrade isEqualToString:@"全部"]) {
        urlStr = [NSString stringWithFormat:@"m30/M3001I/M3001I003/nowPage/1/searchType/%@",searchType];
    }
    //输入为空，按年级搜索，类型为全部
    else if ((textField.text.length == 0) && [searchType isEqualToString:@"0"] && ![searchGrade isEqualToString:@"全部"]) {
        urlStr = [NSString stringWithFormat:@"m30/M3001I/M3001I003/nowPage/1/searchGrade/%@/searchPhase/%@",searchGrade,@"1"];
    }
    //输入为空，按类和年级搜索资料
    else if ((textField.text.length == 0) && ![searchType isEqualToString:@"0"] && ![searchGrade isEqualToString:@"全部"]) {
        urlStr = [NSString stringWithFormat:@"m30/M3001I/M3001I003/nowPage/1/searchType/%@/searchGrade/%@/searchPhase/%@",searchType,searchGrade,@"1"];
    }
    //按输入搜索，年级和类型为全部
    else {
        urlStr = [NSString stringWithFormat:@"m30/M3001I/M3001I003/nowPage/1/searchTitle/%@",textField.text];
    }
    if (urlStr == nil) {
        return;
    }
    
    //请求网络
    [kNetworkSingleton requestURL:urlStr httpMethod:kGET params:nil successBlock:^(id data) {
        NSLog(@"分类请求成功%@",data);
        //如果返回的不是一个字典，则返回错误
        if (![data isKindOfClass:[NSDictionary class]]) {
            return ;
        }
        //如果输入为0
        NSDictionary *dataDic = (NSDictionary *)data;
        if (dataDic.count == 0) {
            return;
        }
        //返回出错
        NSNumber *errorFlag = dataDic[@"errorFlag"];
        BOOL isSuccecc = [errorFlag boolValue];
        if (isSuccecc) {
            return;
        }
        //成功
        dataArray = [NSMutableArray array];
        NSArray *tempArray = dataDic[@"data"];
        for (NSDictionary *dic in tempArray) {
            PublicResModel *model = [PublicResModel objectWithKeyValues:dic];
            [dataArray addObject:model];
        }
        //刷新表视图
        UITableView *cutableView = _tableViewArr[currentIndex];
        [cutableView reloadData];
        
    } failedBlock:^(NSError *error) {
        NSLog(@"分类请求失败%@",error);
        
    }];
}


#pragma mark - 创建分栏按钮视图
- (void)createColumButton {
    //背景图
    columView = [[UIView alloc] init];
    [topView addSubview:columView];
    
    [columView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView).offset(10);
        make.right.equalTo(topView).offset(-10);
        make.top.equalTo(searchBar.mas_bottom).offset(5);
        make.height.mas_equalTo(25);
    }];
    
    //循环创建5个button
    NSArray *title = @[@"全部",@"教案",@"视频",@"音频",@"课件"];
    buttonArr = [NSMutableArray array];
    for (int i = 0; i < 5; i ++) {
        UIButton *allButton = [UIButton buttonWithType:UIButtonTypeCustom];
        allButton.tag = i;
        CGFloat buttonW = 50;
        allButton.frame = CGRectMake((buttonW + 20)* i + 10, 5, buttonW, 15);
        [allButton setImage:[UIImage imageNamed:@"quan_ico"] forState:UIControlStateNormal];
        [allButton setTitle:title[i] forState:UIControlStateNormal];
        [allButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        allButton.titleLabel.font = [UIFont systemFontOfSize:12];
        allButton.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 0);
        allButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [allButton addTarget:self action:@selector(allButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [columView addSubview:allButton];
        
        [buttonArr addObject:allButton];
    }
    UIButton *firstbutton = (UIButton *)[buttonArr firstObject];
    [firstbutton setImage:[UIImage imageNamed:@"all_ico"] forState:UIControlStateNormal];
    [firstbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

#pragma mark - 分栏按钮点击事件
- (void)allButtonAction:(UIButton *)button {
    NSLog(@"点击了分栏按钮");
    [buttonArr enumerateObjectsUsingBlock:^(UIButton * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.tag == button.tag) {
            
            [obj setImage:[UIImage imageNamed:@"all_ico"] forState:UIControlStateNormal];
            [obj setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        else {
            [obj setImage:[UIImage imageNamed:@"quan_ico"] forState:UIControlStateNormal];
            [obj setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }
    }];
    
    if (button.tag == 0) { //全部
        searchType = @"0";
    }
    else if (button.tag == 1) { //教案
        searchType = @"5";
    }
    else if (button.tag == 2) { //视频
        searchType = @"1";
    }
    else if (button.tag == 3) { //音频
        searchType = @"4";
    }
    else if (button.tag == 4) { //课件
        searchType = @"3";
    }
    
    [self seachButtonAction:nil];
    
}

#pragma mark - 年级滑动视图
- (void)createGradeScrollView {
    [topView addSubview:self.topBarView];
    _gradeTitle = [[NSMutableArray alloc] init];
    _tableViewArr = [[NSMutableArray alloc] init];
    self.gradeTitle = [NSMutableArray arrayWithArray:@[@"全部",@"一年级",@"二年级",@"三年级",@"四年级",@"五年级",@"六年级"]];
    
    [self.view addSubview:self.listContentView];
    self.listContentView.contentSize = CGSizeMake(self.listContentView.bounds.size.width * self.gradeTitle.count, self.listContentView.bounds.size.height);
    //循环创建表视图并添加到滑动视图上
    for (int i = 0; i < self.gradeTitle.count; i++) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(i * self.listContentView.bounds.size.width, 0, self.listContentView.bounds.size.width, self.listContentView.bounds.size.height) style:UITableViewStyleGrouped];
        tableView.tag = i+100;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.contentInset = UIEdgeInsetsMake(-36, 0, 0, 0);
        [self.listContentView addSubview:tableView];
        [_tableViewArr addObject:tableView];
    }
    [self updateTopBarView];

}


- (FCTopBarView *)topBarView {
    //年级滑动视图
    if (!_topBarView) {
    _topBarView = [[FCTopBarView alloc] initWithFrame:CGRectMake(0, 100, kWidth, 49)];
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
    
    currentIndex = index;
    
    [self loadData:index];
    
}

- (UIScrollView*)listContentView {
    if (!_listContentView) {
        _listContentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 150 + 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 150 - 64)];
        _listContentView.showsHorizontalScrollIndicator = NO;
        _listContentView.showsVerticalScrollIndicator = NO;
        _listContentView.pagingEnabled = YES;
        _listContentView.bounces = NO;
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
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

#pragma mark - 单元格点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ResourceDetailVC *resourceDetailVC = [[ResourceDetailVC alloc] init];
    resourceDetailVC.publicModel = dataArray[indexPath.row];
    
    [self.navigationController pushViewController:resourceDetailVC animated:YES];
    
}

@end
