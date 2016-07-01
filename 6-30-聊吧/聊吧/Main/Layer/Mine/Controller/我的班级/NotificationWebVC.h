//
//  NotificationWebVC.h
//  聊吧
//
//  Created by m on 16/6/24.
//  Copyright © 2016年 m. All rights reserved.
//

#import "BaseViewController.h"

@interface NotificationWebVC : BaseViewController
/*
(
 {
 content = "\U53d1\U901a\U77e5\U5566\U53d1\U901a\U77e5\U5566\U6d4b\U8bd5";
 id = 68;
 time = "2016-06-22 09:45:47";
 title = "\U53d1\U901a\U77e5\U5566";
 url = "http://www.k12chn.com/m17/ClassNotice/NoticeDetail/noticeid/68";
 }
 )

 */

//H5请求地址
@property (nonatomic,copy) NSString *htmlID;

@property (nonatomic,copy) NSString *htmlString;


//网络请求地址
@property (nonatomic,copy) NSString *urlString;

@property (nonatomic,copy) NSString *body;

@end
