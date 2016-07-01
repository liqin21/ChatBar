//
//  MessageCell.m
//  聊吧
//
//  Created by m on 16/5/23.
//  Copyright (c) 2016年 m. All rights reserved.
//

#import "MessageCell.h"
#import "MessageModel.h"
#import "Masonry.h"


@implementation MessageCell {
    CGFloat cellHeight;
}
//复写单元格的初始化方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //自定义单元格
        cellHeight = ([UIScreen mainScreen].bounds.size.height - 64 - 49) / 8.0;
        [self _customCell];

    }
    return self;
}



//自定义单元格
- (void)_customCell {
    UIView *contentView = self.contentView;
    //1.头像
    useImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    useImg.image = [UIImage imageNamed:@"myinfoFriendZiliao_touxiang"];
    [contentView addSubview:useImg];
    [useImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(contentView);
        make.left.equalTo(contentView).offset(15);
        make.width.mas_equalTo(cellHeight - 10);
        make.height.mas_equalTo(cellHeight - 10);
    }];
    
    //显示名字
    nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"名字";
    nameLabel.font = [UIFont systemFontOfSize:16];
    [contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(5);
        make.left.equalTo(useImg.mas_right).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    //显示时间
    timeLabel = [[UILabel alloc] init];
    timeLabel.text = @"09:53";
    timeLabel.textColor = [UIColor lightGrayColor];
    timeLabel.textAlignment = NSTextAlignmentRight;
    timeLabel.font = [UIFont systemFontOfSize:14];
    [contentView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(5);
        make.right.equalTo(contentView).offset(-10);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
    
    //显示信息量
    countLabel = [[UILabel alloc] init];
    countLabel.backgroundColor = [UIColor colorWithRed:250/255.0 green:108/255.0 blue:15/255.0 alpha:1];
    countLabel.text = @"3";
    countLabel.textColor = [UIColor whiteColor];
    countLabel.textAlignment = NSTextAlignmentCenter;
    countLabel.font = [UIFont systemFontOfSize:14];
    [contentView addSubview:countLabel];
    [countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timeLabel.mas_bottom).offset(5);
        make.right.equalTo(contentView).offset(-10);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
        countLabel.layer.cornerRadius = 10;
        countLabel.layer.masksToBounds = YES;
    }];

    
    //显示内容
    contentLabel = [[UILabel alloc] init];
    contentLabel.text = @"你吃了吗";
    contentLabel.textColor = [UIColor lightGrayColor];
    contentLabel.font = [UIFont systemFontOfSize:14];
    [contentView addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).offset(5);
        make.bottom.equalTo(contentView.mas_bottom).offset(-5);
        make.left.equalTo(useImg.mas_right).offset(10);
        make.right.equalTo(countLabel.mas_left).offset(-15);
    }];
    
    //底部下划线
//    UIView *sepView = [[UIView alloc] init];
//    sepView.backgroundColor = [UIColor lightGrayColor];
//    [contentView addSubview:sepView];
//    [sepView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(contentView.mas_bottom).offset(-0.2);
//        make.left.equalTo(contentView).offset(10);
//        make.right.equalTo(contentView).offset(-10);
//        make.height.mas_equalTo(0.2);
//    }];
//

}

//设置数据
- (void)setMsgModel:(MessageModel *)msgModel {
    _msgModel = msgModel;
    
    useImg.image = [UIImage imageNamed:msgModel.useImg];
    
    nameLabel.text = msgModel.name;
    
    contentLabel.text = msgModel.content;
    
    timeLabel.text = msgModel.time;
    
    countLabel.text = msgModel.number;
    
}


@end
