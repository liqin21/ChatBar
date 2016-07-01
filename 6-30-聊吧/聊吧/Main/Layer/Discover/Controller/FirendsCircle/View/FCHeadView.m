//
//  FCHeadView.m
//  聊吧
//
//  Created by m on 16/5/28.
//  Copyright © 2016年 m. All rights reserved.
//

#import "FCHeadView.h"
#import "FCHeadModel.h"

@implementation FCHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //创建头视图
        [self createTableViewHeadeView];
    }
    return self;
}

//创建表视图的头视图
- (void)createTableViewHeadeView {
    //背景图片
    _bgImageView = [[UIImageView alloc] init];
    _bgImageView.image = [UIImage imageNamed:@"0007.jpg"];

    [self addSubview:_bgImageView];
    _bgImageView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(-60, 0, 40, 0));
    
    //头像视图
    _headImageView = [[UIImageView alloc] init];
    _headImageView.image = [UIImage imageNamed:@"myself.jpg"];
    //添加点击事件方法
    _headImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headImageTapAction:)];
    [_headImageView addGestureRecognizer:tap2];
    [self addSubview:_headImageView];
    _headImageView.sd_layout.rightSpaceToView(self,15).bottomSpaceToView(self,15).widthIs(70).heightIs(70);
    _headImageView.layer.borderWidth = 4;
    _headImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    //昵称
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.text = @"琴哥";
    [self addSubview:_nameLabel];
    [_nameLabel setSingleLineAutoResizeWithMaxWidth:200];
    _nameLabel.sd_layout.rightSpaceToView(_headImageView,10).bottomSpaceToView(_headImageView,-40).heightIs(20);
}

//设置数据
- (void) setHeadViewModel:(FCHeadModel *)headViewModel {
    _headViewModel = headViewModel;
    _bgImageView.image = [UIImage imageNamed:headViewModel.bgImageName];
    _headImageView.image = [UIImage imageNamed:headViewModel.headImageName];
    _nameLabel.text = headViewModel.name;
    
}

#pragma mark - 背景视图点击事件方法

//头像视图点击事件
- (void)headImageTapAction:(UIGestureRecognizer *)tap {
    //进入自己的主页
    NSLog(@"计入自己的主页");
}


@end
