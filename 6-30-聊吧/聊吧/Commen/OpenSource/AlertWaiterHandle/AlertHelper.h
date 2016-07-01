//
//  AlertHelper.h
//  ThankYou
//
//  Created by lizzy on 16/6/6.
//  Copyright © 2016年 2011-2013 湖南长沙阳环科技实业有限公司 @license http://www.yhcloud.com.cn. All rights reserved.
//


/*!
 *  @author lizzy, 15-08-17 15:08:22
 *
 *  @brief  统一封装提示框、加载框、HUD提示框,此类部分功能实现依赖于BlocksKit库、MBProgressHuD库
 *
 *  @since 3.0.1
 */
#import <Foundation/Foundation.h>

//static NSString *const kAlertViewTypeAlert = @"异常提示";/**<异常提示标题*/
//static NSString *const kAlertViewTypeError = @"错误提示";/**<错误提示标题*/
//static NSString *const kAlertViewTypePrompt = @"温馨提示";/**<温馨提示标题*/

//typedef NS_ENUM(NSUInteger, AlertViewType)/**<提示框类型*/
//{
//    AlertViewTypeAlert = 1,/**<警告*/
//    AlertViewTypeError = 2,/**<错误*/
//    AlertViewTypePrompt = 3,/**<温馨提示*/
//};

@interface AlertHelper : NSObject

+ (void)showRequestingView;/**<显示加载等待层*/

+ (void)dissmissRequestView;/**<关闭加载等待层*/

