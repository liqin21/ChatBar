//
//  FCPhotoContainerView.h
//  聊吧
//
//  Created by m on 16/5/28.
//  Copyright © 2016年 m. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FCPhotoContainerView : UIView 

//图片的数量
@property (nonatomic,copy) NSArray *picPathStringArray;

//显示图片的视图数量
@property (nonatomic,copy) NSArray *imageViewArray;

@end
