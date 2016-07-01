//
//  SchoolNoticeModel.m
//  聊吧
//
//  Created by m on 16/6/14.
//  Copyright © 2016年 m. All rights reserved.
//

#import "SchoolNoticeModel.h"

@implementation SchoolNoticeModel

//解决关键字重命名问题
+ (instancetype)objectWithKeyValues:(id)keyValues {
    NSDictionary *dic = (NSDictionary *)keyValues;
    NSString *noticeid = dic[@"id"];
    NSMutableDictionary *mudic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [mudic removeObjectForKey:@"id"];
    [mudic setObject:noticeid forKey:@"noticeid"];
    
    return [self objectWithKeyValues:mudic error:nil];
}

@end
