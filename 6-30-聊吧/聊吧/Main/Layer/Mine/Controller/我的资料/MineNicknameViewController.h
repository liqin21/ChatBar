//
//  MineNicknameViewController.h
//  家校通
//
//  Created by m on 16/6/10.
//  Copyright © 2016年 m. All rights reserved.
//

#import "BaseViewController.h"

@interface MineNicknameViewController : BaseViewController

@property (nonatomic,copy) UITextView *textView;

@property (nonatomic,copy) void(^clickTrueButtonBlock)();

@end
