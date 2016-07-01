//
//  MessageCell.h
//  聊吧
//
//  Created by m on 16/5/23.
//  Copyright (c) 2016年 m. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MessageModel;

@interface MessageCell : UITableViewCell {
    //头像
    UIImageView *useImg;
    
    //显示名字
    UILabel *nameLabel;
    
    //显示时间
    UILabel *timeLabel;
    
    //显示内容
    UILabel *contentLabel;
    
    //显示信息数量
    UILabel *countLabel;
    
}


@property (nonatomic,copy) MessageModel *msgModel;

@end
