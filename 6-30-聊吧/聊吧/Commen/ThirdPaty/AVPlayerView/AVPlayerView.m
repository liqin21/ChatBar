//
//  AVPlayerView.m
//  AVPlayer
//
//  Created by DBB on 16/5/23.
//  Copyright © 2016年 DBB. All rights reserved.
//

#import "AVPlayerView.h"
#import "ImageButton.h"

@interface AVPlayerView()
@property (nonatomic ,strong) UIView *topView;
@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UIWindow *window;
@property (nonatomic,strong)UIProgressView *progess;
@property (nonatomic,strong)UISlider *slider;
@property (nonatomic,strong)ImageButton *playbut;
@property (nonatomic,strong)UIButton *playbbut;
@property (nonatomic,strong)UILabel *playedlab;
@property (nonatomic,strong)UILabel *playlab;
@property (assign, nonatomic) CGFloat totalSecond;  // 所播放的视频的总秒数
@property (assign,nonatomic) CGFloat  lastPlaybackRate;
@property (strong,nonatomic) UIButton *backbut;
@property (strong, nonatomic) id     playbackTimeObserver;
@property (nonatomic,strong)UIPanGestureRecognizer *gesturpan;
@property (nonatomic,strong)UILabel *titlelab;
@property (nonatomic,strong)UILabel *backlab;

@end

@implementation AVPlayerView{
    NSDateFormatter *_dateFormatter;  // 时间格式
    CGFloat currentSliderValue;       // 当前播放进度值

}



#define STATUS_KEYPATH @"status"

+ (Class)layerClass {
    
    return [AVPlayerLayer class];
}

- (AVPlayer *)player {
    
    return [(AVPlayerLayer *)[self layer] player];
}

- (void) setPlayer:(AVPlayer *)player
{
    [(AVPlayerLayer *)[self layer] setPlayer:player];
}
- (id)initWithFrame:(CGRect)frame{
     _window = [UIApplication   sharedApplication].keyWindow;
    self.backgroundColor = [UIColor blackColor];
    frame = _window.bounds;

    self = [super initWithFrame:frame];
    
//    self.transform = CGAffineTransformMakeRotation(M_PI/2);
    if (self) {
//        初始化视图
        [self initView];
    }
    return self;
}

- (void)initView{
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
    _topView.backgroundColor = [UIColor blackColor];
    _topView.alpha = 0.5;
    _backbut = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backbut setImage:[UIImage imageNamed:@"videoback"] forState:UIControlStateNormal];
    _backbut.frame = CGRectMake(10, 11, 100, 23);
    _backbut.titleLabel.font = [UIFont systemFontOfSize:14];
    [_backbut addTarget:self action:@selector(goBackto) forControlEvents:UIControlEventTouchUpInside];
    _titlelab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, _topView.frame.size.width, 25)];
    _backlab = [[UILabel alloc] initWithFrame:CGRectMake(40, 12, 100, 30)];;
    [_backlab setTextColor:[UIColor whiteColor]];
    _backlab.font = [UIFont systemFontOfSize:14];
    [_titlelab setTextColor:[UIColor whiteColor]];
    _titlelab.textAlignment = NSTextAlignmentCenter;
    [_topView addSubview:_titlelab];
    [_topView addSubview:_backbut];
//    [_topView addSubview:_backlab];
    
    
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0,self.frame.size.height-30, self.frame.size.width, 50)];
    _bottomView.backgroundColor = [UIColor blackColor];
    _bottomView.alpha = 0.5;
    
    _progess = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 2)];
    [_progess setProgressTintColor:[UIColor whiteColor]];
    [_progess setProgress:0];
    [_bottomView addSubview:_progess];
    
    // 播放条
    self.slider = [[UISlider alloc] init];
    self.slider.backgroundColor = [UIColor clearColor];
    [_bottomView addSubview:self.slider];
    self.slider.frame = CGRectMake( 0, 0, self.frame.size.width, 2);

