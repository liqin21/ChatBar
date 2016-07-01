//
//  FriendsCirCleController.h
//  聊吧
//
//  Created by m on 16/5/25.
//  Copyright © 2016年 m. All rights reserved.
//

#import "BaseViewController.h"

#define kFriendsCircleCellID @"friendsCircleCell"

//评论按钮通知
#define kCommentButtonClickNotification @"commentButtonClickNotification"

//点赞按钮
#define kLikeButtonClickNotification @"likeButtonClickNotification"

//取消点赞
#define kCancelLikeNotification @"cancelLikeNotification"


@interface FriendsCirCleController : BaseViewController <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic,copy) UIView *headerView;

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) NSIndexPath *currentEditingIndexthPath;

//更换背景图片提示按钮
@property (nonatomic,copy) UIButton *cueButton;

//覆盖全屏的半透明视图
@property (nonatomic,copy) UIImageView *translucentView;


@end
