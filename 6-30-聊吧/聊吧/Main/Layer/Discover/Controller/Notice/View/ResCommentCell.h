//
//  ResCommentCell.h
//  聊吧
//
//  Created by m on 16/6/28.
//  Copyright © 2016年 m. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ResCommentModel;

@interface ResCommentCell : UITableViewCell

//头像
@property (nonatomic,strong) UIImageView *headImg;

//名字
@property (nonatomic,strong) UILabel *nameLabel;

//时间
@property (nonatomic,strong) UILabel *timeLabel;

//内容
@property (nonatomic,strong) UILabel *contentLabel;

//排序
@property (nonatomic,strong) UILabel *sortLabel;

@property (nonatomic,strong) ResCommentModel *model;

@end
