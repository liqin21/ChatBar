//
//  AlertHelper.m
//  ThankYou
//
//  Created by lizzy on 16/6/6.
//  Copyright © 2016年 2011-2013 湖南长沙阳环科技实业有限公司 @license http://www.yhcloud.com.cn. All rights reserved.
//


#import "AlertHelper.h"
#import "RequestLoadingView.h"
//#import "DemonAlertView.h"

@interface AlertHelper()
//@property (nonatomic, strong) NSMutableArray* boundViews;
@property (nonatomic,strong)RequestLoadingView *loadingView;
@end

@implementation AlertHelper

#pragma mark -
#pragma mark 初始化

+ (AlertHelper *)sharedView
{
    static dispatch_once_t pred;
    static AlertHelper *_instance = nil;
    dispatch_once(&pred, ^{_instance  = [[self alloc] init];});
    return _instance;
}

#pragma mark -
#pragma mark getter & setter
//-(NSMutableArray *)boundViews
//{
//    if (!_boundViews) {
//        _boundViews = [[NSMutableArray alloc]initWithCapacity:10];
//    }
//    return _boundViews;
//}

- (RequestLoadingView *)loadingView
{
    
    return _loadingView;
}

#pragma mark -
#pragma mark 加载等待层
+ (void) showRequestingView
{
    if (![self sharedView].loadingView)
    {
        [self sharedView].loadingView = [[RequestLoadingView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    }
    
    if ([self sharedView].loadingView.superview) {
        return;
    }
    
    [[UIApplication sharedApplication].keyWindow addSubview:[self sharedView].loadingView];
    [[self sharedView].loadingView show];
    
}

+ (void) dissmissRequestView
{
    [[self sharedView].loadingView removeFromSuperview];
    [[self sharedView].loadingView dissmiss];
}

//#pragma mark -
//#pragma mark 提示框
//
//+ (void)showAlertWithType:(AlertViewType)type
//                  content:(NSString *)content
//                doneBlock:(void (^)(void))_block
//{
//    NSString *str;
//    switch (type) {
//        case AlertViewTypeAlert:
//             str = @"警告";
//            break;
//        case AlertViewTypeError:
//             str = @"错误";
//            break;
//        case AlertViewTypePrompt:
//             str = @"温馨提示";
//            break;
//        default:
//            break;
//    }
//    DemonAlertView *alertView = [[DemonAlertView alloc] initAlertWithTitle:str
//                                                                   content:content
//                                                                 doneBlock:_block
//                                                                      type:type];
//    [alertView showWithAnimation:AlertShowAnimationTypeFromFadeInOut];
//}
//
//+ (void)showAlertWithTitle:(NSString *)_title
//                   content:(NSString *)_content
//          dissmissDuration:(NSTimeInterval)_dissmissDuration
//                      type:(AlertViewType)_type
//
//{
//    DemonAlertView *alertView = [[DemonAlertView alloc]initAlertWithTitle:_title
//                                                        content:_content
//                                                           type:_type];
//    [alertView showWithAnimation:AlertShowAnimationTypeFromFadeInOut];
//    [alertView bk_performBlock:^(DemonAlertView *obj) {
//        [obj dissmissAlert];
//    } afterDelay:_dissmissDuration];
//}
//
//
//+ (void)showAlertWithTitle:(NSString *)_title
//                   content:(NSString *)_content
//                 doneBlock:(void (^)(void))_block
//                      type:(AlertViewType)_type
//{
//    DemonAlertView *alertView = [[DemonAlertView alloc] initAlertWithTitle:_title
//                                                         content:_content
//                                                       doneBlock:_block
//                                                            type:_type];
//    [alertView showWithAnimation:AlertShowAnimationTypeFromFadeInOut];
//}
//
//
//+ (void)showAlertWithTitle:(NSString *)_title
//                   content:(NSString *)_content
//               buttonTitle:(NSString *)buttonTitle
//               buttonColor:(UIColor *)buttonColor
//                 doneBlock:(void (^)(void))_block
//                      type:(AlertViewType)_type
//{
//    DemonAlertView *alertView = [[DemonAlertView alloc]
//                                 initAlertWithTitle:_title
//                                 content:_content
//                                 btnTitle:buttonTitle
//                                 btnColor:buttonColor
//                                 doneBlock:_block
//                                 type:_type];
//
//    [alertView showWithAnimation:AlertShowAnimationTypeFromFadeInOut];
//
//
//}
//
//+ (void)showAlertWithTitle:(NSString *)_title
//                   content:(NSString *)_content
//                 doneBlock:(void (^)(void))_doneBlock
//               cancelBlock:(void (^)(void))_cancelBlock
//                      type:(AlertViewType)_type
//{
//    DemonAlertView *alertView = [[DemonAlertView alloc] initAlertWithTitle:_title
//                                                         content:_content
//                                                       doneBlock:_doneBlock
//                                                     cancelBlock:_cancelBlock
//                                                            type:_type];
//    [alertView showWithAnimation:AlertShowAnimationTypeFromFadeInOut];
//}
//
//+ (void)showAlertWithTitle:(NSString *)_title
//                   content:(NSString *)_content
//              leftBtnColor:(UIColor *)leftColor
//             rightBtnColor:(UIColor *)rightColor
//                 doneBlock:(void (^)(void))_doneBlock
//               cancelBlock:(void (^)(void))_cancelBlock
//                      type:(AlertViewType)_type
//              buttonTitles:(NSArray *)buttonTitles
//{
//    DemonAlertView *alertView = [[DemonAlertView alloc] initAlertWithTitle:_title
//                                                                   content:_content
//                                                              leftBtnColor:leftColor
//                                                             rightBtnColor:rightColor
//                                                                 doneBlock:_doneBlock
//                                                               cancelBlock:_cancelBlock
//                                                                      type:_type
//                                                              buttonTitles:buttonTitles];
//    [alertView showWithAnimation:AlertShowAnimationTypeFromFadeInOut];
//}
//
//
//+ (void)showAlertWithTitle:(NSString *)_title
//                   content:(NSString *)_content
//                 leftBlock:(void (^)(void))_leftBlock
//                rightBlock:(void (^)(void))_rightBlock
//                closeBlock:(void (^)(void))_closeBlock
//              buttonTitles:(NSArray *)buttonTitles
//                      type:(AlertViewType)_type
//                  hasClose:(BOOL)hasClose
//
//{
//    DemonAlertView *alertView = [[DemonAlertView alloc] initAlertWithTitle:_title
//                                                         content:_content
//                                                 leftButtonBlock:_leftBlock
//                                                rightButtonBlock:_rightBlock
//                                                closeButtonBlock:_closeBlock
//                                                    buttonTitles:buttonTitles
//                                                            type:_type
//                                                        hasClose:hasClose];
//    [alertView showWithAnimation:AlertShowAnimationTypeFromFadeInOut];
//}
//
//#pragma mark -
//#pragma mark Hub 提示框
//
//#define MainWindow  ([UIApplication sharedApplication].keyWindow)
//
//+(void)showHudWithMessage:(NSString *)message view:(UIView *)view
//{
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view
//                                              animated:YES];
//    hud.labelText = message;
//}
//
//+(void)hideHudMessageWithView:(UIView *)view
//{
//    [MBProgressHUD hideHUDForView:view
//                         animated:YES];
//}
//
//+(void)showHudWithMessage:(NSString *)message
//{
//    [self showHudWithMessage:message
//                        view:MainWindow];
//}
//
//+(void)hideHudMessage
//{
//    [MBProgressHUD hideHUDForView:MainWindow
//                         animated:YES];
//}
//
//+(void)showHudWithMessage:(NSString *)message
//                     view:(UIView *)view
//           hideAfterDelay:(NSTimeInterval)delay
//{
//    [[MBProgressHUD class] hideAllHUDsForView:MainWindow
//                                     animated:NO];
//
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view
//                                              animated:YES];
//    BOOL cantains = NO;
//    if (iOS7)
//    {
//        NSRange range = [message rangeOfString:@"\n"];
//        cantains =  range.length > 0;
//    }
//    else
//    {
//        cantains = [message containsString:@"\n"];
//    }
//    if (cantains)
//    {
//        NSArray * array = [message componentsSeparatedByString:@"\n"];
//        hud.labelText = array[0];
//        hud.detailsLabelText = array[1];
//    }
//    else
//    {
//        hud.labelText = message;
//    }
//    hud.labelFont = [UIFont boldSystemFontOfSize:14.0f];
//    hud.margin = 12.0f;
//    hud.yOffset = 150.0f;
//    hud.mode = MBProgressHUDModeText;
//    hud.removeFromSuperViewOnHide = YES;
//    hud.userInteractionEnabled = NO;
//    [hud hide:YES afterDelay:delay];
//}
//
//+(void)showToastWithMessage:(NSString *)message
//{
//    [self showToastWithMessage:message view:MainWindow];
//}
//
//+(void)showToastWithMessage:(NSString *)message view:(UIView *)view
//{
//    [self showHudWithMessage:message view:view hideAfterDelay:1.7];
//}

@end
