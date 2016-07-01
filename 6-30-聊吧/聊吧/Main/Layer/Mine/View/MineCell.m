//
//  MineCell.m
//  聊吧
//
//  Created by m on 16/5/24.
//  Copyright © 2016年 m. All rights reserved.
//

#import "MineCell.h"
#import "MineModel.h"
#import "Masonry.h"

@implementation MineCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //自定义单元格
        [self _customCell];
    }
    return self;
}

//自定义单元格
- (void)_customCell {
    UIView *contentView = self.contentView;
    //左边图片
    _imgView = [[UIImageView alloc] init];
    [contentView addSubview:_imgView];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(contentView);
        make.left.equalTo(contentView).offset(15);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
    }];
    
    //标题
    _titlelabel = [[UILabel alloc] init];
    _titlelabel.text = @"我的班级";
    _titlelabel.font = [UIFont systemFontOfSize:18];
    [contentView addSubview:_titlelabel];
    [_titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imgView.mas_right).offset(10);
        make.centerY.equalTo(contentView);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(30);
    }];
    
    //右边箭头
    UIImageView *arrowImg = [[UIImageView alloc] init];
    arrowImg.image = [UIImage imageNamed:@"mine_arrow_right-1"];
    [contentView addSubview:arrowImg];
    [arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(contentView);
        make.right.equalTo(contentView).offset(-10);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
    }];
    
    //显示信息量的Label
    _countLabel = [[UILabel alloc] init];
    _countLabel.backgroundColor =  [UIColor colorWithRed:250/255.0 green:108/255.0 blue:15/255.0 alpha:1];
    _countLabel.text = @"3";
    _countLabel.font = [UIFont systemFontOfSize:14];
    _countLabel.textColor = [UIColor whiteColor];
    _countLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:_countLabel];
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(contentView);
        make.right.equalTo(arrowImg.mas_left).offset(-10);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(18);
        _countLabel.layer.cornerRadius = 9;
        _countLabel.layer.masksToBounds = YES;
    }];
    
}


@end
