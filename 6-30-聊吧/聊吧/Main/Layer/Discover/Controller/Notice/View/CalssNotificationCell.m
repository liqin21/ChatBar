//
//  CalssNotificationCell.m
//  聊吧
//
//  Created by m on 16/6/25.
//  Copyright © 2016年 m. All rights reserved.
//

#import "CalssNotificationCell.h"
#import "NotificationWebVC.h"


@implementation CalssNotificationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setup];
    }
    return self;
}

- (void)setup {
    UIView *contentView = self.contentView;
    //1.左边标题
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"重大新闻";
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.font = [UIFont boldSystemFontOfSize:18];
    
    //2.右边时间
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.text = @"2016-6-13 11:30:24";
    _timeLabel.textColor = RGB(77, 77, 77, 1);
    _timeLabel.textAlignment = NSTextAlignmentRight;
    _timeLabel.font = [UIFont systemFontOfSize:12];
    
    
    //3.内容
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.text = @"以“文化走出去”为主题的漫谈,很快就聚焦到当下层出不穷的“神翻译”上。在剧院工作的韩明还举了一个例子:“有次我陪外国友人去看戏,发现《单刀会》竟然被...";
    _contentLabel.textColor = [UIColor blackColor];
    _contentLabel.textAlignment = NSTextAlignmentLeft;
    _contentLabel.font = [UIFont systemFontOfSize:16];
    
    [contentView sd_addSubviews:@[_titleLabel,_timeLabel,_contentLabel]];
    
    //设置约束
    CGFloat margin = 10;
    _timeLabel.sd_layout.rightSpaceToView(contentView,10).topSpaceToView(contentView,5).heightIs(30).widthIs(130);
    
    _titleLabel.sd_layout.leftSpaceToView(contentView,margin).topSpaceToView(contentView,5).rightSpaceToView(_timeLabel,5).heightIs(30);
    
    _contentLabel.sd_layout.leftEqualToView(_titleLabel).topSpaceToView(_titleLabel,margin).rightSpaceToView(contentView,margin).heightIs(30);
    
}

//设置数据
- (void)setClassNoticeModel:(ClassNoticeModel *)classNoticeModel {
    _classNoticeModel = classNoticeModel;
//    _titleLabel.text = classNoticeModel.
    
}

@end
