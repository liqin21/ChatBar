//
//  FCCommentBar.m
//  聊吧
//
//  Created by m on 16/6/1.
//  Copyright © 2016年 m. All rights reserved.
//

#import "FCCommentBar.h"
#import "XMChatFaceView.h"


@interface FCCommentBar () <UITextViewDelegate,XMChatFaceViewDelegate>

@property (strong, nonatomic) XMChatFaceView *faceView; /**< 当前活跃的底部view,用来指向faceView */

@end


@implementation FCCommentBar {
    UITextView *_textView;
    UIButton *_faceButton;
}

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //布局
        [self setup];
    }
    return self;
}

//布局
- (void)setup {
    //设置背景
    self.backgroundColor = [UIColor colorWithRed:235/255.0 green:236/255.0 blue:238/255.0 alpha:1];
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    //1.表情包按钮
    [self addSubview:[self createFaceButton]];
    //2.输入框
    [self addSubview:[self createFextView]];
    
    //更新视图的约束
    [self updateConstraintsIfNeeded];
    //判断是否刷新layer
    [self layoutIfNeeded];
}

#pragma mark - 更新约束
- (void)updateConstraints {
    [super updateConstraints];
    //表情按钮的约束
    [_faceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-15);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(24);
        make.height.mas_equalTo(25);
    }];

    //输入框的约束
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(15);
        make.right.equalTo(_faceButton.mas_left).with.offset(-15);
        make.top.equalTo(self).with.offset(5);
        make.bottom.equalTo(self).with.offset(-5);
    }];
    
    //监听键盘隐藏的事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    //监听键盘高度变化事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];

}

#pragma mark - 创建表情包按钮
- (UIButton *)createFaceButton {
    _faceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_faceButton setBackgroundImage:[UIImage imageNamed:@"myquanziPhotoReply_biaoqing"] forState:UIControlStateNormal];
    [_faceButton setBackgroundImage:[UIImage imageNamed:@"chat_bar_input_normal"] forState:UIControlStateSelected];
    _faceButton.tag = FounctionViewShowFace;
    [_faceButton addTarget:self action:@selector(faceButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_faceButton sizeToFit];
    return _faceButton;
}

#pragma mark — 创建输入框
- (UITextView *)createFextView {
    _textView = [[UITextView alloc] init];
    _textView.font = [UIFont systemFontOfSize:16.0];
    _textView.delegate = self;
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.layer.cornerRadius = 4;
    _textView.layer.borderColor = [UIColor grayColor].CGColor;
    _textView.returnKeyType = UIReturnKeySend;
    _textView.layer.borderWidth = 0.5f;
    _textView.layer.masksToBounds = YES;
    return _textView;
}



#pragma mark - faceButton 点击事件
- (void)faceButtonAction:(UIButton *)button  {
    NSLog(@"添加表情");
    
    self.inputText = _textView.text;
    FounctionViewShowType showType = button.tag;
    if (button == _faceButton) {
        [_faceButton setSelected:!_faceButton.selected];
    }
    if (!button.selected) {
        showType = FounctionViewShowKeyboard;
        [_textView becomeFirstResponder];
    }else{
        self.inputText = _textView.text;
    }
    [self showViewWithType:showType];
    
}

#pragma mark - 键盘将要隐藏时的事件方法
- (void)keyboardWillHide:(NSNotification *)notification {
    
    self.keyboardFrame = CGRectZero;
    if (self.showType == FounctionViewShowFace) {
        [self textViewDidChange:_textView];
    }
    else {
        [self endInputing];
    }
}

#pragma mark - 键盘的frame将要改变的事件
- (void)keyboardFrameWillChange:(NSNotification *)notification {
    self.keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [self textViewDidChange:_textView];
    
//    CGRect textFieldRect = CGRectMake(0, self.keyboardFrame.origin.y - kMinHeight, self.keyboardFrame.size.width, kMinHeight);
//    if (self.keyboardFrame.origin.y == [UIScreen mainScreen].bounds.size.height) {
//        textFieldRect = self.keyboardFrame;
//    }
//    [UIView animateWithDuration:0.25 animations:^{
//        self.frame = textFieldRect;
//    }];
}

#pragma mark - textView 的代理方法
- (void)textViewDidChange:(UITextView *)textView {
    
    CGRect textViewFrame = _textView.frame;
    CGSize textSize = [_textView sizeThatFits:CGSizeMake(CGRectGetWidth(textViewFrame), 1000.0f)];
    CGFloat offset = 20;
    textView.scrollEnabled = (textSize.height + 0.1 > kMaxHeight-offset);
    textViewFrame.size.height = MAX(34, MIN(kMaxHeight, textSize.height));
    
    CGRect addBarFrame = self.frame;
    addBarFrame.size.height = textViewFrame.size.height+offset;
    addBarFrame.origin.y = self.superViewHeight - self.bottomHeight - addBarFrame.size.height ;
    
    [self setFrame:addBarFrame animated:NO];
    
    if (textView.scrollEnabled) {
        [textView scrollRangeToVisible:NSMakeRange(textView.text.length - 2, 1)];
    }
    
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    _faceButton.selected = NO;
    [self showFaceView:NO];
    self.showType = FounctionViewShowKeyboard;
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        [self sendComment:textView.text];
        return NO;
    }
    
   else if (text.length == 0){
        //判断删除的文字是否符合表情文字规则
        NSString *deleteText = [textView.text substringWithRange:range];
        if ([deleteText isEqualToString:@"]"]) {
            NSUInteger location = range.location;
            NSUInteger length = range.length;
            NSString *subText;
            while (YES) {
                if (location == 0) {
                    return YES;
                }
                location -- ;
                length ++ ;
                subText = [textView.text substringWithRange:NSMakeRange(location, length)];
                if (([subText hasPrefix:@"["] && [subText hasSuffix:@"]"])) {
                    break;
                }
            }
            textView.text = [textView.text stringByReplacingCharactersInRange:NSMakeRange(location, length) withString:@""];
            [textView setSelectedRange:NSMakeRange(location, 0)];
            [self textViewDidChange:_textView];
            return NO;
        }
    }
    return YES;
}

