//
//  FriendsCircleCell.m
//  聊吧
//
//  Created by m on 16/5/25.
//  Copyright © 2016年 m. All rights reserved.
//

#import "FriendsCircleCell.h"
#import "FriendsCircleModel.h"
#import "FCPhotoContainerView.h"
#import "FCOprationMenuView.h"
#import "FCCellCommentView.h"


@implementation FriendsCircleCell
{
    FCPhotoContainerView *photContainerView;
    FCCellCommentView *commentView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //自定义单元格
        [self _customCell];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

//自定义单元格
- (void)_customCell {
    UIView *contentView = self.contentView;
    CGFloat margin = 10;
    //1.左边头像
    headImg = [[UIImageView alloc] init];
    headImg.image = [UIImage imageNamed:@"002"];
    
    //2.好友昵称
    nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"锦和园ios团队";
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textColor = [UIColor colorWithRed:78/255.0 green:97/255.0 blue:142/255.0 alpha:0.9];
    
    //3.内容显示框
    contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines = 0;

    //4.照片
    photContainerView = [[FCPhotoContainerView alloc] init];
    
    //5.时间显示框
    timeLabel = [[UILabel alloc] init];
    timeLabel.text = @"35分钟前";
    timeLabel.font = [UIFont systemFontOfSize:15];
    timeLabel.textColor = [UIColor lightGrayColor];
    
    //6.点赞，评论的菜单按钮
    menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [menuButton setImage:[UIImage imageNamed:@"AlbumOperateMore"] forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(menuButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //7.点赞、评论菜单
    _menuView = [[FCOprationMenuView alloc] init];
    //避免造成死循环
    __weak typeof (self) weakSelf = self;
    //点赞事件
    _menuView.likeButtonBlock = ^(){
     //处理回调事件,先判断代理方法是否已实现，避免出现系统崩溃现象
        if ([weakSelf.delegate respondsToSelector:@selector(didClickLikeButtonInCell:)]) {
            [weakSelf.delegate didClickLikeButtonInCell:weakSelf];
        }
    };
    //评论事件
    _menuView.commentButtonBlock = ^() {
        //处理回调事件,先判断代理方法是否已实现，避免出现系统崩溃现象
        if ([weakSelf.delegate respondsToSelector:@selector(didClickCommentButtonInCell:)]) {
            [weakSelf.delegate didClickCommentButtonInCell:weakSelf];
        }
    };
    
    //评论和点赞的显示视图
    commentView = [[FCCellCommentView alloc] init];
    
    NSArray *views = @[headImg,nameLabel,contentLabel,photContainerView,timeLabel,menuButton,_menuView,commentView];
    [self.contentView sd_addSubviews:views];
    
    //设置约束
    headImg.sd_layout.leftSpaceToView(contentView,margin).topSpaceToView(contentView,margin).widthIs(40).heightIs(40);
    
    nameLabel.sd_layout.leftSpaceToView(headImg,margin).topEqualToView(headImg).heightIs(18);
    [nameLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    contentLabel.sd_layout.leftEqualToView(nameLabel).topSpaceToView(nameLabel,margin).rightSpaceToView(contentView,1.5 * margin).autoHeightRatio(0);
   
    photContainerView.sd_layout.leftEqualToView(contentLabel);
    
    [timeLabel setSingleLineAutoResizeWithMaxWidth:120];
    timeLabel.sd_layout.leftEqualToView(contentLabel).topSpaceToView(photContainerView,margin).heightIs(13).autoHeightRatio(0);

    menuButton.sd_layout.rightSpaceToView(contentView,2 * margin).centerYEqualToView(timeLabel).widthIs(25).heightIs(25);
    
    _menuView.sd_layout.rightSpaceToView(menuButton,5).centerYEqualToView(menuButton).widthIs(0).heightIs(36);
    
    commentView.sd_layout.leftEqualToView(contentLabel).rightSpaceToView(contentView,2 * margin).topSpaceToView(timeLabel,10);
    
}

#pragma mark - 设置内容
- (void)setFriendsCircleModel:(FriendsCircleModel *)friendsCircleModel {
    
    _friendsCircleModel = friendsCircleModel;
    headImg.image = [UIImage imageNamed:friendsCircleModel.iconName];
    nameLabel.text = friendsCircleModel.name;
    contentLabel.text = friendsCircleModel.content;
    contentLabel.sd_layout.maxHeightIs(MAXFLOAT);
    
    //设置图片数据
    photContainerView.picPathStringArray = friendsCircleModel.pictureArray;
    CGFloat photContainerTopMargin = 0;
    if (friendsCircleModel.pictureArray.count) {
        photContainerTopMargin = 10;
    }
    photContainerView.sd_layout.topSpaceToView(contentLabel,photContainerTopMargin);
    
    //设置评论数据
    [commentView setupWithLikeItemsArray:friendsCircleModel.likeItemsArray commentItemArray:friendsCircleModel.commentItemsArray];
    if (friendsCircleModel.commentItemsArray.count == 0 &&friendsCircleModel.likeItemsArray.count == 0) {
        commentView.fixedWidth = @0;
        commentView.fixedHeight = @0;
//        commentView.sd_layout.topSpaceToView(timeLabel,0);
    }
    else {
        commentView.fixedHeight = nil; //取消固定宽度约束
        commentView.fixedWidth = nil;   //取消固定高度约束
        commentView.sd_layout.topSpaceToView(timeLabel,10);
    }
    
    UIView *bottomView;
    bottomView = commentView;
    
    [self setupAutoHeightWithBottomView:bottomView bottomMargin:15];
}

#pragma mark - 评论、点赞菜单按钮点击事件
- (void)menuButtonAction:(UIButton *)button {
    //展开、收起菜单框
    _menuView.show = !_menuView.show;
}

#pragma mark - 复用单元格的时候，如果评论菜单是显示状态，就先把他设置成收起状态
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    if (_menuView.show) {
        _menuView.show = NO;
    }
}

#pragma mark - 屏幕触摸事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [super touchesBegan:touches withEvent:event];
    if (_menuView.show) {
        _menuView.show = NO;
    }
}



@end
