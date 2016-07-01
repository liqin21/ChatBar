//
//  ClassTableViewCell.m
//  家校通
//
//  Created by m on 16/6/7.
//  Copyright © 2016年 m. All rights reserved.
//

#import "ClassTableViewCell.h"
#import "ClassmateDetailVC.h"
#import "MyClassModel.h"


@implementation ClassTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupClassCell];
    }
    return self;
}

- (void)setupClassCell {
    CGFloat width = [UIScreen mainScreen].bounds.size.width / 4.0;
    CGFloat height = width * 1.2;    
    
    //循环创建4个UIControl
    for (int i = 0; i < 4; i ++) {
        _control = [[UIControl alloc] initWithFrame:CGRectMake(i * width, 0, width, height)];
        _control.tag = i;
        [_control addTarget:self action:@selector(clickControlAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_control];
        
        //创建头像
        _iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, width - 20, height - 40)];
        _iconImage.tag = i + 10;
        _iconImage.image = [UIImage imageNamed:@"004"];
        
        [_control addSubview:_iconImage];
        
        //创建名字
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, height - 30, width - 20, 20)];
        _nameLabel.tag = i + 20;
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.text = @"张黎黎";
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [_control addSubview:_nameLabel];
        
    }

}

#pragma mark - 头像点击事件
- (void)clickControlAction:(UIControl *)sender {
    NSLog(@"点击了头像");
    if (_clickIconImageBlock) {
        _clickIconImageBlock();
    }
}





@end
