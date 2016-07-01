//
//  LoginViewController.h
//  聊吧
//
//  Created by m on 16/5/24.
//  Copyright © 2016年 m. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController {
    //1.用户账号
    UILabel *_numberLabel;
    
    //密码
    UITextField *_passField;
    
    //清除输入按钮
    UIButton *_clearButton;
    
    //密码可见按钮
    UIButton *_lockButton;
    
    //底部背景视图
    UIView *_bgView;
    
    //选择对话框底部背景视图
    UIView *_selectionView;

}

@end
