//
//  FriendsCell.h
//  聊吧
//
//  Created by m on 16/5/24.
//  Copyright © 2016年 m. All rights reserved.
//

#import  <UIKit/UIKit.h>
@class FriendsModel;

@interface FriendsCell :UITableViewCell {
    UIImageView *useImg;
    UILabel *nameLabel;
}

@property (nonatomic,copy) FriendsModel *friendsModel;

@end
