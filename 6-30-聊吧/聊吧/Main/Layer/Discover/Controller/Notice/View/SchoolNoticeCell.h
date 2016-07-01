//
//  SchoolNoticeCell.h
//  聊吧
//
//  Created by m on 16/6/14.
//  Copyright © 2016年 m. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SchoolNoticeModel;

@interface SchoolNoticeCell : UITableViewCell

//标题
@property (nonatomic,copy) UILabel *titleLabel;

//时间
@property (nonatomic,copy) UILabel *timeLabel;

//内容
@property (nonatomic,copy) UILabel *contentLabel;


@property (nonatomic,copy) SchoolNoticeModel *model;


@end
