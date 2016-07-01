//
//  DetailedView.m
//  家校通
//
//  Created by m on 16/6/7.
//  Copyright © 2016年 m. All rights reserved.
//

#import "DetailedView.h"

@implementation DetailedView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDetailedView];
    }
    return self;
}

- (void)setupDetailedView {
    //左上角头像
    _iconImage = [[UIImageView alloc] init];
    _iconImage.image = [UIImage imageNamed:@"001"];
    
    //姓名
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.text = @"李雪梅";
    _nameLabel.font = [UIFont systemFontOfSize:16];
    _nameLabel.textColor = [UIColor whiteColor];
    
    _parentLabel = [[UILabel alloc] init];
    _parentLabel.text = @"张黎黎的妈妈";
    _parentLabel.textColor = [UIColor whiteColor];
    _parentLabel.font = [UIFont systemFontOfSize:12];
    
    //班级说明
    //左分隔线
    UIView *sepView1 = [[UIView alloc] init];
    sepView1.backgroundColor = RGB(60, 67, 79, 1);
    
    //右分隔线
    UIView *sepView2 = [[UIView alloc] init];
    sepView2.backgroundColor = RGB(60, 67, 79, 1);

    //孩子的班级
    UILabel *classLabel = [[UILabel alloc] init];
    classLabel.text = @"孩子的班级";
    classLabel.font = [UIFont systemFontOfSize:14];
    classLabel.textColor = [UIColor whiteColor];
    
    //班级按钮
    CGFloat W = self.bounds.size.width - 15 - 30;
    CGFloat H = 40;
    
    for (int i = 0; i < 3; i ++) {
        
        _classControl = [[UIControl alloc] initWithFrame:CGRectMake(15,170 + i * (H + 10), W, H)];
        _classControl.tag = i;
        [_classControl addTarget:self action:@selector(classControlAction:) forControlEvents:UIControlEventTouchUpInside];
        _classControl.backgroundColor = RGB(56, 216, 11, 1);
        _classControl.layer.cornerRadius = 5;
        _classControl.layer.masksToBounds = YES;
        
        [self addSubview:_classControl];
        //标题
        _classLabel = [[UILabel alloc] init];
        _classLabel.tag = i + 10;
        _classLabel.text = @"五年级四班";
        _classLabel.font = [UIFont systemFontOfSize:14];
        _classLabel.textColor = [UIColor whiteColor];
        
        //箭头
        UIImageView *arrowImage = [[UIImageView alloc] init];
        arrowImage.image = [UIImage imageNamed:@"箭头"];
        
        [_classControl sd_addSubviews:@[_classLabel,arrowImage]];
        
        //设置约束
        _classLabel.sd_layout.centerXEqualToView(_classControl).centerYEqualToView(_classControl).heightIs(30).widthIs(100);
        arrowImage.sd_layout.rightSpaceToView(_classControl,20).centerYEqualToView(_classControl).heightIs(15).widthIs(10);
    }
    
    [self sd_addSubviews:@[_iconImage,_nameLabel,_parentLabel,sepView1,sepView2,classLabel]];
    
    //设置约束
    _iconImage.sd_layout.topSpaceToView(self,20).leftSpaceToView(self,15).heightIs(70).widthIs(70);
    
    _nameLabel.sd_layout.leftSpaceToView(_iconImage,10).topSpaceToView(self,30).heightIs(30);
    [_nameLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    _parentLabel.sd_layout.leftEqualToView(_nameLabel).topSpaceToView(_nameLabel,0).heightIs(20);
    [_parentLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    classLabel.sd_layout.centerXEqualToView(self).heightIs(20).topSpaceToView(_iconImage,30);
    [classLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    sepView1.sd_layout.leftSpaceToView(self,15).rightSpaceToView(classLabel,5).centerYEqualToView(classLabel).heightIs(1);
    
    sepView2.sd_layout.leftSpaceToView(classLabel,5).rightSpaceToView(self,15).centerYEqualToView(classLabel).heightIs(1);
    
}

#pragma mark - 班级按钮点击事件
- (void)classControlAction:(UIControl *)sender {

    if (sender.tag == 0) {
        NSLog(@"导航到五年级四班中去");
    }
    else if (sender.tag == 1) {
        NSLog(@"导航到五年级三班中去");
    }
    else {
        NSLog(@"导航到五年级二班中去");
    }
}


//- (void)setShow:(BOOL)show {
//    _show = show;
//    if (!show) {
//        //清除自动宽度设置,固定宽度设置为0
//        [self clearAutoHeigtSettings];
//        self.fixedWidth = @(0);
//    }
//    else {
//        self.fixedWidth = nil;
//        [self setupAutoWidthWithRightView:_classControl rightMargin:30];
//    }
//    
//}

@end
