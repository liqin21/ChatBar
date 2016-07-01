//
//  NetworkSingleton.h
//  聊吧
//
//  Created by m on 16/6/12.
//  Copyright © 2016年 m. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "RequastURL.h"

//成功回调的Block
typedef void (^SuccessBlock)(id data);

//失败回调的Block
typedef void (^FailedBlock) (NSError *error);

//请求进度的Block
typedef void (^ProgressBlock)(CGFloat progress);


@interface NetworkSingleton : NSObject


//创建请求网络的单例
+ (NetworkSingleton *)sharaInstance;
/**
 *  请求网络数据
 *
 *  @param urlString    接口地址
 *  @param method       请求方式
 *  @param params       请求参数
 *  @param successBlock 成功回调
 *  @param failedBlock  请求失败回调
 */
+ (void)requestURL:(NSString *)urlString httpMethod:(NSString *)method params:(NSDictionary *)params successBlock:(SuccessBlock)successBlock failedBlock:(FailedBlock) failedBlock;




/**
 *  文件下载
 *
 *  @param urltring      下载地址
 *  @param desPath       下载文件存放的地址
 *  @param fileName      下载的文件名
 *  @param progressBlock 进度回调的Block
 *  @param successBlock  下载成功回调的block
 *  @param failedBlock   下载失败的Block
 *
 *  @return               返回下载的数据
 */

+ (NSURLSessionDownloadTask *) downloadURL:(NSString *)urltring desPath:(NSString *)desPath fileName:(NSString *)fileName progressBlock:(ProgressBlock)progressBlock successBlock:(SuccessBlock)successBlock failedBlock:(FailedBlock)failedBlock;


@end
