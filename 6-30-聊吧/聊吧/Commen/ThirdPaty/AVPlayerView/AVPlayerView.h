//
//  AVPlayerView.h
//  AVPlayer
//
//  Created by DBB on 16/5/23.
//  Copyright © 2016年 DBB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#define REFRESH_INTERVAL 0.5

@interface AVPlayerView : UIView

@property (nonatomic ,strong) AVPlayer *player;
@property (nonatomic ,strong) AVPlayerItem *playerItem;
@property (nonatomic,copy)NSString *titlestr;
@property (nonatomic,copy)NSString *backtitle;
@property (nonatomic,strong) NSURL *videoUrl;


- (void)playurl ;



+(instancetype)sharAVPlayer;
@end
