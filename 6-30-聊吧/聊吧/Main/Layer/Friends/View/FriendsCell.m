//
//  FriendsCell.m
//  聊吧
//
//  Created by m on 16/5/24.
//  Copyright © 2016年 m. All rights reserved.
//

#import "FriendsCell.h"
#import "FriendsModel.h"
#import "Masonry.h"

@implementation FriendsCell {
    CGFloat cellHeight;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //自定义单元格
        cellHeight = ([UIScreen mainScreen].bounds.size.height - 64 - 49 - 4 * 0.5)/8.0;
        [self _customCell];
    }
    return self;
}

- (void)_customCell {
    UIView *contentView = self.contentView;
    //左边头像
    useImg = [[UIImageView alloc] init];
    [contentView addSubview:useImg];
    [useImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(contentView);
        make.left.equalTo(contentView).offset(10);
        make.height.mas_equalTo(cellHeight - 20);
        make.width.mas_equalTo(cellHeight - 20);
    }];
    
    //名字
    nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"名字";
    [contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(contentView);
        make.left.equalTo(useImg.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(100);
    }];
    
}

//设置数据
- (void)setFriendsModel:(FriendsModel *)friendsModel {
    _friendsModel = friendsModel;
    useImg.image = [UIImage imageNamed:friendsModel.useImg];
    nameLabel.text = friendsModel.name;
}


@end
