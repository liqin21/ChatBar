//
//  waveView.m
//  waveTest
//
//  Created by lizzy on 15/8/20.
//  Copyright (c) 2015年 lizzy. All rights reserved.
//

#import "waveView.h"

static NSString *const kcellMoveKey = @"waveMoveAnimation";

static CGFloat kWaveAnimationDuration = 1;/**<波浪动画持续时间*/
static CGFloat kWaveWidthPadding = 150;/**<波浪图的边缘位移*/
static CGFloat kWaveTimeInterval = 0.05f;/**<定时器刷新图片高度频率*/

@interface waveView()
{
    CGFloat waveOffset;
}
@property(nonatomic,strong) UIImageView *waveImageView;
@property(nonatomic,strong) NSTimer *waveTimer;
@property(nonatomic,assign) BOOL isGoon;
@end

@implementation waveView
@synthesize waveImageView = _waveImageView, waveTimer = _waveTimer;

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setUp];
    }
    return self;
}

#pragma mark -
#pragma mark setup 
-(void)setUp
{
    self.layer.cornerRadius = self.bounds.size.height/2;
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = YES;
    UIImageView *backGround = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,self.bounds.size.width+23,self.bounds.size.height+23)];
    backGround.image = [UIImage imageNamed:@"login_user"];
    [self addSubview:backGround];
    backGround.center = CGPointMake(self.bounds.size.width/2+1, self.bounds.size.height/2-1);
    
    self.waveImageView.frame = CGRectMake(-kWaveWidthPadding,0, self.bounds.size.width+(kWaveWidthPadding*2), self.bounds.size.height);
    [self addSubview:self.waveImageView];
    _waveImageView.center = backGround.center;
    waveOffset = 0;
}

#pragma mark -
#pragma mark Action Response
-(void)startAnimation
{
    _waveTimer = [NSTimer scheduledTimerWithTimeInterval:kWaveTimeInterval target:self selector:@selector(upAndDownWaveImageView) userInfo:nil repeats:YES];
    CAKeyframeAnimation * moveAction = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    moveAction.values = [NSArray arrayWithObjects:[NSNumber numberWithFloat:_waveImageView.layer.position.x-kWaveWidthPadding+3],[NSNumber numberWithFloat:_waveImageView.layer.position.x+kWaveWidthPadding-3],nil];
    moveAction.duration = kWaveAnimationDuration;
    moveAction.repeatCount = MAXFLOAT;
    moveAction.autoreverses = YES;
    [self.waveImageView.layer addAnimation:moveAction forKey:kcellMoveKey];
}

- (void)upAndDownWaveImageView
{
    CGRect rect = _waveImageView.frame;
    rect.origin.y = waveOffset;
    _waveImageView.frame = rect;
    waveOffset -= 1;
    if (waveOffset <= -self.bounds.size.height-2)
    {
        waveOffset = 0;
    }
}

- (void)stopAnimation
{
    [_waveImageView.layer removeAllAnimations];
    [_waveTimer invalidate];
    _waveTimer = nil;
    waveOffset = 0;
}

#pragma mark -
#pragma mark setter & getter

-(UIImageView *)waveImageView
{
    if (!_waveImageView)
    {
        _waveImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"fb_wave"]];
    }
    return _waveImageView;
}

@end
