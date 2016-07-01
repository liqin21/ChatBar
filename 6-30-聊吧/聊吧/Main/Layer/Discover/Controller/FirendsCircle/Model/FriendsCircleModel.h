//
//  FriendsCircleModel.h
//  聊吧
//
//  Created by m on 16/5/25.
//  Copyright © 2016年 m. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendsCircleModel : NSObject

@property (nonatomic,copy) NSString *iconName;      //头像名字

@property (nonatomic,copy) NSString *name;          //昵称

@property (nonatomic,copy) NSString *content;       //内容

@property (nonatomic,copy) NSArray *pictureArray;       //图片数组

@property (nonatomic,assign,getter = isLiked) BOOL liked;

//存放评论数组
@property (nonatomic,copy) NSArray *commentItemsArray;

//存放点赞数据
@property (nonatomic,copy) NSMutableArray *likeItemsArray;

@end


#pragma mark - 评论数据Model
@interface FCCellCommentItemModel : NSObject

//评论内容
@property (nonatomic,copy) NSString *commentString;

//第一个评论人
@property (nonatomic,copy) NSString *firstUserName;

//第一个评论人的ID
@property (nonatomic,copy) NSString *firstUsrID;

//第二个评论人
@property (nonatomic,copy) NSString *secondUserName;

//第二个评论人的ID
@property (nonatomic,copy) NSString *secondUsrID;


@end


#pragma mark - 点赞Model
@interface FCCellLikeItemModel : NSObject

//点赞人的名字
@property (nonatomic,copy) NSString *userName;

//点赞人的ID
@property (nonatomic,copy) NSString *userID;

@end




