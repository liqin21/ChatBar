//
//  NotificationCell.m
//  聊吧
//
//  Created by m on 16/6/24.
//  Copyright © 2016年 m. All rights reserved.
//

#import "NotificationCell.h"
#import "NotificationModel.h"


@implementation NotificationCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setup];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void) setup {
    UIView *contentView = self.contentView;
    //标题
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"重要通知，各单位注意";
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    
    //内容
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.text = @"下面发布一个重要消息，下面发布一个重要消息，下面发布一个重要消息";
    _contentLabel.textColor = [UIColor blackColor];
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.textAlignment = NSTextAlignmentLeft;
    
    //时间
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.text = [NSString stringWithFormat:@"发布时间:%@",@"2016-05-30 15:30:54"];
    _timeLabel.textColor = [UIColor blackColor];
    _timeLabel.font = [UIFont systemFontOfSize:12];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    
    [contentView sd_addSubviews:@[_titleLabel,_contentLabel,_timeLabel]];
    
    //设置约束
    _titleLabel.sd_layout.leftSpaceToView(contentView,8).topSpaceToView(contentView,9).heightIs(20);
    [_titleLabel setSingleLineAutoResizeWithMaxWidth:kWidth - 16];

    _contentLabel.sd_layout.leftEqualToView(_titleLabel).topSpaceToView(_titleLabel,9).heightIs(18);
    [_contentLabel setSingleLineAutoResizeWithMaxWidth:kWidth - 16];
    
    _timeLabel.sd_layout.rightSpaceToView(contentView,8).topSpaceToView(_contentLabel,9).heightIs(15);
    [_titleLabel setSingleLineAutoResizeWithMaxWidth:200];

}


//设置数据
- (void)setNotificationModel:(NotificationModel *)notificationModel {
   
    _notificationModel = notificationModel;
    _titleLabel.text = notificationModel.title;
    _contentLabel.text = notificationModel.content;
    _timeLabel.text = [NSString stringWithFormat:@"发布时间:%@",notificationModel.time];
    
}


@end
