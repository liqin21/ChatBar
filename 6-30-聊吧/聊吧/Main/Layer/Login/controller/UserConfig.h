//
//  UserConfig.h
//  聊吧
//
//  Created by m on 16/6/20.
//  Copyright © 2016年 m. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UserModel.h"

//已经登录标记
#define kIsLogin @"kIsLogin"

//NSUserDefaults 单例
#define kUserDefaults [NSUserDefaults standardUserDefaults]

//用户ID
#define UDKEY_LOGINUSERID @"UDKEY_LOGINUSERID"


@interface UserConfig : NSObject
/**
 *  创建单例对象
 *
 *  @return 返回单例对象
 */
+ (UserConfig *) shareInstance;

/**
 *  保存用户信息
 *
 *  @param userModel 保存用户信息的数据模型
 */
- (void)setAllInformation:(UserModel *)userModel;

/**
 *  获取用户信息
 *
 *  @return 返回用户数据
 */
- (UserModel *)getAllInformation;


//退出登录
- (void)logout;

@end
