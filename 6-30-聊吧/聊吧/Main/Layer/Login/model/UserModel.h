//
//  UserModel.h
//  TaTaTa
//
//  Created by mac on 15/9/21.
//  Copyright (c) 2015年 wb. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ClassModel.h"

@interface UserModel : NSObject

@property (nonatomic,copy) NSString *flag;

@property (nonatomic,copy) NSString *key;

@property (nonatomic,copy) NSString *pwd;

@property (nonatomic,copy) NSString *user;

@property (nonatomic,copy) NSString *uid;

@property (nonatomic,strong) ClassModel *classModel;


@end

