//
//  ClassModel.h
//  聊吧
//
//  Created by m on 16/6/20.
//  Copyright © 2016年 m. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassModel : NSObject

/*
 {
 classid = 3022;
 classlist =     (
 {
 classname = "\U4e8c\U5e74\U7ea71\U73ed";
 id = 3023;
 },
 {
 classname = "\U4e8c\U5e74\U7ea72\U73ed";
 id = 3022;
 }
 );
 classname = "\U4e8c\U5e74\U7ea72\U73ed";
 headimg = "http://www.k12chn.com/uploads/face/faces201606121142391886.jpg";
 realname = "\U5218\U4e00\U838e";
 username = liuyisha;
 }
 
 */

@property (nonatomic,copy) NSString *classid;

@property (nonatomic,copy) NSString *classname;

@property (nonatomic,copy) NSString *headimg;

@property (nonatomic,copy) NSString *realname;

@property (nonatomic,copy) NSString *username;

@property (nonatomic,strong) NSArray *classlist;

@end
