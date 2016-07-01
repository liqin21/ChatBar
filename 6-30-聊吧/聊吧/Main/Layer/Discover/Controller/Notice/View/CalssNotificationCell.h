//
//  CalssNotificationCell.h
//  聊吧
//
//  Created by m on 16/6/25.
//  Copyright © 2016年 m. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ClassNoticeModel;

@interface CalssNotificationCell : UITableViewCell

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UILabel *contentLabel;

@property (nonatomic,strong) UILabel *timeLabel;

@property (nonatomic,copy) ClassNoticeModel *classNoticeModel;

@end
