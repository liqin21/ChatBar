//
//  ClassTableViewCell.h
//  家校通
//
//  Created by m on 16/6/7.
//  Copyright © 2016年 m. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyClassModel;

@interface ClassTableViewCell : UITableViewCell

@property (nonatomic,copy) UIImageView *iconImage;

@property (nonatomic,copy) UILabel *nameLabel;

@property (nonatomic,copy) UIControl *control;

@property (nonatomic,copy) void (^clickIconImageBlock)();
@property (nonatomic,strong) MyClassModel *myclassModel;

//@property (nonatomic,strong) 


@end
