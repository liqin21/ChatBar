//
//  Util+File.m
//  TheMall
//
//  Created by quange on 15/6/5.
//  Copyright (c) 2015年 KingHan. All rights reserved.
//

#import "Util+File.h"

@implementation Util (File)

/**
 @brief 获取指定沙河的文件
 @param fileName 文件名称
 @param fileType 文件类型
 @return 文件的Data
 */
+ (NSData *)getBundleFile:(NSString *)fileName fileType:(NSString *)fileType
{
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:fileType];
    NSData *tempData = [NSData dataWithContentsOfFile:path];
    return tempData;
}

/**
 *  将json转变成字典
 *
 *  @param srcData json的名字
 *
 *  @return 数组
 */
+ (id)jsonToDictionary:(NSString *)jsonName
{
    NSData *jsonData = [Util getBundleFile:jsonName fileType:@"json"];
    NSError *err;
    id value = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if (err) {
        
        return nil;
        
    }else {
        
        return value;
    }
}

/**
 *  将字典转变成json字符串
 *
 *  @param object 需要传入的字典
 *
 *  @return json字符串
 */
+ (NSString *)dictToJsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
    
    if (error) {
        
        return nil;
        
    }else {
        
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        return jsonString;
    }
}

/**
 @brief 根据文件路径来创建文件夹
 @param path 要创建文件夹的路径
 @return 是否创建成功
 */
+ (NSString *)createFileDirectory:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:path isDirectory:nil]) {
        
         [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return path;
}

/**
 @brief 根据文件路径来删除文件夹
 @param path 要删除文件夹的路径
 @return 是否删除成功
 */
+ (BOOL)deleteFileDirectory:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:path isDirectory:nil]) {
        
        BOOL isSucuss = [fileManager removeItemAtPath:path error:nil];
        
        if (isSucuss) {
            return YES;
        }
    }
    
    return NO;
}

/**
 @brief 根据文件路径来创建文件
 @param path 要创建文件的路径
 @param data 需要存储的数据
 @return 是否创建成功
 */
+ (BOOL)createFile:(NSString *)path withData:(NSData *)data
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL bol = NO;
    if (![fileManager fileExistsAtPath:path]) {
        bol = [fileManager createFileAtPath:path contents:data attributes:nil];
    }
    
    return bol;

}

/**
 @brief 根据文件路径来删除文件
 @param path 要删除文件的路径
 @return 是否删除成功
 */
+ (BOOL)deleteFile:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:path]) {
        
        BOOL isSucuss = [fileManager removeItemAtPath:path error:nil];
        
        if (isSucuss) {
            return YES;
        }
    }
    
    return NO;
}


/**
 @brief 归档需要归档的数据到指定路径
 @param data 要归档的数据
 @param path 文件路径
 @return 归档数据是否成功
 */
+ (BOOL)saveObjectToArchiver:(id)data withPath:(NSString *)path
{
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:path]) {
        
        [fm removeItemAtPath:path error:nil];
    }
  
    BOOL bol = [NSKeyedArchiver archiveRootObject:data toFile:path];
    
    return bol;
}

/**
 @brief 读取归档的文件
 @param path 文件路径
 @return 读取的文件内容，如果文件不存在则返回空
 */
+ (id)readObjectFormArchierWithPath:(NSString *)path
{
    // 解归档，拿缓存数据
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:path]) {
        
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        id unarchiverData = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        return unarchiverData;
        
    }else{
        
        return nil;
    }
    
}


/**
 *  // 计算目录下面所有文件的大小
 *
 *  @param directory 文件目录
 *
 *  @return 该目录下文件的大小
 */
+ (long long)countDirectorySize:(NSString *)directory
{
    // 文件管理者对象
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 获取到目录下面所有的文件名
    NSArray *fileNames = [fileManager subpathsOfDirectoryAtPath:directory error:nil];
    //NSLog(@"fileNames : %@", fileNames);
    
    // 所有的文件大小
    long long sum = 0;
    for (NSString *fileName in fileNames) {
        
        // 拼接文件路径 Library/Caches.. + bdcdd4208ac8657348d9836f7d6cc160
        NSString *filePath = [directory stringByAppendingPathComponent:fileName];
        
        // 获取文件属性
        NSDictionary *attribute = [fileManager attributesOfItemAtPath:filePath error:nil];
        //NSLog(@"attribute : %@", attribute);
        
        //NSNumber *filesize = attribute[NSFileSize];
        // 得到是每一个文件大小
        long long size = [attribute fileSize];
        
        // 累加
        sum += size;
    }
    
    return sum;
}


@end
