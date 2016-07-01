//
//  ListCollectionCell.m
//  聊吧
//
//  Created by m on 16/6/20.
//  Copyright © 2016年 m. All rights reserved.
//

#import "ListCollectionCell.h"
#import "UIImageView+WebCache.h"
#import "TeacherListModel.h"
#import "ClassmateListModel.h"

@implementation ListCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    UIView *contentView = self.contentView;
    _imageView = [[UIImageView alloc] init];
    _imageView.image = [UIImage imageNamed:@"001"];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.text = @"小明";
    _nameLabel.font = [UIFont systemFontOfSize:14];

    [contentView sd_addSubviews:@[_imageView,_nameLabel]];
    
    //设置约束
    _imageView.sd_layout.topSpaceToView(contentView,5).centerXEqualToView(contentView).widthIs(contentView.bounds.size.width - 10).heightIs(contentView.bounds.size.width - 10);
    
    _nameLabel.sd_layout.topSpaceToView(_imageView,5).centerXEqualToView(contentView).heightIs(20);
    [_nameLabel setSingleLineAutoResizeWithMaxWidth:80];
    
}

//设置老师的数据
- (void)setTeacherListModel:(TeacherListModel *)teacherListModel {
    _teacherListModel = teacherListModel;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:teacherListModel.headimg]];
    self.nameLabel.text = teacherListModel.realname;

}

//设置学生的数据
- (void)setClassmateListModel:(ClassmateListModel *)classmateListModel {
    _classmateListModel = classmateListModel;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:classmateListModel.studentheadimg]];
    
    self.nameLabel.text = classmateListModel.studentname;
}
@end
