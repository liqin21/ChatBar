//
//  MessageViewController.m
//  聊吧
//
//  Created by m on 16/5/23.
//  Copyright (c) 2016年 m. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageModel.h"
#import "MessageCell.h"
#import "MJExtension.h"

@interface MessageViewController ()

@end

@implementation MessageViewController
{
    UITableView *_tableView;
    NSMutableArray *_data;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";
    self.view.backgroundColor = [UIColor redColor];
    
    //创建表视图
    [self _cteateTableView];
    
    //加载数据
    [self _loadData];
//
}

#pragma mark -创建表视图
- (void)_cteateTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame  style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

#pragma mark - 加载数据
- (void)_loadData {
    //创建数据
    _data = [NSMutableArray array];
    NSMutableDictionary *muDic1 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"001",@"useImg",@"001号",@"name",@"10:11",@"time",@"你吃了吗",@"content",@"3",@"number",nil];
    
    NSMutableDictionary *muDic2 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"002",@"useImg",@"002号",@"name",@"12:53",@"time",@"你还好吗",@"content",@"5",@"number",nil];
    
    NSMutableDictionary *muDic3 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"003",@"useImg",@"003号",@"name",@"14:23",@"time",@"你是谁",@"content",@"2",@"number",nil];
    
    NSMutableDictionary *muDic4 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"004",@"useImg",@"004号",@"name",@"11:43",@"time",@"你在哪里啊",@"content",@"1",@"number",nil];
    
    NSMutableDictionary *muDic5 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"005",@"useImg",@"005号",@"name",@"17:09",@"time",@"你在搞么的哦",@"content",@"5",@"number",nil];
    
    NSMutableDictionary *muDic6 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"006",@"useImg",@"006号",@"name",@"11:53",@"time",@"再不说话我要发火了，怎么对我爱理不理的，我哪里得罪你了啊",@"content",@"10",@"number",nil];
    
    NSMutableDictionary *muDic7 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"007",@"useImg",@"007号",@"name",@"09:53",@"time",@"出去玩去",@"content",@"10",@"number",nil];
    
    NSMutableDictionary *muDic8 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"008",@"useImg",@"008号",@"name",@"07:43",@"time",@"走了吗",@"content",@"10",@"number",nil];
    NSArray *array = @[muDic1,muDic2,muDic3,muDic4,muDic5,muDic6,muDic7,muDic8];
    //加载数据,利用MJ快速设置数据模型
    for (NSDictionary *dic in array) {
        MessageModel *msgModel = [MessageModel objectWithKeyValues:dic];
        [_data addObject:msgModel];
    }
}

#pragma mark - UITableView 代理方法
//1.指定每一组中单元格的数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}


//2.创建单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //单元格的复用方法
    static NSString *identifier = @"messageCell";
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        //创建单元格
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    //设置内容
    MessageModel *msgModel = _data[indexPath.row];
    cell.msgModel = msgModel;
//
    return cell;
}

//3.设置单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat cellHeight = (kHeight - 64 - 49 - 8 * 0.5) / 8;
    
    return cellHeight;
}

//点击单元格时调用的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //点击后立即去除点击效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
