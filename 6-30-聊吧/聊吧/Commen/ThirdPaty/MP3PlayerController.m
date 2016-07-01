//
//  MP3PlayerController.m
//  聊吧
//
//  Created by m on 16/6/30.
//  Copyright © 2016年 m. All rights reserved.
//

#import "MP3PlayerController.h"
#import "UIColor+AddColor.h"
#import "AVPlayerView.h"

#define ICONWIDTH 170
#define RADIUS 115
#define STATUS_KEYPATH @"status"
#define REFRESH_INTERVAL 0.5


@interface MP3PlayerController ()

@property (nonatomic,strong) AVPlayer *player;
@property (nonatomic,strong) UIImageView *icon;
@property (nonatomic,assign) NSInteger angle;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong)  UISlider *slider;
@property (nonatomic,strong) AVPlayerItem *playerItem;
@property (strong, nonatomic) id  playbackTimeObserver;
@property (assign,nonatomic) CGFloat  lastPlaybackRate;
@property (assign, nonatomic) CGFloat totalSecond;  // 所播放的视频的总秒数
@property (nonatomic,copy) NSString *allTime;


@end

@implementation MP3PlayerController {
    BOOL isplaying;
    BOOL _isStopAnimation;
    UILabel *timeLabel;
    NSDateFormatter *_dateFormatter;  // 时间格式
    CGFloat currentSliderValue;       // 当前播放进度值
    UIButton *playButton;
    BOOL isCanPlay;
    NSTimer *timer;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.mp3Name;
    
    //设置导航栏
    [self setNavigationBar];
    
    //设置背景视图
    [self setBackgroundImage];
    
    //创建圆盘
    [self createSingImage];

    //创建尾部控件
    [self createFooterView];
    
    //创建播放器
    [self createPlay];
    
    
}

#pragma mark - 设置导航栏
- (void)setNavigationBar {
    //左边返回按钮
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"up"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(leftItemAction:)];
    self.navigationItem.leftBarButtonItem = leftItem;
}

#pragma mark - 返回按钮点击事件
- (void)leftItemAction:(UIBarButtonItem *)item {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 设置背景图片
- (void)setBackgroundImage {
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:self.view.frame];
    backgroundView.image = [UIImage imageNamed:@"background.jpg"];
    [self.view addSubview:backgroundView];
}


#pragma mark - 尾部控件
- (void)createFooterView {
    
    //创建底部视图
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, kHeight - 100, kWidth, 100)];
    footerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:footerView];
    
    //时间
    timeLabel = [[UILabel alloc] init];
    timeLabel.text = @"00:00/03:33";
    timeLabel.textColor = [UIColor blackColor];
    timeLabel.font = [UIFont systemFontOfSize:12];
  
    //播放，暂停按钮
    playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    playButton.selected = YES;
    
    [playButton setBackgroundImage:[UIImage imageNamed:@"iconfont-bofang"] forState:UIControlStateNormal];
    
    [playButton setBackgroundImage:[UIImage imageNamed:@"iconfont-zanting"] forState:UIControlStateSelected];
    
    [playButton addTarget:self action:@selector(playBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //播放进度条
    self.slider = [[UISlider alloc] init];
    self.slider.backgroundColor = [UIColor clearColor];
    UIImage *thumImage = [UIImage imageNamed:@"record_secondBg"];
    [self.slider setThumbImage:thumImage forState:UIControlStateNormal];
    self.slider.maximumTrackTintColor = [UIColor whiteColor];
    [self.slider addTarget:self action:@selector(sliderChange) forControlEvents:UIControlEventValueChanged];
    [self.slider addTarget:self action:@selector(sliderChangeEnd) forControlEvents:UIControlEventTouchUpInside];
    [self.slider addTarget:self action:@selector(sliderbeginChange) forControlEvents:UIControlEventTouchDown];
    
    [footerView sd_addSubviews:@[timeLabel,playButton,self.slider]];
    
    //设置约束
    timeLabel.sd_layout.centerXEqualToView(footerView).topEqualToView(footerView).heightIs(15);
    [timeLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    playButton.sd_layout.leftSpaceToView(footerView,15).centerYEqualToView(footerView).heightIs(32).widthIs(32);
    
    self.slider.sd_layout.leftSpaceToView(playButton,10).centerYEqualToView(playButton).rightSpaceToView(footerView,10).heightIs(2);



}

#pragma mark - 播放、暂停按钮点击事件
- (void)playBtnAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        
        [self.player play];
        [timer invalidate];
        timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(startAnimation) userInfo:nil repeats:YES];
        
    }
    else {
        [self.player pause];
        [timer invalidate];
    }
    
}

#pragma mark - sliderAction
- (void)sliderChange
{
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
    [self addPlayerItemTimeObserver];
    if (self.lastPlaybackRate > 0.0f) {
        [self.player play];
    }
}


