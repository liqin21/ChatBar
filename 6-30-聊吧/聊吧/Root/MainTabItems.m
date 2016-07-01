//
//  MainTabItems.m
//  聊吧
//
//  Created by m on 16/6/19.
//  Copyright © 2016年 m. All rights reserved.
//

#import "MainTabItems.h"

@implementation MainTabItems {
    
    UIImageView *imgView;
    UILabel *titleLabel;
    
    NSString *_normalImageName;         //未选中状态下的图片
    NSString *_selectedImageName;       //选中状态下的图片
    
    UIColor *_normalFontColor;          //未选中状态下的标题颜色
    UIColor *_selectedFontColor;        //选中状态下的标题颜色
}

- (id)initWithFrame:(CGRect)frame
    normalImageName:(NSString *)normalImageName
  selectedImageNemd:(NSString *)selectedImageName
    normalFontColor:(UIColor *)normalFontColor
  selectedFontColor:(UIColor *)selectedFontColor
              title:(NSString *)title
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _normalImageName = normalImageName;
        _selectedImageName = selectedImageName;
        
        _normalFontColor = normalFontColor;
        _selectedFontColor = selectedFontColor;
        
        // 设置背景图片
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width-27)/2, 5, 27, 23)];
        // 设置图片模式
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.image = [UIImage imageNamed:normalImageName];
        [self addSubview:imgView];
        
        //设置title
        CGFloat imageViewBottom = CGRectGetMaxY(imgView.frame);
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, imageViewBottom, CGRectGetWidth(self.frame), 20)];
        titleLabel.text = title;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:17];
        titleLabel.textColor = normalFontColor;
        [self addSubview:titleLabel];
    }
    return self;
}

// 设置选中状态和非选中状态
- (void)setIsSelected:(BOOL) selected
{
    if (selected) { // 设置选中效果
        imgView.image = [UIImage imageNamed:_selectedImageName];
        titleLabel.textColor = _selectedFontColor;
    }
    else { // 设置未选中状态下的效果
        imgView.image = [UIImage imageNamed:_normalImageName];
        titleLabel.textColor = _normalFontColor;
    }
    
}


@end
