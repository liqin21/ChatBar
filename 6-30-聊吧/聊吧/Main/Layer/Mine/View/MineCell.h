//
//  MineCell.h
//  聊吧
//
//  Created by m on 16/5/24.
//  Copyright © 2016年 m. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MineCell : UITableViewCell

//图片
@property (nonatomic,copy) UIImageView *imgView;

//标题
@property (nonatomic,copy) UILabel *titlelabel;

//信息数量
@property (nonatomic,copy) UILabel *countLabel;



@end
