//
//  FCOprationMenuView.m
//  聊吧
//
//  Created by m on 16/5/31.
//  Copyright © 2016年 m. All rights reserved.
//

#import "FCOprationMenuView.h"
#import "FriendsCirCleController.h"


@implementation FCOprationMenuView {
    
    UIButton *likeButton;         //点赞按钮
    
    UIImageView *likeImage;      //点赞按钮上的图片
    
    UIButton *commentButton;    //评论按钮

}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //布局
        [self setup];
    }
    return self;
}

//布局
- (void)setup {
    
    //监听通知评论按钮点击事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveCommentButtonClickAction:) name:kCommentButtonClickNotification object:nil];
    
    //监听点赞事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveLikeButtonClickAction:) name:kLikeButtonClickNotification object:nil];
    
    //监听取消点赞事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancelLikeNotification:) name:kCancelLikeNotification object:nil];
//    [NSNotificationCenter defaultCenter] addObserver:self forKeyPath:<#(nonnull NSString *)#> options:<#(NSKeyValueObservingOptions)#> context:<#(nullable void *)
    
    //设置背景颜色
    self.backgroundColor = [UIColor colorWithRed:69/255.0 green:74/255.0 blue:76/255.0 alpha:0.9];
    self.layer.cornerRadius = 4;
    //切除视图超出部分
    self.clipsToBounds = YES;
    
    //点赞按钮上的图片
    likeImage = [[UIImageView alloc] init];
    likeImage.image = [UIImage imageNamed:@"AlbumLike"];
    
    //点赞按钮
    likeButton = [self setButtonWithTitle:@"赞" image:[UIImage imageNamed:@""] selectImage:[UIImage imageNamed:@""] target:self selector:@selector(likeButtonAction:)];

    //中间分隔线
    UIView *splitline = [[UIView alloc] init];
    splitline.backgroundColor = [UIColor colorWithRed:68 / 255.0 green:73 / 255.0 blue:94 / 255.0 alpha:1];
    
    //评论按钮
    commentButton = [self setButtonWithTitle:@"评论" image:[UIImage imageNamed:@"AlbumComment"] selectImage:[UIImage imageNamed:@""] target:self selector:@selector(commentButtonAction:)];
    
    [self sd_addSubviews:@[likeImage,likeButton,splitline,commentButton]];
    
    //设置约束
    likeImage.sd_layout.leftSpaceToView(self,18).widthIs(18).heightIs(18).centerYEqualToView(self);
    
    likeButton.sd_layout.leftEqualToView(self).widthIs(90).heightIs(36).topEqualToView(self);
    
    splitline.sd_layout.leftSpaceToView(likeButton,0).topSpaceToView(self,5).bottomSpaceToView(self,5).widthIs(1);
    
    commentButton.sd_layout.leftEqualToView(splitline).widthIs(89).heightIs(36).topEqualToView(self);
    

}

//设置button
- (UIButton *)setButtonWithTitle:(NSString *)title image:(UIImage *)image selectImage:(UIImage *)selectImage target:(id)target selector:(SEL)sel {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:selectImage forState:UIControlStateSelected];
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    
    return button;
}

#pragma mark - 收起、展开菜单栏
- (void)setShow:(BOOL)show {
    _show = show;
    [UIView animateWithDuration:0.5 animations:^{
        if (!show) {
            //清除自动宽度设置，收起菜单栏
            [self clearAutoWidthSettings];
            self.fixedWidth = @(0);
        }
        else {
            self.fixedWidth = nil;
            [self setupAutoWidthWithRightView:commentButton rightMargin:5];
        }
        //更新cell内部的控件布局
        [self updateLayoutWithCellContentView:self.superview];
    }];
}

#pragma mark - 评论、点赞菜单按钮点击事件
//点赞按钮
- (void)likeButtonAction:(UIButton *)button {
    
    if (_likeButtonBlock) {
        //调用block
        _likeButtonBlock();
    }
    
//    static BOOL click = YES;
//    if (click) {
//        click = NO;
//        [likeButton setTitle:@"赞" forState:UIControlStateNormal];
//    }
//    else {
//        click = YES;
//        [likeButton setTitle:@"取消" forState:UIControlStateNormal];
//    }
//    
//    likeImage.transform = CGAffineTransformMakeTranslation(-5, 0);
//    [UIView animateWithDuration:0.5 animations:^{
//        likeImage.transform = CGAffineTransformMakeScale(1.2, 1.2);
//    }];
    [self performSelector:@selector(likeImageAction) withObject:nil afterDelay:0.5];
    
}

- (void)likeImageAction {
    
    [UIView animateWithDuration:0.5 animations:^{
        
        likeImage.transform = CGAffineTransformIdentity;
            }];
    [self performSelector:@selector(hiddenMenuView) withObject:nil afterDelay:0.3];
}

- (void)hiddenMenuView {
    if (self.show) {
        self.show = NO;
    }
}

//评论按钮
- (void)commentButtonAction:(UIButton *)button {
    //弹出键盘
    if (self.show) {
        self.show = NO;
    }
    if (_commentButtonBlock) {
        _commentButtonBlock();
    }
    
}

- (void)receiveCommentButtonClickAction:(NSNotification *)notification {
    if (self.show) {
        self.show = NO;
    }
}

- (void)receiveLikeButtonClickAction:(NSNotification *)notification {
//        static BOOL click = YES;
//        if (click) {
//            click = NO;
            [likeButton setTitle:@"取消" forState:UIControlStateNormal];
//        }
//        else {
//            click = YES;
//            [likeButton setTitle:@"取消" forState:UIControlStateNormal];
//        }
//    
        likeImage.transform = CGAffineTransformMakeTranslation(-5, 0);
        [UIView animateWithDuration:0.5 animations:^{
            likeImage.transform = CGAffineTransformMakeScale(1.2, 1.2);
        }];
    [self performSelector:@selector(likeImageAction) withObject:nil afterDelay:0.5];

}

- (void)cancelLikeNotification:(NSNotification *)notification {
    [likeButton setTitle:@"赞" forState:UIControlStateNormal];
    likeImage.transform = CGAffineTransformMakeTranslation(-5, 0);
    [UIView animateWithDuration:0.5 animations:^{
        likeImage.transform = CGAffineTransformMakeScale(1.2, 1.2);
    }];
    [self performSelector:@selector(likeImageAction) withObject:nil afterDelay:0.5];
}

@end
