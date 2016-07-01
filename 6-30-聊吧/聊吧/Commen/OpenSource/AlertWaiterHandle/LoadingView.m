//
//  LoadingView.m
//  ThankYou
//
//  Created by lizzy on 16/6/6.
//  Copyright © 2016年 2011-2013 湖南长沙阳环科技实业有限公司 @license http://www.yhcloud.com.cn. All rights reserved.
//

#import "LoadingView.h"
#import "waveView.h"

static NSString * kImageViewRotationKey = @"rotationAnimation";
static CGFloat kRotationAnimationDuration = 1.5f;

@interface LoadingView()
@property(nonatomic,strong) UIImageView *rotationImageView;
@property(nonatomic,strong) waveView *wavView;
@end

@implementation LoadingView
@synthesize rotationImageView = _rotationImageView;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _wavView = [[waveView alloc]initWithFrame:CGRectMake(5,5, self.bounds.size.width-10, self.bounds.size.height-10)];
        [self addSubview:_wavView];
        self.rotationImageView.frame = self.bounds;
        [self addSubview:_rotationImageView];
    }
    return self;
}

#pragma mark -
#pragma mark Private Methods

- (void)stopAnimation
{
    [_wavView stopAnimation];
    [_rotationImageView.layer removeAllAnimations];
}

- (void)startAnimation
{
    [_wavView startAnimation];
    CABasicAnimation * transformRoate = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    transformRoate.byValue = [NSNumber numberWithDouble:(2 * M_PI)];
    transformRoate.duration = kRotationAnimationDuration;
    transformRoate.repeatCount = MAXFLOAT;
    [self.rotationImageView.layer addAnimation:transformRoate forKey:kImageViewRotationKey];
}

#pragma mark -
#pragma mark setter & getter
- (UIImageView *)rotationImageView
{
    if (!_rotationImageView)
    {
        _rotationImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"fb_rotation"]];
    }
    return  _rotationImageView;
}
@end

