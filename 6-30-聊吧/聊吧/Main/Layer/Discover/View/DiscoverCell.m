//
//  DiscoverCell.m
//  聊吧
//
//  Created by m on 16/5/24.
//  Copyright © 2016年 m. All rights reserved.
//

#import "DiscoverCell.h"
#import "Masonry.h"

@implementation DiscoverCell

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
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:18];
    [contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(contentView);
        make.left.equalTo(_imgView.mas_right).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];

}

@end
