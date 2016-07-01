//
//  Util.h
//  TheMall
//
//  Created by quange on 15/6/5.
//  Copyright (c) 2015年 KingHan. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Util : NSObject

/**
 *  将obj转变成字符串
 *  @return 字符串
 */
+(NSString *)objectToString:(id)obj;

/**
 @brief 将NSInteger类型转换成NSNumber
 @param intSrc 要转换的NSInteger
 @return 转换后的NSNumber对象
 */
+ (NSNumber *)integerToNumber:(NSInteger)intSrc;

/**
 @brief 将NSInteger类型转换成NSNumber
 @param intSrc 要转换的double
 @return 转换后的NSNumber对象
 */
+ (NSNumber *)doubleToNumber:(double)intSrc;

/*
 @brief 根据颜色来生成图片
 @param color要生成图片的颜色
 */

/**
 *  将字符串进行decode解码
 *
 *  @return 字符串
 */
+ (NSString *)URLDecodeString:(NSString *)src;

/**
 *  将字符串进行encode编码
 *
 *  @return 字符串
 */
+ (NSString *)URLEncodeString:(NSString *)src;


+(UIColor *) hexStringToColor: (NSString *) stringToConvert ;

+(NSMutableAttributedString*)LabelAttributedStrin:(NSString*)originStr HeadIndent:(CGFloat)headindent lineHeightMultiple:(CGFloat)lineheight ;
+(CGSize)sizeWithString:(NSString *)string CGsize:(CGSize)size font:(UIFont *)font;


@end
