//
//  NetworkSingleton.m
//  聊吧
//
//  Created by m on 16/6/12.
//  Copyright © 2016年 m. All rights reserved.
//

#import "NetworkSingleton.h"

static NetworkSingleton *instance = nil;

@implementation NetworkSingleton

+ (NetworkSingleton *)sharaInstance {
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}
/**
 *  请求网络数据
 *
 *  @param urlString    接口地址
 *  @param method       请求方式
 *  @param params       请求参数
 *  @param successBlock 成功回调的Block
 *  @param failedBlock  失败回调的Block
 */

+ (void)requestURL:(NSString *)urlString httpMethod:(NSString *)method params:(NSDictionary *)params successBlock:(SuccessBlock)successBlock failedBlock:(FailedBlock)failedBlock {
    
    //utf8编码
    NSString *ut8Str = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *requestURL = [baseUrl stringByAppendingString:ut8Str];
    
    //2.构造一个操作对象的管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //配置管理者
    //配置数据解析方式
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
    
    //设置超时时间
    [manager.responseSerializer willChangeValueForKey:@"timeoutInterva"];
    manager.requestSerializer.timeoutInterval = TIMEOUT;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    //请求数据
    if ([[method uppercaseString] isEqualToString:@"GET"]) {
        [manager GET:requestURL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
            
            
            //请求进度
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //请求成功
            
            
            
            if (successBlock) {
                successBlock(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failedBlock) {
                failedBlock(error);
            }
        }];
    }
    else if ([[method uppercaseString] isEqualToString:@"POST"]) {
        [manager POST:requestURL parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            //请求进度
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //成功回调的Block
            if (successBlock) {
                successBlock(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //请求失败回调的Block
            if (failedBlock) {
                failedBlock(error);
            }
        }];
    }
    
}

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

+ (NSURLSessionDownloadTask *) downloadURL:(NSString *)urltring desPath:(NSString *)desPath fileName:(NSString *)fileName progressBlock:(ProgressBlock)progressBlock successBlock:(SuccessBlock)successBlock failedBlock:(FailedBlock)failedBlock {
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    //构造一个操作对象的管理者
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    //拼接地址
#if 1
    NSString *downloadUrl = [baseUrl stringByAppendingString:urltring];
#else 
    NSString *ss = @"http://dlqncdn.miaopai.com/stream/qCC408GAsmPC~CIc-5G8iQ__.mp4";
#endif
    
    NSString *urlStr = [downloadUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //下载进度
        CGFloat progress = 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (progressBlock) {
                progressBlock(progress);
            }
        });
        
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        //指定下载文件的保存路径
        NSString *suggestedFileName = response.suggestedFilename;
        NSString *downloadPath = [NSString stringWithFormat:@"%@/%@",kdownloadDirectory,suggestedFileName];
        NSURL *fileURL = [NSURL fileURLWithPath:downloadPath];
        return fileURL;
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (error == nil) {
            //下载成功
            if (successBlock) {
                successBlock(filePath);
            }
        }
        else {
            //下载失败
            if (failedBlock) {
                failedBlock(error);
            }
        }
    }];
    [task resume];
    
    return task;
}



@end
