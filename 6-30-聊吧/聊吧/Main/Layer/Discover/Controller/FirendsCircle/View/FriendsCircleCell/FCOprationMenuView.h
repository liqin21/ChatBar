//
//  FCOprationMenuView.h
//  聊吧
//
//  Created by m on 16/5/31.
//  Copyright © 2016年 m. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FCOprationMenuView : UIView

@property (nonatomic,assign) BOOL show;

@property (nonatomic,copy) void(^likeButtonBlock)();

@property (nonatomic,copy) void(^commentButtonBlock)();

@property (nonatomic,copy) void (^likedBlock)();

@property (nonatomic,copy) void (^canceLikeBlock)();



@end
