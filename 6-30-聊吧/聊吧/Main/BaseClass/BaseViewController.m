//
//  BaseViewController.m
//  聊吧
//
//  Created by m on 16/5/23.
//  Copyright (c) 2016年 m. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = RGB(93, 190, 91, 1);
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                    };
}


@end
