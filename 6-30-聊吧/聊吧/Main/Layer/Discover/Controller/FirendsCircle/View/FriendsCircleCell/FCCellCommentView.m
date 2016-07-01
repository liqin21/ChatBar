//
//  FCCellCommentView.m
//  聊吧
//
//  Created by m on 16/6/4.
//  Copyright © 2016年 m. All rights reserved.
//

#import "FCCellCommentView.h"
#import "FriendsCircleModel.h"

@interface FCCellCommentView ()

@property (nonatomic,strong) NSArray *commentItemsArray;

@property (nonatomic,strong) NSMutableArray *commentLabelsArray;

@property (nonatomic,strong) NSArray *likeItemsArray;

@property (nonatomic,strong) NSMutableArray *likeLabelArray;


@end


@implementation FCCellCommentView {
    UIImageView *bgImageView;
    UILabel *likeLabel;
    UIView *boundaryView;
//    UILabel *commentLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatCommentView];
    }
    return self;
}

- (void)creatCommentView {
    //1.背景视图
    bgImageView = [[UIImageView alloc] init];
    UIImage *image = [[UIImage imageNamed:@"LikeCmtBg"] stretchableImageWithLeftCapWidth:40 topCapHeight:30];   
    bgImageView.image = image;
    [self addSubview:bgImageView];
    
    //2.显示点赞的Label
    likeLabel = [[UILabel alloc] init];
    likeLabel.font = [UIFont systemFontOfSize:14];
//    likeLabel.text = @"赞，超赞";
    likeLabel.textColor =  [UIColor colorWithRed:92/255.0 green:140/255.0 blue:193/255.0 alpha:1.0];
    [self addSubview:likeLabel];
    
    //3.分界线
    boundaryView = [[UIView alloc] init];
    boundaryView.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.2];
    [self addSubview:boundaryView];
    
    
    //约束
    bgImageView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
}

#pragma mark - 设置数据
- (void)setupWithLikeItemsArray:(NSArray *) likeItemsArray commentItemArray:(NSArray *)commentItemsArray {
    //设置数据
    self.commentItemsArray = commentItemsArray;
    self.likeItemsArray = likeItemsArray;
    
    //设置约束
    if (self.commentLabelsArray.count) {
        [self.commentLabelsArray enumerateObjectsUsingBlock:^(UILabel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //清除原有的约束
            [obj sd_clearAutoLayoutSettings];
            obj.hidden = YES;
        }];
    }
    
    UIView *lastTopView = nil;
    
    //重新设置likeLabel的约束
    if (likeItemsArray.count) {
        likeLabel.sd_layout.leftSpaceToView(self,5).rightSpaceToView(self,5).topSpaceToView(self,10).autoHeightRatio(0);
        lastTopView = likeLabel;
    }
    else {
        likeLabel.sd_resetLayout.heightIs(0);
    }
    
    //分割线
    if (likeItemsArray.count && commentItemsArray.count) {
        boundaryView.sd_resetLayout.leftEqualToView(self).rightEqualToView(self).heightIs(1).topSpaceToView(likeLabel,5);
    }
    else {
        boundaryView.sd_resetLayout.heightIs(0);
    }
    
    //设置评论Label的约束
    for (int i = 0; i < self.commentItemsArray.count; i ++) {
        UILabel *commentLabel = (UILabel *)self.commentLabelsArray[i];
        commentLabel.hidden = NO;
        CGFloat topMargin = (i == 0 && likeItemsArray.count == 0) ? 10 : 5;
        if (i == 0 && likeItemsArray.count != 0) {
           commentLabel.sd_layout.leftSpaceToView(self,8).rightSpaceToView(self,5).topSpaceToView(lastTopView,10).autoHeightRatio(0);
        }
        else {
        commentLabel.sd_layout.leftSpaceToView(self,8).rightSpaceToView(self,5).topSpaceToView(lastTopView,topMargin).autoHeightRatio(0);
        }
        lastTopView = commentLabel;
    }
    //设置底边
    [self setupAutoHeightWithBottomView:lastTopView bottomMargin:6];
    
}

#pragma mark - 创建评论Label
//当执行self.commentItemsArray就调用该方法
- (void)setCommentItemsArray:(NSArray *)commentItemsArray {
    _commentItemsArray = commentItemsArray;
    //计算原来的Label的数量
    long originalLabelCount = self.commentLabelsArray.count;
    
    //计算需要创建的Label的数量
    long needsToAddCount = commentItemsArray.count > originalLabelCount ? (commentItemsArray.count - originalLabelCount) : 0;
    
    for (int i = 0; i < needsToAddCount; i ++) {
        
        UILabel *commentLabel = [[UILabel alloc] init];
        commentLabel.font = [UIFont systemFontOfSize:14];
        commentLabel.tag = i;
        [self addSubview:commentLabel];
        
        //添加到数组中
        [self.commentLabelsArray addObject:commentLabel];
    }
    //设置值
    for (int i = 0; i < commentItemsArray.count; i ++) {
        FCCellCommentItemModel *commentModel = commentItemsArray[i];
        UILabel *commentLabel = self.commentLabelsArray[i];
        
//        commentLabel.text = [NSString stringWithFormat:@"%@:%@",commentModel.firstUserName,commentModel.commentString];
        commentLabel.attributedText = [self generateAttributedStringWithCommentItemModel:commentModel];
    }
}

//设置评论中名字的颜色和评论内容
- (NSMutableAttributedString *)generateAttributedStringWithCommentItemModel:(FCCellCommentItemModel *)model
{
    NSString *text = model.firstUserName;
//    if(model.secondUserName.length) {
//        text = [text stringByAppendingString:[NSString stringWithFormat:@"回复%@", model.secondUserName]];
//    }
    text = [text stringByAppendingString:[NSString stringWithFormat:@"：%@", model.commentString]];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text];
//    UIColor *color = [UIColor colorWithRed:92/255.0 green:140/255.0 blue:193/255.0 alpha:1.0];
    
#pragma mark -修改颜色没看出效果
    
    [attString setAttributes:@{NSForegroundColorAttributeName :[UIColor redColor], NSLinkAttributeName : model.firstUsrID} range:[text rangeOfString:model.firstUserName]];
    
//    if (model.secondUserName) {
//        [attString setAttributes:@{NSLinkAttributeName : model.secondUsrID} range:[text rangeOfString:model.secondUserName]];
//    }
    return attString;
}


#pragma mark - 创建点赞Label
- (void)setLikeItemsArray:(NSArray *)likeItemsArray {
    _likeItemsArray = likeItemsArray;
    
    //文本附件
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.image = [UIImage imageNamed:@"Like"];
    attach.bounds = CGRectMake(0, -3, 16, 16);
    NSAttributedString *likeIcon = [NSAttributedString attributedStringWithAttachment:attach];

    //可变属性字符串
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:likeIcon];
    
    for (int i = 0; i < likeItemsArray.count; i ++) {
        FCCellLikeItemModel *likeModel = likeItemsArray[i];
        
        if (i > 0) {
            [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@", "]];
        }

            [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:likeModel.userName]];

    }
    likeLabel.attributedText = [attributedText copy];
}

#pragma mark - commentLabelsArray
- (NSMutableArray *)commentLabelsArray {
    if (!_commentLabelsArray) {
        _commentLabelsArray = [NSMutableArray array];
    }
    return _commentLabelsArray;
}

@end
