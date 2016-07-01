//
//  NotificationCell.h
//  聊吧
//
//  Created by m on 16/6/24.
//  Copyright © 2016年 m. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NotificationModel;

@interface NotificationCell : UITableViewCell


@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UILabel *contentLabel;

@property (nonatomic,strong) UILabel *timeLabel;

@property (nonatomic,copy) NotificationModel *notificationModel;

@end
