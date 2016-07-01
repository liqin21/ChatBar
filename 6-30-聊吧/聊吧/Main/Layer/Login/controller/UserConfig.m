//
//  UserConfig.m
//  聊吧
//
//  Created by m on 16/6/20.
//  Copyright © 2016年 m. All rights reserved.
//

#import "UserConfig.h"

#import "Util+File.h"

static UserConfig *instance = nil;

// 本地的文件目录路径
#define kLocalFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"LocalFileDirectory"]

// 本地的文件目录
#define LocalFileDirectory [Util createFileDirectory:kLocalFilePath]

#define kUserModelPath [LocalFileDirectory stringByAppendingPathComponent:@"userModel.archive"]  // 归档路径


@implementation UserConfig

/**
 *  创建单例对象
 *
 *  @return 返回单例对象
 */
+ (UserConfig *) shareInstance {
    
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken,^{
        instance = [[self alloc] init];
    });

    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    if (instance == nil) {
        instance = [super allocWithZone:zone];
    }
    return instance;
}

/**
 *  保存用户信息
 *
 *  @param userModel 保存用户信息的数据模型
 */
- (void)setAllInformation:(UserModel *)userModel {
    //设置登录状态
    [kUserDefaults setBool:YES forKey:kIsLogin];
    [kUserDefaults synchronize];
    
    //将账户信息归档
    [NSKeyedArchiver archiveRootObject:userModel toFile:kUserModelPath];
}

/**
 *  获取用户信息
 *
 *  @return 返回用户数据
 */
- (UserModel *)getAllInformation {
    UserModel *userModel = [NSKeyedUnarchiver unarchiveObjectWithFile:kUserModelPath];
    
    return userModel;
}


//退出登录
- (void)logout {
    //删除文件
    [Util deleteFile:kUserModelPath];
    
    //设置登录状态
    [kUserDefaults setBool:NO forKey:kIsLogin];
    [kUserDefaults synchronize];
    
}

@end
