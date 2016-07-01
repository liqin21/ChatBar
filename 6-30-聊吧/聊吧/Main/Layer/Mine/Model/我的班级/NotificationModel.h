//
//  NotificationModel.h
//  聊吧
//
//  Created by m on 16/6/24.
//  Copyright © 2016年 m. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationModel : NSObject
/**
 *  (
 {
 content = "\U53d1\U901a\U77e5\U5566\U53d1\U901a\U77e5\U5566\U6d4b\U8bd5";
 id = 68;
 time = "2016-06-22 09:45:47";
 title = "\U53d1\U901a\U77e5\U5566";
 url = "http://www.k12chn.com/m17/ClassNotice/NoticeDetail/noticeid/68";
 }
 )
 */

//@property (nonatomic,copy)

@property (nonatomic,copy) NSString *content;

@property (nonatomic,copy) NSString *notificationID;

@property (nonatomic,copy) NSString *time;

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *url;



@end
