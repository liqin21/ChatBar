//
//  MineModel.h
//  聊吧
//
//  Created by m on 16/5/24.
//  Copyright © 2016年 m. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineModel : NSObject

@property (nonatomic,copy) NSString *imgView;

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *count;


@end


@interface MineDataModel : NSObject

/*
 {
 Coin = 0;
 Content = "\U591f\U4f60\U8d70";
 HeadImage = "http://www.k12chn.com/uploads/face/faces201606021621067345.jpg";
 RealName = "\U6613\U6b23";
 RoleName = "\U8001\U5e08";
 SchoolName = "\U5929\U9e3f\U5c0f\U5b66";
 UserName = yixin;
 errorCode = "";
 errorFlag = 0;
 errorMsg = "";
 friendRemark = "";
 hxid = 15074;
 hxname = 3260;
 sex = "\U5973";
 }
 
 */

@property (nonatomic,copy) NSString *imageName;

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *content;

@property (nonatomic,copy) NSString *RoleName;

@property (nonatomic,copy) NSString *RealName;

@property (nonatomic,copy) NSString *HeadImage;

@property (nonatomic,copy) NSString *SchoolName;

@property (nonatomic,copy) NSString *UserName;

@property (nonatomic,copy) NSString *sex;

@property (nonatomic,copy) NSString *Content;




@end


