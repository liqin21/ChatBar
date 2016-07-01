//
//  ClassmateListModel.m
//  聊吧
//
//  Created by m on 16/6/20.
//  Copyright © 2016年 m. All rights reserved.
//

#import "ClassmateListModel.h"

@implementation ClassmateListModel

+(instancetype)objectWithKeyValues:(id)keyValues {
    NSDictionary *dic = (NSDictionary *)keyValues;
    NSString *careID = dic[@"id"];
    NSMutableDictionary *mudic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [mudic removeObjectForKey:@"id"];
    [mudic setObject:careID forKey:@"studentID"];
    return [self objectWithKeyValues:mudic error:nil];
}

@end
