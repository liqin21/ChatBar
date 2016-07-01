//
//  FCHeadView.h
//  聊吧
//
//  Created by m on 16/5/28.
//  Copyright © 2016年 m. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FCHeadModel;

@interface FCHeadView : UIView

@property (nonatomic,copy) UIImageView *bgImageView;

@property (nonatomic,copy) UIImageView *headImageView;

@property (nonatomic,copy) UILabel *nameLabel;

@property (nonatomic,copy) FCHeadModel *headViewModel;

@end
