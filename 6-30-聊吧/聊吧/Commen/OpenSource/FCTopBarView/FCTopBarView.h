//
//  FCTopBarView.h
//  crazyspread
//
//  Created by CaoQuan on 15/10/27.
//  Copyright © 2015年 HCl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FCTopBarViewDelegate <NSObject>

@optional
- (void)FCTopBarViewDidSelectedAtindex:(NSInteger)index;

@end


@interface FCTopBarView : UIScrollView <UIScrollViewDelegate>
@property (nonatomic, copy) NSArray *titleArr;
@property (nonatomic, copy) void (^didSelectedAt)(NSInteger index);
@property (nonatomic, assign) NSInteger curIndex;
@property (nonatomic, assign) CGFloat thumbPos;	//0~maxIndex

- (void)setTitle:(NSString*)title AtIndex:(NSInteger)index;

@end
