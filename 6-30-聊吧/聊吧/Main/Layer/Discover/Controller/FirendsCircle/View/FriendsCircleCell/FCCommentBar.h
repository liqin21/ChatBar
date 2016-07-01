//
//  FCCommentBar.h
//  聊吧
//
//  Created by m on 16/6/1.
//  Copyright © 2016年 m. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kFunctionViewHeight 210.0f
#define kMaxHeight 60.0f
#define kMinHeight 70.0f

typedef NS_ENUM(NSUInteger,FounctionViewShowType)  {
    FounctionViewShowNoting,   //不显示
    FounctionViewShowFace,      //显示founctionFace
    FounctionViewShowKeyboard,  //显示founctionKeyboard
    FunctionViewShowMore,        //显示显示更多view
    FunctionViewShowVoice       //显示录音view
};


#pragma mark - 定义一个协议
@class FCCommentBar;

@protocol FCCommentBarDelegate <NSObject>
/**
 *  发送普通的文字信息,可能带有表情
 *
 *  @param chatBar
 *  @param message 需要发送的文字信息
 */
- (void)chatBar:(FCCommentBar *)chatBar sendComment:(NSString *)comment;

/**
 *  chatBarFrame改变回调
 *
 *  @param chatBar
 */
@optional

- (void)chatBarFrameDidChange:(FCCommentBar *)chatBar frame:(CGRect)frame;

@end


@interface FCCommentBar : UIView

@property (nonatomic,assign) CGRect keyboardFrame;

@property (nonatomic,assign) FounctionViewShowType showType;

@property (nonatomic,strong) id<FCCommentBarDelegate>delegate;

@property (copy, nonatomic) NSString *inputText;

@property (assign, nonatomic) CGFloat superViewHeight;

@property (assign, nonatomic, readonly) CGFloat bottomHeight;

@property (nonatomic,assign) CGFloat totalKeybordHeight;


//结束输入框
- (void)endInputing;

//开始输入状态
- (void)startInputing;

@end
