//
//  FriendsCircleCell.h
//  聊吧
//
//  Created by m on 16/5/25.
//  Copyright © 2016年 m. All rights reserved.
//

#import <UIKit/UIKit.h>

//点赞和评论按钮的代理方法
@protocol FriendsCircleCellDelegate <NSObject>

- (void)didClickLikeButtonInCell:(UITableViewCell *)cell;

- (void)didClickCommentButtonInCell:(UITableViewCell *)cell;

@end

@class FCOprationMenuView;

@class FriendsCircleModel;

@interface FriendsCircleCell : UITableViewCell<UITextFieldDelegate>
{
    UIImageView *headImg;
    
    UILabel *nameLabel;
    
    UILabel *contentLabel;
    
    UIButton *imgButton;
    
    UILabel *timeLabel;
    
    UIButton *menuButton;   //评论、点赞的菜单按钮
    
    UIButton *likeButton;  //点赞按钮
    
    UIImageView *likeImage;      //点赞按钮上的图片
    
    UIButton *commentButton;    //评论按钮
    
}

@property (nonatomic,copy) FriendsCircleModel *friendsCircleModel;

//评论、点赞按钮的菜单
@property (nonatomic,copy) FCOprationMenuView *menuView;

@property (nonatomic,weak) id<FriendsCircleCellDelegate> delegate;

@end