//    self.slider.minimumTrackTintColor = UIColorHex(0x1983fd);
    UIImage *thumbImage = [UIImage imageNamed:@"record_secondBg"];
    [self.slider setThumbImage:thumbImage forState:UIControlStateHighlighted];
    [self.slider setThumbImage:thumbImage forState:UIControlStateNormal];
    self.slider.maximumTrackTintColor = [UIColor clearColor];
    [self.slider addTarget:self action:@selector(sliderChange) forControlEvents:UIControlEventValueChanged];
    [self.slider addTarget:self action:@selector(sliderChangeEnd) forControlEvents:UIControlEventTouchUpInside];
    [self.slider addTarget:self action:@selector(sliderbeginChange) forControlEvents:UIControlEventTouchDown];
    
    _playbut = [[ImageButton alloc] init];
    //_playbut.frame = CGRectMake(35, 12, 25, 25);
    _playbut.frame = CGRectMake(30, 5, 40, 40);
    _playbut.contentMode = UIViewContentModeCenter;
    [_playbut setImage:[UIImage imageNamed:@"play"] forState:UIControlStateSelected];
    [_playbut setImage:[UIImage imageNamed:@"pase"] forState:UIControlStateNormal];
    _playbut.tag = 100;
    [_playbut addTarget:self action:@selector(playmovie:) forControlEvents:UIControlEventTouchUpInside];
    _playbut.selected = NO;
    [_bottomView addSubview:_playbut];
    
    
    _playbbut = [UIButton buttonWithType:UIButtonTypeCustom];
    _playbbut.frame = CGRectMake(self.frame.size.width/2, self.frame.size.height/2, 50, 50);
    [_playbbut setImage:[UIImage imageNamed:@"playbig"] forState:UIControlStateSelected];
    [_playbbut setImage:[UIImage imageNamed:@"pasebig"] forState:UIControlStateNormal];

    _playbbut.center = self.center;
    _playbbut.tag = 101;
    [_playbbut addTarget:self action:@selector(playmovie:) forControlEvents:UIControlEventTouchUpInside];
    _playbbut.selected = NO;
    [self addSubview:_playbbut];
    
    _playedlab = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 60, 30)];
    UIView *withe = [[UIView alloc] initWithFrame:CGRectMake(153, 16, 2, 18)];
    withe.backgroundColor = [UIColor whiteColor];
    _playedlab.textColor = [UIColor whiteColor];
    _playlab = [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 100, 30)];
    _playlab.textColor = [UIColor whiteColor];
    [_bottomView addSubview:_playedlab];
    [_bottomView addSubview:_playlab];
    [_bottomView addSubview:withe];
    
    [self addSubview:_topView];
    [self addSubview:_bottomView];
    
//    添加手势
    _gesturpan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self addGestureRecognizer:_gesturpan];
}

- (void)goBackto{
    [UIApplication sharedApplication].statusBarHidden = NO;
    self.transform = CGAffineTransformIdentity;
    [self removeFromSuperview];
    [self.player pause];
    [self removeKVOAndNoti];
}

- (void)playurl {
    [UIApplication sharedApplication].statusBarHidden = YES;
    self.backgroundColor = [UIColor blackColor];

    [self showMovieTool];
    [self performSelector:@selector(delayToHideMovieTool) withObject:nil afterDelay:3];
    [UIView animateWithDuration:.5 animations:^{
        self.transform = CGAffineTransformMakeRotation(M_PI/2);
        [_window addSubview:self];
        self.frame = _window.bounds;
        _bottomView.frame = CGRectMake(0, self.frame.size.width-50, self.frame.size.height, 56);
        self.slider.frame = CGRectMake(0, 0, _bottomView.frame.size.width, 2);
        self.progess.frame = CGRectMake(0, 0, _bottomView.frame.size.width, 1);
        _playbbut.center = CGPointMake(self.frame.size.height/2, self.frame.size.width/2);
        _topView.frame = CGRectMake(0, 0, self.frame.size.height, 45);
        _titlelab.center = _topView.center;
        _playbut.frame = CGRectMake(30, 5, 40, 40);

    }];
    _playbut.selected = NO;
//    本地播放视频
//    NSURL *videoUrl = [NSURL fileURLWithPath:urlstr];
    self.playerItem = [AVPlayerItem playerItemWithURL:_videoUrl];
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];

    [self.playerItem addObserver:self forKeyPath:STATUS_KEYPATH options:NSKeyValueObservingOptionNew context:nil];// 监听status属性
    [self.player addObserver:self forKeyPath:@"rate" options:NSKeyValueObservingOptionNew context:nil];// 监听播放速度
}

//----KVO监听方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    AVPlayerItem *avplayer =(AVPlayerItem *)object;
    