- (void)sendComment:(NSString *)text {
    if (!text || text.length == 0) {
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatBar:sendComment:)]) {
        [self.delegate chatBar:self sendComment:text];
    }
    //清空输入
    self.inputText = @"";
    _textView.text = @"";
    
    [self setFrame:CGRectMake(0, self.superViewHeight - self.bottomHeight , self.frame.size.width, kMinHeight) animated:NO];
    //收起键盘
    [self showViewWithType:FounctionViewShowNoting];
}


- (void)showViewWithType:(FounctionViewShowType)
showType {
    //显示对应的View
    [self showFaceView:showType == FounctionViewShowFace && _faceButton.selected];
    
    switch (showType) {
    case FounctionViewShowNoting:
    {
        self.showType = FounctionViewShowNoting;
        [_textView resignFirstResponder];
        _textView.text = nil;
        [self setFrame:CGRectMake(0, self.superViewHeight, self.frame.size.width, kMinHeight) animated:NO];
        break;
    }
    case FounctionViewShowFace:
    {
        self.showType = FounctionViewShowFace;
        self.inputText = _textView.text;
        [self setFrame:CGRectMake(0, self.superViewHeight - kFunctionViewHeight - _textView.frame.size.height - 10, self.frame.size.width, _textView.frame.size.height + 10) animated:NO];
        [_textView resignFirstResponder];
        [self textViewDidChange:_textView];
        break;
    }
    case FounctionViewShowKeyboard:
    {
        self.showType = FounctionViewShowKeyboard;
        _textView.text = self.inputText;
        [_textView becomeFirstResponder];
        [self textViewDidChange:_textView];
        self.inputText = nil;

        break;
    }
        default:
            break;
    }
}

- (void)showFaceView:(BOOL)show{
    if (show) {
        [self.superview addSubview:self.faceView];
        [UIView animateWithDuration:.3 animations:^{
            [self.faceView setFrame:CGRectMake(0, self.superViewHeight - kFunctionViewHeight, self.frame.size.width, kFunctionViewHeight)];
        } completion:nil];
    }else{
        [UIView animateWithDuration:.3 animations:^{
            [self.faceView setFrame:CGRectMake(0, self.superViewHeight, self.frame.size.width, kFunctionViewHeight)];
        } completion:^(BOOL finished) {
            [self.faceView removeFromSuperview];
        }];
    }
}

- (XMChatFaceView *)faceView{
    if (!_faceView) {
        _faceView = [[XMChatFaceView alloc] initWithFrame:CGRectMake(0, self.superViewHeight , self.frame.size.width, kFunctionViewHeight)];
        _faceView.delegate = self;
        _faceView.backgroundColor = self.backgroundColor;
    }
    return _faceView;
}

#pragma mark - XMChatFaceViewDelegate
- (void)faceViewSendFace:(NSString *)faceName{
    if ([faceName isEqualToString:@"[删除]"]) {
        [self textView:_textView shouldChangeTextInRange:NSMakeRange(_textView.text.length - 1, 1) replacementText:@""];
    }else if ([faceName isEqualToString:@"发送"]){
        NSString *text = _textView.text;
        if (!text || text.length == 0) {
            return;
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(chatBar:sendComment:)]) {
            [self.delegate chatBar:self sendComment:text];
        }
        self.inputText = @"";
        _textView.text = @"";
        [self setFrame:CGRectMake(0, self.superViewHeight - self.bottomHeight, self.frame.size.width, kMinHeight) animated:NO];
        [self showViewWithType:FounctionViewShowNoting];
    }else{
        _textView.text = [_textView.text stringByAppendingString:faceName];
        [self textViewDidChange:_textView];
    }
    
}

#pragma mark - 修改底部高度
- (CGFloat)bottomHeight{
    if (self.faceView.superview) {
        return MAX(self.keyboardFrame.size.height,self.faceView.frame.size.height);
    }else{
        return MAX(self.keyboardFrame.size.height, CGFLOAT_MIN);
    }
}

#pragma mark - 修改frame
- (void)setFrame:(CGRect)frame animated:(BOOL)animated {
    
    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{
            [self setFrame:frame];
        }];
    }
    else {
        [self setFrame:frame];
    }
    CGFloat h = self.keyboardFrame.size.height + self.frame.size.height;
    if (_totalKeybordHeight != h) {
        _totalKeybordHeight = h;
        if (self.showType == FounctionViewShowNoting) {
            return;
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(chatBarFrameDidChange:frame:)]) {
            [self.delegate chatBarFrameDidChange:self frame:frame];
        }
    }
}

#pragma mark - 开始输入
- (void)startInputing {
    [self showViewWithType:FounctionViewShowKeyboard];
}

#pragma mark - 结束输入
- (void)endInputing {
    [self showViewWithType:FounctionViewShowNoting];
}


#pragma mark - 删除通知
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

@end
