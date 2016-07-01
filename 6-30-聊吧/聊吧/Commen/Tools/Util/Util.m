//
//  Util.m
//  TheMall
//
//  Created by quange on 15/6/5.
//  Copyright (c) 2015年 KingHan. All rights reserved.
//

#import "Util.h"


@implementation Util

/**
 *  将obj转变成字符串
 *  @return 字符串
 */
+(NSString *)objectToString:(id)obj
{
    if([obj isKindOfClass:[NSNumber class]]) {
        
        return [NSString stringWithFormat:@"%@",obj];
        
    }else if ([obj isKindOfClass:[NSString class]]) {
        
        return obj;
    }else {
        
        return @"";
    }
}

/**
 @brief 将NSInteger类型转换成NSNumber
 @param intSrc 要转换的NSInteger
 @return 转换后的NSNumber对象
 */
+ (NSNumber *)integerToNumber:(NSInteger)intSrc
{
    return [NSNumber numberWithInteger:intSrc];
}

/**
 @brief 将NSInteger类型转换成NSNumber
 @param intSrc 要转换的double
 @return 转换后的NSNumber对象
 */
+ (NSNumber *)doubleToNumber:(double)intSrc
{
    return [NSNumber numberWithDouble:intSrc];
}


/**
 *  将字符串进行decode解码
 *
 *  @return 字符串
 */
+ (NSString *)URLDecodeString:(NSString *)src
{
    NSMutableString *outputStr = [NSMutableString stringWithString:src];
    
    NSString *result = [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return result;
}

/**
 *  将字符串进行encode编码
 *
 *  @return 字符串
 */
+ (NSString *)URLEncodeString:(NSString *)src
{
    NSMutableString *outputStr = [NSMutableString stringWithString:src];
    
    NSString *result = [outputStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return result;
}

+(UIColor *) hexStringToColor: (NSString *) stringToConvert {
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
        return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor blackColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f)                         alpha:1.0f];
}

/**
 *uilabel富文本originStr 文本 headindent首行缩进 默认0 不缩进 lineheight行间距 默认1.0 单倍行距
 */
+(NSMutableAttributedString*)LabelAttributedStrin:(NSString*)originStr HeadIndent:(CGFloat)headindent lineHeightMultiple:(CGFloat)lineheight {
    
    if(lineheight==0){
        lineheight=1.0;
    }
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString: originStr];
    NSMutableParagraphStyle *
    style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.lineSpacing = 2;//增加行高
    style.lineHeightMultiple = lineheight;//行间距是多少倍
    style.alignment = NSTextAlignmentLeft;//对齐方式
    style.firstLineHeadIndent = headindent;//首行头缩进
    style.paragraphSpacing = 5;//段落后面的间距
    style.paragraphSpacingBefore = 5;//段落之前的间距
    //    style.headIndent = 10;//缩进，相当于左padding
    //    style.tailIndent = -10;//尾部缩进相当于右padding
    
    
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, originStr.length)];
    
    
    return attributedStr;
}

/**
 *返回范围 文本  最大范围 字号
 */
+(CGSize)sizeWithString:(NSString *)string CGsize:(CGSize)size font:(UIFont *)font
{
    //限制最大的宽度和高度
    CGRect rect = [string boundingRectWithSize:size
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    
    return rect.size;
}


@end
