//
//  FCCellCommentView.h
//  聊吧
//
//  Created by m on 16/6/4.
//  Copyright © 2016年 m. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FCCellCommentView : UIView

//给出一个设置数据的接口
- (void)setupWithLikeItemsArray:(NSArray *) likeItemsArray commentItemArray:(NSArray *)commentItemsArray;

@end
