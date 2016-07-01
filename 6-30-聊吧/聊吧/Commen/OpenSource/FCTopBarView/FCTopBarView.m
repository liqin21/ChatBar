//
//  FCTopBarView.m
//  crazyspread
//
//  Created by CaoQuan on 15/10/27.
//  Copyright © 2015年 HCl. All rights reserved.
//

#import "FCTopBarView.h"
#import "UIView+Extension.h"
#define BaseTag		1024

@implementation FCTopBarView 
{
	NSInteger _tolCount;
	NSArray	*_items;
	UIImageView	*_thumbView;
}

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self)
	{
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
		self.backgroundColor = [UIColor yellowColor];
		_curIndex = 0;
	}
	return self;
}

- (void)setTitleArr:(NSArray *)titleArr {
	_titleArr = [titleArr copy];
	[self initSubViews];
}

- (void)initSubViews
{
	if (_titleArr.count <= 0)
		return;
	
	if (_items.count > 0) {
		[_items makeObjectsPerformSelector:@selector(removeFromSuperview)];
		_items = nil;
	}
	CGFloat itemsWidth = 80;
    if (itemsWidth*_titleArr.count<self.bounds.size.width) {
        itemsWidth = self.bounds.size.width / _titleArr.count;
    }
    self.contentMode = UIViewContentModeCenter;
    self.contentSize = CGSizeMake(_titleArr.count * itemsWidth, CGRectGetHeight(self.frame));
    self.delegate = self;
	NSMutableArray *temp = [[NSMutableArray alloc] init];
	for (int i = 0; i < _titleArr.count; i++)
	{
		NSString *title = [_titleArr objectAtIndex:i];
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		button.tag = BaseTag + i;
		[button setTitle:[NSString stringWithFormat:@"%@", title] forState:UIControlStateNormal];
		button.titleLabel.font = [UIFont systemFontOfSize:14];
		[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
		button.frame = CGRectMake(itemsWidth * i, 0, itemsWidth, self.bounds.size.height);
		button.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        CGSize size1 =[title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
        if (size1.width>itemsWidth-8) {
            NSString *str = [NSString stringWithFormat:@"%@...",[title substringWithRange:NSMakeRange(0, 4)]];
            [button setTitle:str forState:UIControlStateNormal];
        }
		[button addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        
		[self addSubview:button];
		[temp addObject:button];
        
        if (i == _curIndex) {
            button.selected = YES;
            for (UIView *v1 in [button subviews]) {
                if ([v1 isKindOfClass:[UIButton class]]) {
                    UIButton *but = (UIButton *)v1;
                    but.selected = button.selected;
                }
            }
            
        }
	}
	_items = temp;
	
    if (!_thumbView) {
        _thumbView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 2, 60, 2)];
        _thumbView.backgroundColor = [UIColor redColor];
        [self insertSubview:_thumbView atIndex:0];
    }
    [self updateThumbWithAnimate:NO];

}

- (void)updateThumbWithAnimate:(BOOL)animate
{
	
    CGFloat itemsWidth = 80;
    
    if (itemsWidth*_titleArr.count<self.bounds.size.width) {
        itemsWidth = self.bounds.size.width / _titleArr.count;
    }
	CGFloat centerX = _curIndex * itemsWidth + itemsWidth / 2;
	if (animate)
	{
		[UIView animateWithDuration:0.2 animations:^{
			_thumbView.centerX = centerX;
		}];
	}
	else
		_thumbView.centerX = centerX;
}

- (void)setTitle:(NSString*)title AtIndex:(NSInteger)index
{
	if (index < 0 || index > _items.count - 1)
		return;
	
	UIButton *button = [_items objectAtIndex:index];
	[button setTitle:[NSString stringWithFormat:@"%@", title] forState:UIControlStateNormal];
}

- (void)setThumbPos:(CGFloat)thumbPos {
    CGFloat itemsWidth = 80;
    
    if (itemsWidth*_titleArr.count<self.bounds.size.width) {
        itemsWidth = self.bounds.size.width / _titleArr.count;
    }
    _thumbView.centerX = itemsWidth * thumbPos + itemsWidth / 2;
    if (_thumbPos<=thumbPos) {
        if (self.contentOffset.x>itemsWidth*_thumbPos) {
            CGPoint po = CGPointMake(itemsWidth*_thumbPos, 0);
            self.contentOffset = po;
        }else {
            if (self.contentOffset.x+[UIScreen mainScreen].bounds.size.width<itemsWidth*_thumbPos+itemsWidth) {
                CGPoint po = CGPointMake(itemsWidth*(_thumbPos+1)-[UIScreen mainScreen].bounds.size.width, 0);
                self.contentOffset = po;
            }
        }
    }else {
        if ([UIScreen mainScreen].bounds.size.width<itemsWidth*_thumbPos-self.contentOffset.x) {
            CGPoint po = CGPointMake(itemsWidth*(_thumbPos+1)-[UIScreen mainScreen].bounds.size.width, 0);
            self.contentOffset = po;
        }else {
            if (self.contentOffset.x>itemsWidth*_thumbPos) {
                CGFloat hh;

                hh = itemsWidth*(_thumbPos);
                
                CGPoint po = CGPointMake(hh, 0);
                self.contentOffset = po;
                
            }
        }
        
    }
    
	_thumbPos = thumbPos;
	NSInteger index = roundf(thumbPos);
	if (index != _curIndex) {
		UIButton *oldSelBtn = _items[_curIndex];
		oldSelBtn.selected = NO;
        for (UIView *v in [oldSelBtn subviews]) {
            if ([v isKindOfClass:[UIButton class]]) {
                UIButton *but = (UIButton *)v;
                but.selected = oldSelBtn.selected;
            }
        }
		UIButton *selBtn = _items[index];
		selBtn.selected = YES;
        for (UIView *v1 in [selBtn subviews]) {
            if ([v1 isKindOfClass:[UIButton class]]) {
                UIButton *but = (UIButton *)v1;
                but.selected = selBtn.selected;
            }
        }
		_curIndex = index;
	}
    
    
}

- (void)setCurIndex:(NSInteger)curIndex {
	UIButton *oldSelBtn = _items[_curIndex];
	oldSelBtn.selected = NO;
    for (UIView *v in [oldSelBtn subviews]) {
        if ([v isKindOfClass:[UIButton class]]) {
            UIButton *but = (UIButton *)v;
            but.selected = oldSelBtn.selected;
        }
    }
	UIButton *selBtn = _items[curIndex];
	selBtn.selected = YES;
    for (UIView *v1 in [selBtn subviews]) {
        if ([v1 isKindOfClass:[UIButton class]]) {
            UIButton *but = (UIButton *)v1;
            but.selected = selBtn.selected;
        }
    }
	_curIndex = curIndex;
	[self updateThumbWithAnimate:YES];
}

- (void)tapAction:(id)sender
{
	UIButton *button = (UIButton*)sender;
	self.curIndex = button.tag - BaseTag;
	if (_didSelectedAt)
		_didSelectedAt(_curIndex);
}

@end
