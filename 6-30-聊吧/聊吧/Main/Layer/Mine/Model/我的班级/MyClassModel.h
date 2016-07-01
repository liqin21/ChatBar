//
//  MyClassModel.h
//  聊吧
//
//  Created by m on 16/6/15.
//  Copyright © 2016年 m. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyClassModel : NSObject

/*
 
 JSON
 
 studentinfo:[];
 
 classname"二年级1班"
 
 teachercount"15"
 
 teachername"刘一莎"
 
 teacherheadimg"http://www.k12chn.com./uploads/20160322170548.jpg"
 
 studentcount 58
 
 teacherlist:[];
 
 */

@property (nonatomic,strong) NSArray *studentinfo;

@property (nonatomic,copy) NSString *classname;

@property (nonatomic,copy) NSString *teachercount;

@property (nonatomic,copy) NSString *teachername;

@property (nonatomic,copy) NSString *teacherheadimg;

@property (nonatomic,copy) NSNumber *studentcount;

@property (nonatomic,strong) NSArray *teacherlist;



@end
