//
//  TranslucentView.m
//  家校通
//
//  Created by m on 16/6/10.
//  Copyright © 2016年 m. All rights reserved.
//

#import "TranslucentView.h"

@implementation TranslucentView {
    
}

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTranslucentViewAction:)];
    [self addGestureRecognizer:tap];
    
    self.hidden = YES;
    self.backgroundColor = RGB(48, 53, 60, 0.7);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    //选择照片提示视图
    [self createSelectPhotoView];
    
    
    //设置性别提示视图
    [self creatSetSexBgView];
    
    

}

#pragma mark - 选择照片提示视图
- (void)createSelectPhotoView {
    
    //创建3个button
    //背景图
    _selectBgView = [[UIView alloc] init];
    [self addSubview:_selectBgView];
    
    _selectBgView.sd_layout.leftSpaceToView(self,10).rightSpaceToView(self,10).bottomEqualToView(self).heightIs(250);
    _selectBgView.hidden = YES;
    
    //从手机中选照片或者拍照的背景图
    UIView *bgview = [[UIView alloc] init];
    bgview.layer.cornerRadius = 5;
    bgview.layer.masksToBounds = YES;
    
    //从手机中选照片
    UIButton *selcetButton = [self creatButtonWithTitle:@"从手机选择照片" target:self selector:@selector(clickButtonAction:) tag:10];
    
    //拍照
    UIButton *photoButton = [self creatButtonWithTitle: @"拍照片"target:self selector:@selector(clickButtonAction:) tag:20];
    
    [bgview sd_addSubviews:@[selcetButton,photoButton]];
    
    //取消
    UIButton *cancelButton = [self creatButtonWithTitle:@"取消" target:self selector:@selector(clickButtonAction:) tag:30];
    cancelButton.layer.cornerRadius = 5;
    
    [_selectBgView sd_addSubviews:@[bgview,cancelButton]];
    
    
    //设置约束
    bgview.sd_layout.leftEqualToView(_selectBgView).rightEqualToView(_selectBgView).topEqualToView(_selectBgView).heightIs(141);
    
    selcetButton.sd_layout.leftEqualToView(bgview).rightEqualToView(bgview).topEqualToView(bgview).heightIs(70);
    
    photoButton.sd_layout.leftEqualToView(bgview).rightEqualToView(bgview).topSpaceToView(selcetButton,1).heightIs(70);
    
    cancelButton.sd_layout.leftEqualToView(_selectBgView).rightEqualToView(_selectBgView).bottomSpaceToView(_selectBgView,35).heightIs(50);
    
}

#pragma mark - 设置性别提示视图
- (void)creatSetSexBgView {

    //背景图
    _sexBgView = [[UIView alloc] init];
    _sexBgView.hidden = YES;
    _sexBgView.backgroundColor = RGB(228, 228, 228, 1);
    
    [self addSubview:_sexBgView];
    
    _sexBgView.sd_layout.leftEqualToView(self).rightEqualToView(self).bottomEqualToView(self).heightIs(250);
    
    //1完成按钮
    UIButton * trueButton = [self creatButtonWithTitle:@"完成" target:self selector:@selector(clickButtonAction:) tag:110];
    trueButton.backgroundColor = RGB(237, 237, 237, 1);
    trueButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    trueButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
    [trueButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
    //2.男
    UIButton * maleButton = [self creatButtonWithTitle:@"男" target:self selector:@selector(clickButtonAction:) tag:120];
    [maleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    maleButton.backgroundColor = RGB(237, 237, 237, 1);
    
    //3.女
    UIButton * femaleButton = [self creatButtonWithTitle:@"女" target:self selector:@selector(clickButtonAction:) tag:130];
    
    
    UIButton *emptyButton = [self creatButtonWithTitle:@"" target:nil selector:nil tag:1];
    emptyButton.backgroundColor = RGB(237, 237, 237, 1);

    
    [_sexBgView sd_addSubviews:@[trueButton,maleButton,femaleButton,emptyButton]];
    
    //设置约束
    trueButton.sd_layout.leftEqualToView(_sexBgView).rightEqualToView(_sexBgView).topEqualToView(_sexBgView).heightIs(62);
    
    maleButton.sd_layout.leftEqualToView(_sexBgView).rightEqualToView(_sexBgView).topSpaceToView(trueButton,1).heightIs(62);
    
    femaleButton.sd_layout.leftEqualToView(_sexBgView).rightEqualToView(_sexBgView).topSpaceToView(maleButton,1).heightIs(62);
    
    emptyButton.sd_layout.leftEqualToView(_sexBgView).rightEqualToView(_sexBgView).topSpaceToView(femaleButton,1).heightIs(62);
    
    
}

- (UIButton *)creatButtonWithTitle:(NSString *)title target:(id)target selector:(SEL)sel tag:(NSInteger)i {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.backgroundColor = [UIColor whiteColor];
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    button.tag = i;
    [button setTitleColor:RGB(51, 149, 39, 1) forState:UIControlStateNormal];
    
    return button;
}

- (void)clickButtonAction:(UIButton *)button {
    if (button.tag == 10) {
        NSLog(@"从手机选择照片");
    }
    else if (button.tag == 20) {
        NSLog(@"拍照片");
    }
    else if (button.tag == 30) {
        NSLog(@"取消");
    }
    else if (button.tag == 110) {
        NSLog(@"完成");
    }
    else if (button.tag == 120) {
        NSLog(@"男");
        if (_maleBlock) {
            _maleBlock();
        }
    }
    else if (button.tag == 130) {
        NSLog(@"女");
        if (_femaleBlock) {
            _femaleBlock();
        }
    }
    self.hidden = YES;
    _selectBgView.hidden = YES;
    _sexBgView.hidden = YES;
}

#pragma mark - 自身的点击点击事件
- (void)clickTranslucentViewAction:(UITapGestureRecognizer *)tap {
    self.hidden = YES;
    _selectBgView.hidden = YES;
    _sexBgView.hidden = YES;
    
}



@end
