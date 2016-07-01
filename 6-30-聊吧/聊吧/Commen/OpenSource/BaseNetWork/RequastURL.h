//
//  RequastURL.h
//  聊吧
//
//  Created by m on 16/6/12.
//  Copyright © 2016年 m. All rights reserved.
//

#ifndef RequastURL_h
#define RequastURL_h

//接口服务相关

//请求方式
#define kGET            @"GET"
#define kPOST           @"POST"

#define TIMEOUT         15
#define kURL            @"RequestURL"
#define kHttpMethod     @"HttpMethode"

//服务接口开关  1 表示内网接口  0 表示外网接口
#if 0
#define baseUrl     @"http://192.168.0.139/edu/"
#else 
#define baseUrl     @"http://www.k12chn.com/"
#endif

// 本地的文件目录路径
#define kLocalFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"LocalFileDirectory"]

// 本地的文件目录
#define LocalFileDirectory [Util createFileDirectory:kLocalFilePath]

#define kUserModelPath [LocalFileDirectory stringByAppendingPathComponent:@"userModel.archive"]  // 归档路径

#define kFriendDetailModelPath [LocalFileDirectory stringByAppendingPathComponent:@"friendDetailModel.archive"]  // 归档路径

// 下载文件目录路径
#define kdownloadFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"downloadFileDirectory"]

// 下载的文件目录
#define kdownloadDirectory [Util createFileDirectory:kdownloadFilePath]



#endif /* RequastURL_h */
