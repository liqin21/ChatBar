//
//  ResCommentModel.h
//  聊吧
//
//  Created by m on 16/6/29.
//  Copyright © 2016年 m. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResCommentModel : NSObject

/*
 {
 comment =     (
 {
 commentData =
 {
 CommentContent = 0;
 CommentId = 3236;
 CommentParentId = 0;
 CommentTime = "2016-06-15 23:54:25";
 CommentType = "<null>";
 HeadImage = "http://www.k12chn.com/uploads/face/HeadImg20160629/faces201606291452173876.0";
 Id = 78;
 RealName = "\U79b9\U5b66\U4e30";
 ReplyBadCount = 0;
 ReplyGoodCount = 0;
 ReplyTextCount = 0;
 ReplyType = "<null>";
 ResourceId = 0;
 UserName = yuxuefeng;
 };
 replyData = 0;
 }
 );
 totalCount = 1;
 }
 */

@property (nonatomic,copy) NSString *CommentContent;

@property (nonatomic,copy) NSString *CommentId;

@property (nonatomic,copy) NSString *CommentTime;

@property (nonatomic,copy) NSString *RealName;

@property (nonatomic,copy) NSString *Id;

@property (nonatomic,copy) NSString *CommentParentId;

@property (nonatomic,copy) NSIndexPath* indexPath;



@end
