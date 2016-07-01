//
//  MyClassCell.m
//  聊吧
//
//  Created by m on 16/6/15.
//  Copyright © 2016年 m. All rights reserved.
//

#import "MyClassCell.h"

@implementation MyClassCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
        if (self) {
            [self setup];
        }
        return self;
}

//布局
- (void) setup {
    UIView *contentView = self.contentView;
    
    //头像
    _iconImage = [[UIImageView alloc] init];
    
    
    //姓名
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:14];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    
    [contentView sd_addSubviews:@[_iconImage,_nameLabel]];
    
    //设置约束
    _iconImage.sd_layout.rightSpaceToView(contentView,10).leftSpaceToView(contentView,10).topSpaceToView(contentView,10).bottomSpaceToView (contentView,30);
    
    _nameLabel.sd_layout.centerXEqualToView(contentView).heightIs(20).topSpaceToView(_iconImage,5);
    [_nameLabel setSingleLineAutoResizeWithMaxWidth:80];
    
    
}


@end
