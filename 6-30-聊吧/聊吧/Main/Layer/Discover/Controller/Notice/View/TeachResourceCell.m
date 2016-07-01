//
//  TeachResourceCell.m
//  聊吧
//
//  Created by m on 16/6/27.
//  Copyright © 2016年 m. All rights reserved.
//

#import "TeachResourceCell.h"
#import "PublicResModel.h"

@implementation TeachResourceCell {
    UIImageView *leftImage;
    UILabel *titleLabel;
    UILabel *couseLabel;
    UILabel *gradeLabel;
    UILabel *authoLabel;
    UILabel *numberLabel;
    
    
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setup {
    UIView *contentView = self.contentView;
    //左边图片
    leftImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"doc_ico"]];
    
    
    //标题
    titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"国学大讲堂";
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = [UIColor blackColor];
    
    //科目
    couseLabel = [[UILabel alloc] init];
    couseLabel.text = [NSString stringWithFormat:@"科目:%@",@"语文"];
    couseLabel.font = [UIFont systemFontOfSize:12];
    couseLabel.textColor = [UIColor blackColor];
    
    //年级
    gradeLabel = [[UILabel alloc] init];
    gradeLabel.text = [NSString stringWithFormat:@"年级:%@",@"六年级"];
    gradeLabel.font = [UIFont systemFontOfSize:12];
    gradeLabel.textColor = [UIColor blackColor];
    
    //作者
    authoLabel = [[UILabel alloc] init];
    authoLabel.text = [NSString stringWithFormat:@"作者:%@",@"林语堂"];
    authoLabel.font = [UIFont systemFontOfSize:12];
    authoLabel.textColor = [UIColor blackColor];
    
    //积分
    numberLabel = [[UILabel alloc] init];
    numberLabel.text = [NSString stringWithFormat:@"积分:%@",@"5"];
    numberLabel.font = [UIFont systemFontOfSize:12];
    numberLabel.textColor = [UIColor blackColor];
    
    [contentView sd_addSubviews:@[leftImage,titleLabel,couseLabel,gradeLabel,authoLabel,numberLabel]];
    
    //设置约束
    leftImage.sd_layout.leftSpaceToView(contentView,10).topSpaceToView(contentView,15).heightIs(23).widthIs(23);
    
    titleLabel.sd_layout.leftSpaceToView(leftImage,3).topEqualToView(leftImage).heightIs(20);
    [titleLabel setSingleLineAutoResizeWithMaxWidth:contentView.bounds.size.width];
    
    couseLabel.sd_layout.leftEqualToView(titleLabel).topSpaceToView(titleLabel,10).heightIs(15);
    [couseLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    numberLabel.sd_layout.rightSpaceToView(contentView,10).topEqualToView(couseLabel).heightIs(15);
    [numberLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    authoLabel.sd_layout.rightSpaceToView(numberLabel,10).topEqualToView(couseLabel).heightIs(15);
    [authoLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    gradeLabel.sd_layout.rightSpaceToView(authoLabel,10).topEqualToView(couseLabel).heightIs(15);
    [gradeLabel setSingleLineAutoResizeWithMaxWidth:100];
    
}

//设置数据
- (void)setPublicResModel:(PublicResModel *)publicResModel {
    _publicResModel = publicResModel;
    
    titleLabel.text = publicResModel.Title;
    couseLabel.text = [NSString stringWithFormat:@"科目:%@",publicResModel.CourseName];
    authoLabel.text = [NSString stringWithFormat:@"作者:%@",publicResModel.UserName];
    gradeLabel.text = [NSString stringWithFormat:@"年级:%@",publicResModel.PhaseName];
    numberLabel.text = [NSString stringWithFormat:@"积分:%@",publicResModel.Price];
    if ([publicResModel.ResourceType isEqualToString:@"1"]) {
        leftImage.image = [UIImage imageNamed:@"mp4_ico"];
    }
    else if ([publicResModel.ResourceType isEqualToString:@"3"]) {
        leftImage.image = [UIImage imageNamed:@"doc_ico"];
    }
    else if ([publicResModel.ResourceType isEqualToString:@"4"]) {
        leftImage.image = [UIImage imageNamed:@"mp3_ico"];
    }
    else if ([publicResModel.ResourceType isEqualToString:@"5"]) {
        leftImage.image = [UIImage imageNamed:@"ppt_ico"];
    }
    else if ([publicResModel.ResourceType isEqualToString:@"6"]) {
        leftImage.image = [UIImage imageNamed:@"tex_ico"];
    }
    
}

@end
