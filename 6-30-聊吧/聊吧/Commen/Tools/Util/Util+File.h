//
//  Util+File.h
//  TheMall
//
//  Created by quange on 15/6/5.
//  Copyright (c) 2015年 KingHan. All rights reserved.
//

#import "Util.h"

@interface Util (File)

/**
 @brief 获取指定沙河的文件
 @param fileName 文件名称
 @param fileType 文件类型
 @return 文件的Data
 */
+ (NSData *)getBundleFile:(NSString *)fileName fileType:(NSString *)fileType;

/**
 *  将json转变成字典
 *
 *  @param srcData json的名字
 *
 *  @return 数组
 */
+ (id)jsonToDictionary:(NSString *)jsonName;

/**
 *  将字典转变成json字符串
 *
 *  @param object 需要传入的字典
 *
 *  @return json字符串
 */
+ (NSString *)dictToJsonString:(id)object;

/**
 @brief 根据文件路径来创建文件夹
 @param path 要创建文件夹的路径
 @return 返回path
 */
+ (NSString *)createFileDirectory:(NSString *)path;

/**
 @brief 根据文件路径来删除文件夹
 @param path 要删除文件夹的路径
 @return 是否删除成功
 */
+ (BOOL)deleteFileDirectory:(NSString *)path;


/**
 @brief 根据文件路径来创建文件
 @param path 要创建文件的路径
 @param data 需要存储的数据
 @return 是否创建成功
 */
+ (BOOL)createFile:(NSString *)path withData:(NSData *)data;

/**
 @brief 根据文件路径来删除文件
 @param path 要删除文件的路径
 @return 是否删除成功
 */
+ (BOOL)deleteFile:(NSString *)path;


/**
 @brief 归档需要归档的数据到指定路径
 @param data 要归档的数据
 @param path 文件路径
 @return 归档数据是否成功
 */
+ (BOOL)saveObjectToArchiver:(id)data withPath:(NSString *)path;

/**
 @brief 读取归档的文件
 @param path 文件路径
 @return 读取的文件内容，如果文件不存在则返回空
 */
+ (id)readObjectFormArchierWithPath:(NSString *)path;

/**
 *  // 计算目录下面所有文件的大小
 *
 *  @param directory 文件目录
 *
 *  @return 该目录下文件的大小
 */
+ (long long)countDirectorySize:(NSString *)directory;


@end
