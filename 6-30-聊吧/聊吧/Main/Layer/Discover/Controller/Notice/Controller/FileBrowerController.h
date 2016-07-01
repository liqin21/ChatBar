//
//  FileBrowerController.h
//  聊吧
//
//  Created by m on 16/6/29.
//  Copyright © 2016年 m. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FileBrowerController : UIViewController

@property (nonatomic,copy) NSString *filePath;

@property (nonatomic,strong) NSURL *fileURL;

@property (nonatomic,copy) NSString *fileTitle;


@end
