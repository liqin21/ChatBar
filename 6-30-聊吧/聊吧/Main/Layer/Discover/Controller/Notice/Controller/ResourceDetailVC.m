//
//  ResourceDetailVC.m
//  聊吧
//
//  Created by m on 16/6/27.
//  Copyright © 2016年 m. All rights reserved.
//

#import "ResourceDetailVC.h"
#import "PublicResModel.h"
#import "ResDetailModel.h"
#import "ResCommentVC.h"
#import "ResourceShareVC.h"
#import "FileBrowerController.h"
#import "AVPlayerView.h"
#import "MP3PlayerController.h"


@interface ResourceDetailVC ()

@end

@implementation ResourceDetailVC {
    UIImageView *leftImage;
    UILabel *titleLabel;
    UILabel *timeLabel;
    UILabel *authoLabel;
    UILabel *contentLabel;
    NSURL *currentURL;
    UILabel *resLabel;
    UIView *toolView;
    UIButton *downloadBtn;
    UIButton *commentBtn;
    UIButton *shareBtn;
    ResDetailModel *resDetailModel;
    NSURLSessionDownloadTask *downTask;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [downTask cancel];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"资源详情";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    //设置导航栏按钮
    [self setNavigationBar];
    
    //加载数据
    [self loadData];
    
    [self getFileInfoFromSanbox];
    
    
    //界面布局
    [self createSubViews];
    
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
    
    NSString *resId = self.publicModel.Id;
    NSString *urlStr = [NSString stringWithFormat:@"m30/m3002I/m3002I007/userId/%@/resId/%@",kUserModel.uid,resId];
    [kNetworkSingleton requestURL:urlStr httpMethod:kGET params:nil successBlock:^(id data) {
        //如果返回的不是一个字典，则返回错误
        if (![data isKindOfClass:[NSDictionary class]]) {
            return ;
        }
        //数据为0
        NSDictionary *dataDic = (NSDictionary *)data;
        if (dataDic.count == 0) {
            return;
        }
        
        //返回错误信息
        BOOL errorFlag = dataDic[@"errorFlag"];
        if (!errorFlag) {
            return;
        }
        NSLog(@"资源详情数据加载成功%@",data);
        NSDictionary *resData = dataDic[@"resData"];
        resDetailModel = [ResDetailModel objectWithKeyValues:resData];
        
        //设置数据
        contentLabel.text = resDetailModel.resourceIntro;
        
    } failedBlock:^(NSError *error) {

        NSLog(@"请求失败%@",error);
    }];
}


