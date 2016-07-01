//
//  MineDataViewController.h
//  家校通
//
//  Created by m on 16/6/8.
//  Copyright © 2016年 m. All rights reserved.
//

#import "BaseViewController.h"

typedef  NS_ENUM(NSInteger,MyInfoEditType) {
    MyInfoEdit, /**<编辑个人信息按钮*/
    MyInfoDone  /**<完成编辑个人信息按钮*/
};

@interface MineDataViewController : BaseViewController

@property (nonatomic,assign) MyInfoEditType myInfoEditType;

@end