//    playerItem的3种属性
    if ([keyPath isEqualToString:STATUS_KEYPATH]) {
//        播放状态
        NSLog(@"%ld",(long)avplayer.status);
        if (avplayer.status == AVPlayerItemStatusUnknown ) {
            NSLog(@"%ld未知播放源",(long)avplayer.status);
        }else if (avplayer.status == AVPlayerItemStatusReadyToPlay){
            [self.player play];
            [self addPlayerItemTimeObserver];
            // 获取视频总长度
            CMTime duration = self.playerItem.duration;
            // 转换成秒
            CGFloat totalSecond = avplayer.duration.value / avplayer.duration.timescale;
            self.totalSecond = totalSecond;
            self.playlab.text = [self convertTime:totalSecond];
            self.playedlab.text = [self convertTime:0.0];
            // 自定义UISlider外观
            [self customVideoSlider:duration];
             NSLog(@"%ld正在播放",(long)avplayer.status);
        }else{
        
            NSLog(@"%ld播放失败",(long)avplayer.status);
            NSLog(@"%@",avplayer.error);
        }

    }else if([keyPath isEqualToString:@"rate"]){
        NSLog(@"播放时间");
        NSLog(@"%f",self.slider.value);
        
        if (self.slider.value == self.slider.maximumValue) {
            NSLog(@"播放结束");
            [self toChangeVideoProgresswith:0.00 updow:NO];
            self.playedlab.text = [self convertTime:0.00];
          
        }
        _playedlab.text = [self convertTime:self.slider.value];
    }
    
}

- (void)removeKVOAndNoti{
    [self.player removeObserver:self forKeyPath:@"rate"];
    [self.playerItem removeObserver:self forKeyPath:STATUS_KEYPATH];
    [self.player removeTimeObserver:self.playbackTimeObserver];
}

static AVPlayerView *avPlayview;

+(instancetype)sharAVPlayer{
    static dispatch_once_t onceToke;
    dispatch_once(&onceToke, ^{
        avPlayview = [[AVPlayerView alloc] init];
        assert(avPlayview != nil);
    });
    return avPlayview;
}

- (void)playmovie:(UIButton *)button{
    button.selected  = !button.selected;
    _playbbut.selected = button.selected;
    _playbut.selected = button.selected;
    if (button.selected) {
        [self.player pause];
    }else{
    
        [self.player play];
    }
}


#pragma mark -  时间字符处理
- (NSString *)convertTime:(CGFloat)second{
    
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    if (second/3600 >= 1) {
        [[self dateFormatter] setDateFormat:@"HH:mm:ss"];
    } else {
        [[self dateFormatter] setDateFormat:@"mm:ss"];
    }
    
    NSString *showtimeNew = [[self dateFormatter] stringFromDate:d];
    return showtimeNew;
    
}
- (NSDateFormatter *)dateFormatter {
    
    if (!_dateFormatter) {
        
        _dateFormatter = [[NSDateFormatter alloc] init];
    }
    return _dateFormatter;
}

- (void)panAction:(UIPanGestureRecognizer *)pan
{
    
    //    CGFloat width = (kAllHeight > kScreenWidth ? kAllHeight : kScreenWidth);
    
    static BOOL dirtection;
    static BOOL hasdirtection;
    
    if (pan.state == UIGestureRecognizerStateBegan) {
//        [self.player removeTimeObserver:self.playbackTimeObserver];
        currentSliderValue = self.slider.value;
        self.lastPlaybackRate = self.player.rate;

    }else if ( pan.state == UIGestureRecognizerStateChanged) {
        [self showMovieTool];
        CGPoint point = [pan translationInView:self];
        
        if ((fabs(point.x) >3 || fabs(point.y)>3) && !hasdirtection) {
            
            hasdirtection = YES;
            
            if (fabs(point.x) >= fabs(point.y)) {
                
                dirtection = YES;
            }else {
                dirtection = NO;
            }
            
        }else if (hasdirtection){
            
            if (dirtection) {
                
//                [self.player pause];
                
                CGFloat xTox_leng = point.x;
                
                if (xTox_leng != 0.0) {
                    
                    // 可改变的最大时间：视频总长度
                    CGFloat second_chang = currentSliderValue + (self.totalSecond / self.slider.frame.size.width) * xTox_leng;//a + (xTox_leng / self.slider.frame.size.width) * self.totalSecond;
                    
                    if (second_chang <= self.totalSecond ) {
                        
                        static CGFloat lastindex = 0;
                        
                        BOOL updow;
                        if (point.x > lastindex) {
                            updow = YES;
                        }else {
                            updow = NO;
                        }
                        [self toChangeVideoProgresswith:second_chang updow:updow];
                        
                        lastindex = point.x;
                    }
                }
            }
        }
        
    }else if ( pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled || pan.state == UIGestureRecognizerStateFailed) {
        _playedlab.text = [self convertTime:self.slider.value];
        hasdirtection = NO;
        dirtection    = NO;
        [self delayToHideMovieTool];
        // 滑动结束 添加时间监听
//        [self sliderChangeEnd];
        self.bottomView.alpha = 0;
        self.topView.alpha = 0;
        self.playbbut.alpha = 0;
//        [self.player play];
//        _playbbut.selected = NO;
//        _playbut.selected = NO;
    
    }
}


