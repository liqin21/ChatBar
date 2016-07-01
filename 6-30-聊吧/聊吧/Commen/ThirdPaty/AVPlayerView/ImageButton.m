//
//  ImageButton.m
//  ESong
//
//  Created by liyonghong on 16/3/31.
//  Copyright © 2016年 KEHAN. All rights reserved.
//

#import "ImageButton.h"

@interface ImageButton()
{
    NSMutableDictionary *dicBackgroundColor;
    NSMutableDictionary *dicImage;
    NSMutableDictionary *dicBackgroundImage;
    NSMutableDictionary *dicText;
    NSMutableDictionary *dicTextColor;
}

@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UIImageView *backgroundImageView;
@property (nonatomic) UILabel *label;

@end


@implementation ImageButton

- (id)init {
    self = [super init];
    if (!self)
        return self;
    
    self.backgroundImageView = [[UIImageView alloc] init];
    [self addSubview:self.backgroundImageView];
    
    self.imageView = [[UIImageView alloc] init];
    [self addSubview:self.imageView];
    
    self.label = [[UILabel alloc] init];
    self.label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.label];
    
    dicBackgroundColor = [@{} mutableCopy];
    dicBackgroundImage = [@{} mutableCopy];
    dicImage = [@{} mutableCopy];
    dicText = [@{} mutableCopy];
    dicTextColor = [@{} mutableCopy];
    
    [self addTarget:self action:@selector(TouchDown) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(TouchUp) forControlEvents:UIControlEventTouchCancel];
    [self addTarget:self action:@selector(TouchUp) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(TouchUp) forControlEvents:UIControlEventTouchUpOutside];
    [self addTarget:self action:@selector(TouchUp) forControlEvents:UIControlEventTouchDragOutside];
    
    return self;
}


- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    self.backgroundImageView.frame = self.bounds;
    self.imageView.frame = self.bounds;
    self.label.frame = self.bounds;
}


- (void)setContentMode:(UIViewContentMode)contentMode {
    [super setContentMode:contentMode];
    
    self.imageView.contentMode = contentMode;
    self.backgroundImageView.contentMode = contentMode;
}


- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    [self updateView];
}


- (void)setText:(NSString *)text forState:(UIControlState)state {
    [dicText setObject:text forKey:@(state)];
    [self updateView];
}


- (void)setTextColor:(UIColor *)color forState:(UIControlState)state {
    [dicTextColor setObject:color forKey:@(state)];
    [self updateView];
}


- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    [dicImage setObject:image forKey:@(state)];
    [self updateView];
}


- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    [dicBackgroundColor setObject:backgroundColor forKey:@(state)];
    [self updateView];
}


- (void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state {
    [dicBackgroundImage setObject:image forKey:@(state)];
    [self updateView];
}


- (void)TouchDown {
    self.highlighted = YES;
    [self updateView];
}


- (void)TouchUp {
    self.highlighted = NO;
    [self updateView];
}


- (void)updateView {
    self.imageView.image = [self getObjectFrom: dicImage WithState: self.state];
    self.backgroundImageView.image = [self getObjectFrom:dicBackgroundImage WithState:self.state];
    self.backgroundColor = [self getObjectFrom: dicBackgroundColor WithState: self.state];
    self.label.text = [self getObjectFrom:dicText WithState:self.state];
    self.label.textColor = [self getObjectFrom:dicTextColor WithState:self.state];
}


- (id)getObjectFrom: (NSDictionary *)dict WithState: (UIControlState)state {
    if ([dict objectForKey:@(state)])
        return [dict objectForKey:@(state)];
    else if ((state & UIControlStateSelected) && [dict objectForKey:@(UIControlStateSelected)])
        return [dict objectForKey:@(UIControlStateSelected)];
    else if ((state & UIControlStateHighlighted) && [dict objectForKey:@(UIControlStateHighlighted)])
        return [dict objectForKey:@(UIControlStateHighlighted)];
    else
        return [dict objectForKey:@(UIControlStateNormal)];
}


@end
