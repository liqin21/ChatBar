//
//  DetailNotificationVC.h
//  聊吧
//
//  Created by m on 16/6/25.
//  Copyright © 2016年 m. All rights reserved.
//

#import "BaseViewController.h"

@interface DetailNotificationVC : BaseViewController

//html5 请求地址
@property (nonatomic,copy) NSString *htmlID;

@property (nonatomic,copy) NSString *htlmString;

//网络地址
@property (nonatomic,copy) NSString *urlString;

@property (nonatomic,copy) NSString *body;

@end
