//
//  MainTabItems.h
//  聊吧
//
//  Created by m on 16/6/19.
//  Copyright © 2016年 m. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTabItems : UIControl

@property (nonatomic, assign)BOOL isSelected;

/*!
 *  @author lizzy, 15-08-18 09:08:02
 *
 *  @brief  初始化Tabbar的item
 *
 *  @param frame             item的frame
 *  @param normalImageName   非选中状态的图片名称
 *  @param selectedImageName 选中状态的按钮图片名称
 *  @param normalFontColor   非选中状态的字体颜色
 *  @param selectedFontColor 选中状态的字体颜色
 *  @param title             item的title
 *
 *  @return item
 *
 *  @since 3.0.1
 */

- (id)initWithFrame:(CGRect)frame
    normalImageName:(NSString *)normalImageName
  selectedImageNemd:(NSString *)selectedImageName
    normalFontColor:(UIColor *)normalFontColor
  selectedFontColor:(UIColor *)selectedFontColor
              title:(NSString *)title;





@end
