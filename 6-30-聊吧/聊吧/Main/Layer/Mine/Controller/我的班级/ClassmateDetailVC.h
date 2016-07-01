//
//  ClassmateDetailVC.h
//  聊吧
//
//  Created by m on 16/6/20.
//  Copyright © 2016年 m. All rights reserved.
//

#import "BaseViewController.h"

@class ClassmateDetailModel;

@interface ClassmateDetailVC : BaseViewController

@property (nonatomic,copy) UITableView *tableView;

@property (nonatomic,copy) NSString *ID;

@property (nonatomic,strong) ClassmateDetailModel *classmateDetailModel;

- (instancetype)initWithID:(NSString *)ID;




@end