//设置中间圆盘
- (void)createSingImage
{
    self.icon = [[UIImageView alloc] init];
    self.icon.layer.cornerRadius = ICONWIDTH / 2;
    self.icon.layer.borderWidth = 3;
    self.icon.layer.borderColor = [[UIColor colorFromHexCode:@"#ffffff"] CGColor];
    self.icon.image = [UIImage imageNamed:@"background1.jpg"];
    self.icon.clipsToBounds = YES;
    [self.view addSubview:self.icon];
    
    self.icon.sd_layout.heightIs(ICONWIDTH).widthIs(ICONWIDTH).centerYEqualToView(self.view).centerXEqualToView(self.view);
}

#pragma mark - 创建播放器
- (void)createPlay {
    //查找文件是否存在
    BOOL exsist = [[NSFileManager defaultManager] fileExistsAtPath:self.mp3URL.path];
    if (!exsist) {
        return;
    }
    self.playerItem = [AVPlayerItem playerItemWithURL:self.mp3URL];
    
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    
    [self.player play];
    
    //监听status属性
    [self.playerItem addObserver:self forKeyPath: STATUS_KEYPATH options:NSKeyValueObservingOptionNew context:nil];
    //监听播放速度
    [self.player addObserver:self forKeyPath:@"rate" options:NSKeyValueObservingOptionNew context:nil];
  
}

#pragma mark - 视图将要消失时
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //停止播放
    [self.player pause];
    [self.timer invalidate];
    _isStopAnimation = YES;
    
    [timer invalidate];
    //移除观察者
    [self.player removeObserver:self forKeyPath:@"rate"];
    [self.playerItem removeObserver:self forKeyPath:STATUS_KEYPATH];
    [self.player removeTimeObserver:self.playbackTimeObserver];
}

//开启旋转动画
- (void)startAnimation
{
    __block MP3PlayerController *play = self;
    
    [UIView animateWithDuration:1
                     animations:^{
            play.icon.transform = CGAffineTransformRotate(play.icon.transform, M_PI/90);
                     }];
    
}


#pragma mark - 定时器监听事件
- (void)timerStart
{
    CMTime durationTime = self.player.currentItem.duration;
    if (CMTIME_IS_INVALID(durationTime)) {
        timeLabel.text = @"";
        [self.timer invalidate];
    }
    int duration = [[NSString stringWithFormat:@"%lf",CMTimeGetSeconds(durationTime)] intValue];
    int current = [[NSString stringWithFormat:@"%lf",CMTimeGetSeconds(self.player.currentItem.currentTime)] intValue];
    
    timeLabel.text = [NSString stringWithFormat:@"%d:%.2d/%d:%.2d",current/60,current%60,duration/60,duration%60];
    
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
            [self addPlayerItemTimeObserver];
            // 获取视频总长度
            CMTime duration = self.playerItem.duration;
            // 转换成秒
            CGFloat totalSecond = avplayer.duration.value / avplayer.duration.timescale;
            self.totalSecond = totalSecond;
            _allTime = [self convertTime:totalSecond];
            NSString *current = [self convertTime:0.0];
            timeLabel.text = [NSString stringWithFormat:@"%@/%@",current,_allTime];
            // 自定义UISlider外观
            [self customVideoSlider:duration];
            NSLog(@"%ld正在播放",(long)avplayer.status);

            //开启动画
//            if (self.slider.value <= self.slider.maximumValue) {
//              timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(startAnimation) userInfo:nil repeats:YES];
//            }
            
        }else{
            
            NSLog(@"%ld播放失败",(long)avplayer.status);
            NSLog(@"%@",avplayer.error);
        }
        
    }else if([keyPath isEqualToString:@"rate"]){
        NSLog(@"播放时间");
        NSLog(@"%f",self.slider.value);
        if (self.slider.value == self.slider.maximumValue) {
            NSLog(@"播放结束");
            timeLabel.text = [NSString stringWithFormat:@"%@/%@",@"0.00",_allTime];
            self.slider.value = 0;
            [timer invalidate];
            [playButton setImage:[UIImage imageNamed:@"iconfont-zanting"] forState:UIControlStateNormal];
            
        }
        NSString *currentTime = [self convertTime:self.slider.value];
        timeLabel.text = [NSString stringWithFormat:@"%@/%@",currentTime,_allTime];
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


- (void)customVideoSlider:(CMTime)duration {
    CGFloat maxvalue = CMTimeGetSeconds(duration);
    if (isnan(maxvalue)) {
        maxvalue = 0.f;
    }
    self.slider.maximumValue = maxvalue;
    UIGraphicsBeginImageContextWithOptions((CGSize){ 1, 1 }, YES, 0.0f);
    
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

- (void)setCurrentTime:(NSTimeInterval)time duration:(NSTimeInterval)duration {
    NSString *currentTime = [self convertTime:time];
    timeLabel.text = [NSString stringWithFormat:@"%@/%@",currentTime,_allTime];
    self.slider.value = time;
}


@end