#pragma mark - panAction
-(void)delayToHideMovieTool
{
    [UIView animateWithDuration:0.2 animations:^{
        self.topView.alpha = 0;
        self.bottomView.alpha = 0;
        self.playbbut.alpha = 0;
    }];
}

- (void)showMovieTool
{
    self.topView.alpha = .5;
    self.bottomView.alpha = .5;
    self.playbbut.alpha = 1;
}

#pragma mark - sliderAction
- (void)sliderChange
{
    [self showMovieTool];
    [self.playerItem cancelPendingSeeks];
    [self.player seekToTime:CMTimeMakeWithSeconds(self.slider.value, NSEC_PER_SEC) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
}

- (void)sliderbeginChange
{
    self.lastPlaybackRate = self.player.rate;
    [self.player removeTimeObserver:self.playbackTimeObserver];

    [self.player pause];
}

- (void)sliderChangeEnd
{
    [self delayToHideMovieTool];
    [self addPlayerItemTimeObserver];

    if (self.lastPlaybackRate > 0.0f) {
        [self.player play];
    }
}

- (void)toChangeVideoProgresswith:(CGFloat)second_chang updow:(BOOL)is_updown
{
    if (second_chang + self.slider.value < 0.0) {
        
        NSLog(@"error: slider值超过范围");
    }else {
        
            CMTime changedTime = CMTimeMakeWithSeconds(second_chang, 1);
            [self.slider setValue:second_chang];
            [self.player seekToTime:changedTime completionHandler:^(BOOL finished) {
            }];
            
    }
}

- (void)customVideoSlider:(CMTime)duration {
    CGFloat maxvalue = CMTimeGetSeconds(duration);
    if (isnan(maxvalue)) {
        maxvalue = 0.f;
    }
    self.slider.maximumValue = maxvalue;
    UIGraphicsBeginImageContextWithOptions((CGSize){ 1, 1 }, YES, 0.0f);
    
}

// 隐藏控制面板
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(delayToHideMovieTool) object:nil];
    if (self.bottomView.alpha == 0) {
        
        [self performSelector:@selector(delayToHideMovieTool) withObject:nil afterDelay:1.5f inModes:@[NSRunLoopCommonModes]];
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        if (self.bottomView.alpha == 0.5) {
            [self delayToHideMovieTool];
        }else{
            [self showMovieTool];
        }
    } completion:^(BOOL finished) {
        
    }];
}


- (void)addPlayerItemTimeObserver
{
    // Create 0.5 second refresh interval - REFRESH_INTERVAL == 0.5
    CMTime interval =
    CMTimeMakeWithSeconds(REFRESH_INTERVAL, NSEC_PER_SEC);
    // Main dispatch queue
    dispatch_queue_t queue = dispatch_get_main_queue();
    // Create callback block for time observer
    void (^callback)(CMTime time) = ^(CMTime time) {
        NSTimeInterval currentTime = CMTimeGetSeconds(time);
        NSTimeInterval duration = CMTimeGetSeconds(self.playerItem.duration);
        [self setCurrentTime:currentTime duration:duration];      };
    
    // Add observer and store pointer for future use
    self.playbackTimeObserver =
    [self.player addPeriodicTimeObserverForInterval:interval
                                              queue:queue
                                         usingBlock:callback];
}
- (void)setTitlestr:(NSString *)titlestr{
    _titlelab.text = titlestr;
}
- (void)setBacktitle:(NSString *)backtitle{
    NSString *str = [@"  " stringByAppendingString:backtitle];
    [_backbut setTitle:str forState:UIControlStateNormal];
}


- (void)setCurrentTime:(NSTimeInterval)time duration:(NSTimeInterval)duration {
    self.playedlab.text = [self convertTime:time];
    self.slider.value = time;
}

-(BOOL)prefersStatusBarHidden{
    return YES; // 返回NO表示要显示，返回YES将hiden
}
@end
