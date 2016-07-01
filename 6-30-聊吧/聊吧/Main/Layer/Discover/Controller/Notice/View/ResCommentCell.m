//
//  ResCommentCell.m
//  聊吧
//
//  Created by m on 16/6/28.
//  Copyright © 2016年 m. All rights reserved.
//

#import "ResCommentCell.h"
#import "ResCommentModel.h"


@implementation ResCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    UIView *contentView = self.contentView;
    
    //头像
    _headImg = [[UIImageView alloc] init];
    _headImg.image = [UIImage imageNamed:@"003"];
    
    
    //名字
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.text = @"张老师";
    
    
    //排序
    _sortLabel = [[UILabel alloc] init];
    _sortLabel.text = @"1楼";
    _sortLabel.textColor = [UIColor lightGrayColor];
    _sortLabel.font = [UIFont systemFontOfSize:13];
    
    //时间
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.text = @"2016-06-28 15:30:23";
    _timeLabel.font = [UIFont systemFontOfSize:13];
    
    //内容
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.text = @"这个不错，大家可以仔细看看";
    _contentLabel.font = [UIFont systemFontOfSize:15];
    
    [contentView sd_addSubviews:@[_headImg,_nameLabel,_sortLabel,_timeLabel,_contentLabel]];
    
    //设置约束
    _headImg.sd_layout.leftSpaceToView(contentView,10).topSpaceToView(contentView,10).heightIs(47).widthIs(47);
    _headImg.layer.cornerRadius = 24;
    _headImg.layer.masksToBounds = YES;
    
    _nameLabel.sd_layout.leftSpaceToView(_headImg,5).topSpaceToView(contentView,16).heightIs(20);
    [_nameLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    _sortLabel.sd_layout.rightSpaceToView(contentView,20).topEqualToView(_nameLabel).heightIs(15);
    [_sortLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    _timeLabel.sd_layout.leftEqualToView(_nameLabel).bottomEqualToView(_headImg).heightIs(15);
    [_timeLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    _contentLabel.sd_layout.leftEqualToView(_timeLabel).rightSpaceToView(contentView,10).topSpaceToView(_timeLabel,10).autoHeightRatio(0);

    
}


#pragma mark - 设置数据
- (void)setModel:(ResCommentModel *)model {
    _model = model;
    _headImg.image = [UIImage imageNamed:@"user_bg"];
    _nameLabel.text = model.RealName;
    _sortLabel.text = [NSString stringWithFormat:@"%ld楼",model.indexPath.row + 1];
    _timeLabel.text = model.CommentTime;
    _contentLabel.text = model.CommentContent;
    _contentLabel.sd_layout.maxHeightIs(MAXFLOAT);
    
    [self setupAutoHeightWithBottomView:_contentLabel bottomMargin:15];
    
}

@end
