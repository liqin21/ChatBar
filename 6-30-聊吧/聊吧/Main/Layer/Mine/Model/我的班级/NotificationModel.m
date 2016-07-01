//
//  NotificationModel.m
//  聊吧
//
//  Created by m on 16/6/24.
//  Copyright © 2016年 m. All rights reserved.
//

#import "NotificationModel.h"


@implementation NotificationModel

//解决关键字重命名问题
+ (instancetype) objectWithKeyValues:(id)keyValues {
    NSDictionary *dic = (NSDictionary *)keyValues;
    NSString *careID = dic[@"id"];
    NSMutableDictionary *mudic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [mudic removeObjectForKey:@"id"];
    [mudic setObject:careID forKey:@"notificationID"];
    return [self objectWithKeyValues:mudic error:nil];
}

@end