#pragma mark - 界面布局
- (void)createSubViews {
    
    //标题
    titleLabel = [[UILabel alloc] init];
    titleLabel.text = self.publicModel.Title;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:20];
    
    
    //作者
    authoLabel = [[UILabel alloc] init];
    authoLabel.text = [NSString stringWithFormat:@"作者:%@",self.publicModel.UserName];
    authoLabel.textColor = [UIColor blackColor];
    authoLabel.font = [UIFont systemFontOfSize:12];
    
    
    //时间
    timeLabel = [[UILabel alloc] init];
    timeLabel.text = [NSString stringWithFormat:@"时间:%@",self.publicModel.UploadTime];
    timeLabel.textColor = [UIColor blackColor];
    timeLabel.font = [UIFont systemFontOfSize:12];
    
    
    //资源简介
    leftImage = [[UIImageView alloc] init];
    leftImage.image = [UIImage imageNamed:@"ziyuan_ico_n"];
    
    resLabel = [[UILabel alloc] init];
    resLabel.text = @"资源简介";
    resLabel.textColor = [UIColor blackColor];
    resLabel.font = [UIFont systemFontOfSize:18];
    
    //分割线
    UIView *sepView = [[UIView alloc] init];
    sepView.backgroundColor = [UIColor lightGrayColor];
    
    //资源内容
    contentLabel = [[UILabel alloc] init];
    contentLabel.text = @"《周易》，一部充满神秘色彩的经典。上古的卜筮文化，精微的象数义理，神奇的六十四卦符号，隐奥难解的卦爻辞，几千年来让人如醉如痴。";
    contentLabel.font = [UIFont systemFontOfSize:14];
    contentLabel.numberOfLines = 0;
    contentLabel.backgroundColor = [UIColor grayColor];
    
    //工具栏
    toolView = self.createToolBarView;
    
    [self.view sd_addSubviews:@[titleLabel,authoLabel,timeLabel,leftImage,resLabel,contentLabel,toolView]];
    
    //设置约束
    titleLabel.sd_layout.leftSpaceToView(self.view,10).topSpaceToView(self.view,15 + 64).heightIs(20);
    [titleLabel setSingleLineAutoResizeWithMaxWidth:kWidth];
    
    authoLabel.sd_layout.leftSpaceToView(self.view,10).topSpaceToView(titleLabel,10).heightIs(15);
    [authoLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    timeLabel.sd_layout.leftSpaceToView(authoLabel,15).topEqualToView(authoLabel).heightIs(15);
    [timeLabel setSingleLineAutoResizeWithMaxWidth:180];
    
    leftImage.sd_layout.leftEqualToView(titleLabel).topSpaceToView(authoLabel,30).heightIs(25).widthIs(25);
    
    resLabel.sd_layout.leftSpaceToView(leftImage,2).topEqualToView(leftImage).heightIs(25);
    [resLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    sepView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topEqualToView(leftImage).heightIs(1);
    
    contentLabel.sd_layout.leftEqualToView(titleLabel).topSpaceToView(leftImage,10).rightSpaceToView(self.view,10);
    [contentLabel sizeToFit];
    
    
    toolView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(contentLabel,10).heightIs(50);

}

#pragma mark - 创建工具栏
- (UIView *)createToolBarView {
    
    toolView = [[UIView alloc] init];
    toolView.backgroundColor = RGB(239, 240, 243, 1);
    
    //下载按钮
    downloadBtn = [self setButtonWithTitle:@"下载" tag:10 image:@"xiazai_icoh"];
    
    //评论按钮
    commentBtn = [self setButtonWithTitle:@"评论" tag:20 image:@"pinglun_icoh"];
    
    //分享按钮
    shareBtn = [self setButtonWithTitle:@"分享" tag:30 image:@"ico_share_-h"];
    
    [toolView sd_addSubviews:@[downloadBtn,commentBtn,shareBtn]];
    
    //设置约束
    downloadBtn.sd_layout.leftSpaceToView(toolView,10).centerYEqualToView(toolView).heightIs(40).widthIs(100);
    
    commentBtn.sd_layout.centerXEqualToView(toolView).centerYEqualToView(toolView).heightIs(40).widthIs(100);
    
    shareBtn.sd_layout.rightSpaceToView(toolView,10).centerYEqualToView(toolView).heightIs(40).widthIs(100);
    
    return toolView;
}

- (UIButton *)setButtonWithTitle:(NSString *)title tag:(NSInteger)tag image:(NSString *)image {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    button.tag = tag;
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(toolButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return  button;
}

#pragma mark - 工具栏按钮点击事件
- (void)toolButtonAction:(UIButton *)button {
   
    NSString *title = [button titleForState:UIControlStateNormal];
    if ([title isEqualToString:@"下载"]) {
        //调用验证积分方法
//        [self identifyPriceBeforeDownload];
        [self download];
    }
    if ([title isEqualToString:@"阅读"]) {
            //如果是mp3类型，则进入mp3文件播放界面
        if ([resDetailModel.title rangeOfString:@"mp3"].location != NSNotFound) {
            MP3PlayerController *mp3PlayCT = [[MP3PlayerController alloc] init];
            //传递数据
            mp3PlayCT.mp3URL = currentURL;
            mp3PlayCT.mp3Name = self.publicModel.Title;
            
            [self.navigationController pushViewController:mp3PlayCT animated:YES];
            
        }
            
        //如果是mp4类型，则进入mp4播放界面
    else if ([resDetailModel.title rangeOfString:@"mp4"].location != NSNotFound) {
                [self playView];
            }
            
    //如果是文件类型，则进入阅读文件页面
    else {
        FileBrowerController *fileBrowerCT = [[FileBrowerController alloc] init];
        //取得数据
        fileBrowerCT.fileURL = currentURL;
        fileBrowerCT.fileTitle = resDetailModel.title;
        
        [self.navigationController pushViewController:fileBrowerCT animated:YES];
        }
    }
    //评论
    if ([title isEqualToString:@"评论"]) {
        ResCommentVC *resCommentVC = [[ResCommentVC alloc] init];
        resCommentVC.publicModel = self.publicModel;
        
        [self.navigationController pushViewController:resCommentVC animated:YES];

    }
    //分享
    if ([title isEqualToString:@"分享"]) {
        ResourceShareVC *resourceShareVC = [[ResourceShareVC alloc] init];
        
        
        [self.navigationController pushViewController:resourceShareVC animated:YES];
    }
}

#pragma mark - 播放MP4 文件
- (void)playView {
    AVPlayerView *avView = [AVPlayerView sharAVPlayer];
    avView.frame = self.view.frame;
    [avView setTitlestr:resDetailModel.title];
    [avView setBacktitle:@"资源详情"];
    avView.videoUrl = currentURL;
    [avView playurl];
}

#pragma mark - 下载前先验证积分
- (void)identifyPriceBeforeDownload {
    //积分
    NSString *price = self.publicModel.Price;
    NSString *resId = self.publicModel.Id;
    NSString *belongId = self.publicModel.UserId;
    NSString *userId = kUserModel.uid;
    
    //地址
    NSString *urlStr = [NSString stringWithFormat:@"m30/m3002I/m3002I004/resId/%@/coin/%@/belongId/%@/userId/%@",resId,price,belongId,userId];
    [kNetworkSingleton requestURL:urlStr httpMethod:kGET params:nil successBlock:^(id data) {
        NSLog(@"积分验证成功%@",data);
        //如果返回的不是一个字典则返回错误
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
            NSString *errorMsg = dataDic[@"errorMsg"];
            [self showErrorMessage:errorMsg];
            return;
        }
        
        //验证成功，调用下载方法
        [self download];
        
    } failedBlock:^(NSError *error) {
        NSLog(@"积分验证失败%@",error);
    }];
}

#pragma mark - 积分不足弹出提示框
- (void)showErrorMessage:(NSString *)message {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark - 下载
- (void)download {
    
    NSString *urlStr =  [NSString stringWithFormat:@"m30/M3002I/M3002I006/resId/%@/userId/%@",self.publicModel.Id,kUserModel.uid];
    //下载数据
    [downloadBtn setTitle:@"下载中..." forState:UIControlStateNormal];
    
    downTask = [kNetworkSingleton downloadURL:urlStr desPath:nil fileName:self.publicModel.Id progressBlock:^(CGFloat progress) {
        //进度
//        NSLog(@"进度%f",progress);
        
    } successBlock:^(id data) {
       //成功回调
        NSLog(@"xx加载成功%@",data);
        [downloadBtn setTitle:@"阅读" forState:UIControlStateNormal];
        currentURL = (NSURL *)data;
        //保存文件信息
        NSString *fileName = currentURL.path.lastPathComponent;
        [self saveFileInforToSanbox:self.publicModel.Id fileName:fileName];
        
    } failedBlock:^(NSError *error) {
        //失败回调
        NSLog(@"加载失败xx%@",error);
    }];
}

#pragma mark -保存文件
- (void)saveFileInforToSanbox:(NSString *)resId fileName:(NSString *)fileName {
    //
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取完整路径
    NSString *docoumentsPath = [path objectAtIndex:0];
    
    NSString *plistPath = [docoumentsPath stringByAppendingPathComponent:@"fileInfoList.plist"];
    
    BOOL isExists = [[NSFileManager defaultManager] fileExistsAtPath:plistPath];
    NSMutableArray *filesArray;
    if (isExists) {
        filesArray = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    }
    else {
        filesArray = [[NSMutableArray alloc] init];
    }
    
    NSMutableDictionary *usersDic = [[NSMutableDictionary alloc] init];
    //设置属性值
    [usersDic setObject:resId forKey:@"resId"];
    [usersDic setObject:fileName forKey:@"fileName"];
    [filesArray addObject:usersDic];
    
    //写文件
    [filesArray writeToFile:plistPath atomically:YES];
    
}

#pragma mark - 获取文件
- (BOOL)getFileInfoFromSanbox {
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //获取完整路径
    NSString *documentsPath = [path objectAtIndex:0];
    
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"fileInfoList.plist"];
    
    NSMutableArray *fileArray = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];

    for (NSDictionary *dic in fileArray) {
        NSString *resId = self.publicModel.Id;
        if ([resId isEqualToString:@"resId"]) {
            NSString *currentPath = [NSString stringWithFormat:@"%@/%@",kdownloadDirectory,dic[@"fileName"]];
            currentURL = [NSURL fileURLWithPath:currentPath];
            [downloadBtn setTitle:@"阅读" forState:UIControlStateNormal];
            return YES;
        }
    }
    return NO;
}

#pragma mark - 设置数据
- (void)setPublicModel:(PublicResModel *)publicModel {
    _publicModel = publicModel;
    titleLabel.text = publicModel.Title;
    
}

@end
