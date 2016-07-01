//
//  FriendsViewController.m
//  聊吧
//
//  Created by m on 16/5/23.
//  Copyright (c) 2016年 m. All rights reserved.
//

#import "FriendsViewController.h"
#import "FriendsCell.h"
#import "FriendsModel.h"
#import "MJExtension.h"


@interface FriendsViewController ()

@end

@implementation FriendsViewController {
    UITableView *_tableView;
    NSMutableArray *_data;
    NSArray *_rightSection;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"好友";
    self.view.backgroundColor = [UIColor orangeColor];
    
    //加载数据
    [self _loadData];
    
    //创建表视图
    [self _createTableView];
    
}

#pragma mark - 加载数据
- (void)_loadData {
    //创建数据
    _data = [NSMutableArray array];
    NSMutableDictionary *muDic1 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"哥哥",@"name",@"001",@"useImg",nil];
    
    NSMutableDictionary *muDic2 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"姐姐",@"name",@"002",@"useImg",nil];
    
    NSMutableDictionary *muDic3 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"阿姨",@"name",@"003",@"useImg",nil];
    
    NSMutableDictionary *muDic4 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"朱辉",@"name",@"004",@"useImg",nil];
    
    NSMutableDictionary *muDic5 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"唐明",@"name",@"005",@"useImg",nil];
    
    NSMutableDictionary *muDic6 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"顺子",@"name",@"006",@"useImg",nil];
    
    NSMutableDictionary *muDic7 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"枸杞",@"name",@"007",@"useImg",nil];
    
    NSMutableDictionary *muDic8 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"主管",@"name",@"00",@"useImg",nil];
    
    NSArray *array = @[muDic1,muDic2,muDic3,muDic4,muDic5,muDic6,muDic7,muDic8];
    
    _rightSection = @[@"家人",@"同学",@"同事"];
    //利用MJ快速设置数据模型
    for (NSDictionary *dic in array) {
        FriendsModel *friendsModel = [FriendsModel objectWithKeyValues:dic];
        [_data addObject:friendsModel];
    }

}

#pragma mark - 创建表视图
- (void)_createTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

#pragma mark - UITableView 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }
    else if (section == 1) {
        return 4;
    }
    else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"friendsCell";
    FriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[FriendsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    //设置数据
    static NSInteger index = 0;
    if (index < _data.count) {
        FriendsModel *friendsModel = _data[index];
        cell.friendsModel = friendsModel;
        index ++;
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellHeight = ([UIScreen mainScreen].bounds.size.height - 64 - 49 - 8 * 0.5 )/ 8.0;
    return cellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWidth, 20)];
    headLabel.backgroundColor = [UIColor colorWithRed:214 / 255.0 green:214 / 255.0 blue:214 / 255.0 alpha:1];
    headLabel.text = _rightSection[section];
    headLabel.textColor = [UIColor darkGrayColor];
    headLabel.textAlignment = NSTextAlignmentCenter;
    headLabel.font = [UIFont systemFontOfSize:16];

//    if (section == 0) {
//        headLabel.text = @"家人";
//    }
//    else if (section == 1) {
//        headLabel.text = @"同学";
//    }
//    else {
//        headLabel.text = @"同事";
//    }
//    
    return headLabel;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}

//设置右侧索引的显示
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    return _rightSection;
}


@end