///*!
// *  @author lizzy, 15-08-20 17:08:22
// *
// *  @brief  显示一个没有按钮的提示框，持续一段时间后自动消失
// *
// *  @param _title            标题
// *  @param _content          内容
// *  @param _dissmissDuration 提示看持续时间
// *  @param _type             提示类型
// *
// *  @since 3.0.1
// */
//+ (void)showAlertWithTitle:(NSString *)_title
//                   content:(NSString *)_content
//          dissmissDuration:(NSTimeInterval)_dissmissDuration
//                      type:(AlertViewType)_type;
//
///*!
// *  @author lizzy, 15-08-27 22:08:48
// *
// *  @brief  显示一个只有“确定”按钮的提示框，由用户点击消失，并且消失后执行 _block中的代码
// *
//
// *  @param _content 内容
// *  @param _block   点击确定按钮以后执行的代码块
// *  @param _type    提示类型
// *  @since 3.0.1
// */
//+ (void)showAlertWithType:(AlertViewType)type
//                  content:(NSString *)content
//                doneBlock:(void (^)(void))_block;
///*!
// *  @author lizzy, 15-08-20 17:08:32
// *
// *  @brief  显示一个只有“确定”按钮的提示框，由用户点击消失，并且消失后执行 _block中的代码
// *
// *  @param _title   标题
// *  @param _content 内容
// *  @param _block   点击确定按钮以后执行的代码块
// *  @param _type    提示类型
// *
// *  @since 3.0.1
// */
//+ (void)showAlertWithTitle:(NSString *)_title
//                   content:(NSString *)_content
//                 doneBlock:(void (^)(void))_block
//                      type:(AlertViewType)_type;
//
///**
// *  @author 朱介伟, 15-10-27 11:10:00
// *
// *  @brief  显示一个只有自定义按钮颜色标题的提示框，由用户点击消失，并且消失后执行 _block中的代码
// *
// *  @param _title      标题
// *  @param _content    内容
// *  @param buttonTitle 按钮标题
// *  @param buttonColor 按钮颜色
// *  @param _block      点击确定按钮以后执行的代码块
// *  @param _type       提示类型
// */
//
//+ (void)showAlertWithTitle:(NSString *)_title
//                   content:(NSString *)_content
//               buttonTitle:(NSString *)buttonTitle
//               buttonColor:(UIColor *)buttonColor
//                 doneBlock:(void (^)(void))_block
//                      type:(AlertViewType)_type;
//
///*!
// *  @author lizzy, 15-08-20 17:08:49
// *
// *  @brief  显示一个有“确定”，“取消”的提示框
// *
// *  @param _title       标题
// *  @param _content     内容
// *  @param _doneBlock   点击确定执行的block
// *  @param _cancelBlock 点击取消执行的block
// *  @param _type        提示类型
// *
// *  @since 3.0.1
// */
//+ (void)showAlertWithTitle:(NSString *)_title
//                   content:(NSString *)_content
//                 doneBlock:(void (^)(void))_doneBlock
//               cancelBlock:(void (^)(void))_cancelBlock
//                      type:(AlertViewType)_type;
//
///*!
// *  @author lizzy, 15-10-29 17:10:24
// *
// *  @brief  弹出提示框，可以设置左右按钮颜色，标题
// *
// *  @param _title       标题
// *  @param _content     内容
// *  @param leftColor    左按钮颜色
// *  @param rightColor   右按钮颜色
// *  @param _doneBlock   点击右按钮回调
// *  @param _cancelBlock 点击左按钮回调
// *  @param _type        提示类型
// *  @param buttonTitles 标题数组
// *
// *  @since 2.12
// */
//+ (void)showAlertWithTitle:(NSString *)_title
//                   content:(NSString *)_content
//              leftBtnColor:(UIColor *)leftColor
//             rightBtnColor:(UIColor *)rightColor
//                 doneBlock:(void (^)(void))_doneBlock
//               cancelBlock:(void (^)(void))_cancelBlock
//                      type:(AlertViewType)_type
//              buttonTitles:(NSArray *)buttonTitles;
//
///*!
// *  @author lizzy, 15-08-22 22:08:50
// *
// *  @brief  显示一个有“同意”，“拒绝”，取消的提示框
// *
// *  @param _title         标题
// *  @param _content       内容
// *  @param _agreeBlock    点击确定执行的block
// *  @param _disagreeBlock 点击确定执行的block
// *  @param _cancleBlock   点击取消执行的block
// *  @param buttonTitles   按钮标题
// *  @param _type          提示类型
// *  @param _hasClose      是否有关闭按钮
// *  @since 3.0.1
// */
//+ (void)showAlertWithTitle:(NSString *)_title
//                   content:(NSString *)_content
//                 leftBlock:(void (^)(void))_leftBlock
//                rightBlock:(void (^)(void))_rightBlock
//                closeBlock:(void (^)(void))_closeBlock
//              buttonTitles:(NSArray *)buttonTitles
//                      type:(AlertViewType)_type
//                  hasClose:(BOOL)hasClose;
//
//
///*!
// *  @author lizzy, 15-08-20 17:08:04
// *
// *  @brief  Hud加载效果
// *
// *  @param message 提示文字
// *  @param viev    需要显示的view
// *
// *  @since 3.0.1
// */
//+(void)showHudWithMessage:(NSString *)message
//                     view:(UIView *)viev;
//
///*!
// *  @author lizzy, 15-08-20 17:08:39
// *
// *  @brief  Hud隐藏
// *
// *  @param view 需要隐藏的view
// *
// *  @since 3.0.1
// */
//+(void)hideHudMessageWithView:(UIView *)view;
//
///*!
// *  @author lizzy, 15-08-20 17:08:02
// *
// *  @brief  Hud加载效果,默认加载window上
// *
// *  @param message 提示文字
// *
// *  @since 3.0.1
// */
//+(void)showHudWithMessage:(NSString *)message;
//
//
//+(void)hideHudMessage;/**<Hud隐藏*/
//
///*!
// *  @author lizzy, 15-08-20 17:08:34
// *
// *  @brief  Hud提示
// *
// *  @param message 提示内容
// *  @param view    提示View
// *  @param delay   消失时间段
// *
// *  @since 3.0.1
// */
//+(void)showHudWithMessage:(NSString *)message
//                     view:(UIView *)view
//           hideAfterDelay:(NSTimeInterval)delay;
//
///*!
// *  @author lizzy, 15-08-20 17:08:13
// *
// *  @brief  提示框，自动消失,持续时间1.7s
// *
// *  @param message 提示信息
// *
// *  @since 3.0.1
// */
//+(void)showToastWithMessage:(NSString *)message;
//
///*!
// *  @author lizzy, 15-08-20 17:08:36
// *
// *  @brief  提示框，自动消失
// *
// *  @param message 提示信息
// *  @param view    承载View
// *
// *  @since 3.0.1
// */
//+(void)showToastWithMessage:(NSString *)message
//                       view:(UIView *)view;

@end