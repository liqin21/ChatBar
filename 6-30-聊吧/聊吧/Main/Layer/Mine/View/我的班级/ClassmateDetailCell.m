//
//  ClassmateDetailCell.m
//  聊吧
//
//  Created by m on 16/6/22.
//  Copyright © 2016年 m. All rights reserved.
//

#import "ClassmateDetailCell.h"

@implementation ClassmateDetailCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.text = @"孩子的学校:";
        _leftLabel.textColor = [UIColor blackColor];
        [_leftLabel setSingleLineAutoResizeWithMaxWidth:100];
        
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.text = @"麓谷中心小学";
        _rightLabel.textColor = [UIColor blackColor];
        _rightLabel.numberOfLines = 0;
        
        [self.contentView sd_addSubviews:@[_leftLabel,_rightLabel]];
        
        //设置约束
        _leftLabel.sd_layout.leftSpaceToView(self.contentView,10).topSpaceToView(self.contentView,12).heightIs(15);
        
        _rightLabel.sd_layout.leftSpaceToView(_leftLabel,5).rightSpaceToView(self.contentView,10).topSpaceToView(self.contentView,12).autoHeightRatio(0);
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

@end
