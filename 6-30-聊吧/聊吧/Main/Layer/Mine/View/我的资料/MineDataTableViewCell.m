//
//  MineDataTableViewCell.m
//  家校通
//
//  Created by m on 16/6/8.
//  Copyright © 2016年 m. All rights reserved.
//

#import "MineDataTableViewCell.h"
#import "MineModel.h"


@implementation MineDataTableViewCell {
    UIImageView *_arrowImage;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setup {
   
    UIView *contentView = self.contentView;
    //1.左边图案
    _leftImage = [[UIImageView alloc] init];
    _leftImage.image = [UIImage imageNamed:@"myZiliao_mytouxiang"];
    
    //2.标题
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"我的头像";
    
    
    //3.右边箭头
    _arrowImage = [[UIImageView alloc] init];
    _arrowImage.image = [UIImage imageNamed:@"mine_arrow_right"];
    
    //4.显示内容的Label
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.text = @"麦子小姐";
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    
    [contentView sd_addSubviews:@[_leftImage,_titleLabel,_arrowImage,_contentLabel]];
    
    //设置约束
    _leftImage.sd_layout.leftSpaceToView(contentView,15).centerYEqualToView(contentView).widthIs(14).heightIs(16);
    
    _titleLabel.sd_layout.leftSpaceToView(_leftImage,5).centerYEqualToView(contentView).heightIs(30).widthIs(120);
    
    _arrowImage.sd_layout.rightSpaceToView(contentView,5).centerYEqualToView(contentView).heightIs(25).widthIs(25);
    
    _contentLabel.sd_layout.rightSpaceToView(_arrowImage,5).centerYEqualToView(contentView).heightIs(30);
    [_contentLabel setSingleLineAutoResizeWithMaxWidth:150];
    
}

#pragma mark - 设置数据
- (void)setModel:(MineDataModel *)model {
    _model = model;
    _leftImage.image = [UIImage imageNamed:model.imageName];
    _titleLabel.text = model.title;
    _contentLabel.text = model.content;
    
}


@end
