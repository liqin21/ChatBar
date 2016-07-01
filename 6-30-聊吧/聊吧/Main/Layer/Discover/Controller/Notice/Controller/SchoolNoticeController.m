//
//  SchoolNoticeController.m
//  聊吧
//
//  Created by m on 16/6/14.
//  Copyright © 2016年 m. All rights reserved.
//

#import "SchoolNoticeController.h"
#import "SchoolNoticeCell.h"
#import "SchoolNoticeModel.h"
#import "NetworkSingleton.h"
#import "DetailNotificationVC.h"




@interface SchoolNoticeController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UILabel *flagLable;

@end

@implementation SchoolNoticeController {
    UITableView *_tableView;
    NSMutableArray *_data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"学校通告";
    self.view.backgroundColor = [UIColor greenColor];
    
    //1.加载数据
    [self loadData];
    
    //2.设置导航栏
    [self setNavigationBar];
    
    //3.创建表视图
    [self createTableView];
    
    
    
}

#pragma mark - 加载数据
- (void)loadData {
    //请求网络接口
    NSString *urlStr = @"/m17/SchoolNotice/Index";
    NSDictionary *dic = @{
                          @"uid":kUserModel.uid,
                          @"key":kUserModel.key
                          };
    [NetworkSingleton requestURL:urlStr httpMethod:kPOST params:dic successBlock:^(id data) {
        NSLog(@"请求成功啦啊啊啊,%@",data);
        
        if (![data isKindOfClass:[NSArray class]]) {
            return ;
        }
        NSArray *array = (NSArray *)data;
        if (array.count == 0) {
            _flagLable.hidden = NO;
            return;
        }
        else {
            _flagLable.hidden = YES;
        }
        _data = [NSMutableArray array];
        for (NSDictionary *dic in data) {
            SchoolNoticeModel *model = [SchoolNoticeModel objectWithKeyValues:dic];
            [_data addObject:model];
        };
        
        //刷新数据
        [_tableView reloadData];
        
        
    } failedBlock:^(NSError *error) {
        
        NSLog(@"请求失败拉啊啊啊 error = %@",error);
    }];
    
//    //创建数据
//    NSDictionary *dic1 = @{@"title":@"传媒关注单元Day2：林更新本色耍宝 夏雨斗萝莉",@"time":@"2016-6-11 14：53：23",@"content":@"1905电影网专稿 6月13日，又有两部喜剧电影亮相电影频道传媒关注单元，它们分别是主打夺宝冒险的《快手枪手快枪手》，以及充满温情的《洛杉矶捣蛋计划》。展映结束后，两部影片的主创代表也来到现场，与媒体评审们进行互动交流。"};
//    
//    NSDictionary *dic2 = @{@"title":@"李安现身“喜天之夜” 吴秀波杨洋两款男神同框",@"time":@"2016-6-13 09:33;23",@"content":@"1905电影网讯 6月13日，喜天影视全资子公司喜天影业正式成立，著名导演李安及多位业界大佬前来助阵，吴秀波、马丽、李光洁、王太利、田雨、谭凯亮相，从荣信达出走的杨洋、蒋梦婕以及从唐人影视出走的蒋劲夫也作为旗下艺人现身。"};
//    
//    NSDictionary *dic3 = @{@"title":@"长江图》定档9月8日 以4k巨幕版展现胶片质感",@"time":@"2016-6-14 12:32:13",@"content":@"1905电影网讯 6月13日，电影《长江图》亮相第19届上海国际电影节，导演杨超、制片人王彧，携主演辛芷蕾、谭凯、邬立朋共同出席，并宣布影片将于9月8日以4K中国巨幕版本正式登陆内地院线"};
//   
//    NSDictionary *dic4 = @{@"title":@"林丹：先不想奥运三连冠 能四次参赛已很了不起",@"time":@"2016-6-14 14:34:24", @"content":@"作为劳伦斯的形象大使，林丹近日接受了他们的专访，他谈到了奥运会，也谈到了老对手李宗伟，还有中国的年轻选手们。"};
//    
//    NSDictionary *dic5 = @{@"title":@"中国未来三天暴雨面积达100万平方公里",@"time":@"2016-6-14 12:22:34",@"content":@"近期，南北方均多降雨，对公众出行带来较大影响"};
//   
//    NSDictionary *dic6 = @{@"title":@"发电量持续下跌 央企电力巨头市值惨跌500亿",@"time":@"2016-6-13 23:22:00",@"content":@"根据华润电力（00863.HK）公告的最新运营数据：今年4月和5月售电量持续同比下跌。月度跌幅虽然收窄，但前5个月合计仍然录得同比负增长。华润电力的股价则在端午节前创下近四年多周收盘新低，节后开盘继续下跌。总市值已经较一年多前腰斩，折损超过500亿港元。"};
    
//    NSArray *array = @[dic1,dic2,dic3,dic4,dic5,dic6];
//    
//    //利用MJ快速创建model
//    _data = [NSMutableArray array];
//    for (NSDictionary *dic in array) {
//        SchoolNoticeModel *model = [SchoolNoticeModel objectWithKeyValues:dic];
//        
//        [_data addObject:model];
//    }
}


#pragma mark - 设置导航栏
- (void)setNavigationBar {
    self.title = @"公告";
    //左边导航项
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"black"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] style:UIBarButtonItemStylePlain target:self action:@selector(leftItemAction:)];
    
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)leftItemAction:(UIBarButtonItem *) item {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 创建表视图
- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
}



#pragma mark -UITableView 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"shcoolNoticeCell";
    SchoolNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[SchoolNoticeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    //设置数据
    cell.model = _data[indexPath.row];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //进入通知详情界面
    DetailNotificationVC *detailNotificationVC = [[DetailNotificationVC alloc] init];
    //取得所点击的单元格的数据
    SchoolNoticeModel *model = _data[indexPath.row];
    //把取得的数据传给下一个控制器
    detailNotificationVC.htlmString = model.url;
    detailNotificationVC.htmlID = model.noticeid;
    
    [self.navigationController pushViewController:detailNotificationVC animated:YES];
}

#pragma mark - 添加新的Label
- (void)createFlagLabel {
    if (_flagLable == nil) {
        _flagLable = [[UILabel alloc] initWithFrame:CGRectMake(kWidth / 2.0 - 50, kHeight / 2.0, 100, 20)];
        _flagLable.font = [UIFont systemFontOfSize:18];
        _flagLable.textColor = [UIColor lightGrayColor];
        _flagLable.text = NSLocalizedString(@"无新的数据!", @"Network disconnection");
        [self.view addSubview:_flagLable];
    }
}

@end
