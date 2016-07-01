//
//  ClassmateDetailCell.h
//  聊吧
//
//  Created by m on 16/6/22.
//  Copyright © 2016年 m. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ClassmateDetailModel;

@interface ClassmateDetailCell : UITableViewCell

@property (nonatomic,strong) UILabel *leftLabel;

@property (nonatomic,strong) UILabel *rightLabel;

@property (nonatomic,copy) ClassmateDetailModel *model;


@end
