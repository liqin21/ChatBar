//
//  ListCollectionCell.h
//  聊吧
//
//  Created by m on 16/6/20.
//  Copyright © 2016年 m. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TeacherListModel;
@class ClassmateListModel;

@interface ListCollectionCell : UICollectionViewCell
//头像
@property (nonatomic,strong) UIImageView *imageView;
//名字
@property (nonatomic,copy) UILabel *nameLabel;

//老师列表数据模型
@property (nonatomic,strong) TeacherListModel *teacherListModel;

//同学列表数据模型
@property (nonatomic,strong) ClassmateListModel *classmateListModel;


@end
