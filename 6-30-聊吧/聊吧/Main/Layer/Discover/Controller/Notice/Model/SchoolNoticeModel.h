//
//  SchoolNoticeModel.h
//  聊吧
//
//  Created by m on 16/6/14.
//  Copyright © 2016年 m. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SchoolNoticeModel : NSObject
/*
 (
 {
 content = "&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; oxyhydrogen\U597d &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;\U533f\U540d";
 id = 187;
 img = "";
 schoolid = 12;
 time = "2016-05-31 11:53:28";
 title = "5\U670831\U53f7\U516c\U544a2";
 url = "http://www.k12chn.com/m17/SchoolNotice/NoticeDetail/noticeid/187";
 },
 {
 content = "&nbsp; &nbsp; &nbsp; \U5f04\U5f04";
 id = 186;
 img = "";
 schoolid = 12;
 time = "2016-05-31 11:29:37";
 title = "5\U670831\U5b66\U6821\U516c\U544a1";
 url = "http://www.k12chn.com/m17/SchoolNotice/NoticeDetail/noticeid/186";
 },
 ...
 )

 */

@property (nonatomic,copy) NSString *noticeid;

@property (nonatomic,copy) NSString *content;

@property (nonatomic,copy) NSString *img;

@property (nonatomic,copy) NSString *time;

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *schoolid;

@property (nonatomic,copy) NSString *url;


@end
