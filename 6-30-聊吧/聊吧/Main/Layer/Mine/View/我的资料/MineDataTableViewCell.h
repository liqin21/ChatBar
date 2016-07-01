//
//  MineDataTableViewCell.h
//  家校通
//
//  Created by m on 16/6/8.
//  Copyright © 2016年 m. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MineDataModel;

@interface MineDataTableViewCell : UITableViewCell

//1.左边图案
@property (nonatomic,copy) UIImageView *leftImage;

//2.标题
@property (nonatomic,copy) UILabel *titleLabel;

//3.右边箭头

//4.显示内容的Label
@property (nonatomic,copy) UILabel *contentLabel;

@property (nonatomic,copy) MineDataModel *model;

@end
