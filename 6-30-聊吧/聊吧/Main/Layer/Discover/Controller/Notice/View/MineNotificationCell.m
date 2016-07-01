//
//  MineNotificationCell.m
//  聊吧
//
//  Created by m on 16/6/11.
//  Copyright © 2016年 m. All rights reserved.
//

#import "MineNotificationCell.h"

@implementation MineNotificationCell 

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupDiscoverCell];
    }
    return self;
}

- (void)setupDiscoverCell {
    UIView *contentVeiw = self.contentView;
    //左边图片
    _lefeImage = [[UIImageView alloc] init];

    //右边标题
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    //右边箭头
    UIImageView *arrowImage = [[UIImageView alloc] init];
    arrowImage.image = [UIImage imageNamed:@"myinfoFriendZiliao_arrow_right"];
    
    [contentVeiw sd_addSubviews:@[_lefeImage,_titleLabel,arrowImage]];
    
    //设置约束
    _lefeImage.sd_layout.leftSpaceToView(contentVeiw,15).centerYEqualToView(contentVeiw).heightIs(30).widthIs(30);
    
    arrowImage.sd_layout.rightSpaceToView(contentVeiw,5).centerYEqualToView(contentVeiw).heightIs(25).widthIs(25);
    
    _titleLabel.sd_layout.rightSpaceToView(arrowImage,0).centerYEqualToView(contentVeiw).heightIs(30);
    [_titleLabel setSingleLineAutoResizeWithMaxWidth:200];
    
}



@end
