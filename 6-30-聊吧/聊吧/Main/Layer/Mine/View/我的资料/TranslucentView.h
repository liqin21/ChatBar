//
//  TranslucentView.h
//  家校通
//
//  Created by m on 16/6/10.
//  Copyright © 2016年 m. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TranslucentView : UIView

@property (nonatomic,copy) UIView *sexBgView;

@property (nonatomic,copy) UIView *selectBgView;

@property (nonatomic,copy) void(^maleBlock)();

@property (nonatomic,copy) void(^femaleBlock)();

@end
