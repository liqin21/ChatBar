//
//  ImageButton.h
//  ESong
//
//  Created by liyonghong on 16/3/31.
//  Copyright © 2016年 KEHAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageButton : UIControl

- (void)setText:(NSString *)text forState:(UIControlState)state;
- (void)setTextColor:(UIColor *)color forState:(UIControlState)state;
- (void)setImage:(UIImage *)image forState:(UIControlState)state;
- (void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state;
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

@end
