//
//  RequestLoadingView.m
//  ThankYou
//
//  Created by lizzy on 16/6/6.
//  Copyright © 2016年 2011-2013 湖南长沙阳环科技实业有限公司 @license http://www.yhcloud.com.cn. All rights reserved.
//


#import "RequestLoadingView.h"
#import "LoadingView.h"

@interface RequestLoadingView()

@property(nonatomic,strong)  LoadingView * loadingView;

@end

@implementation RequestLoadingView
@synthesize loadingView = _loadingView;

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor colorWithHex:0x999999 alpha:0.8];
        [self addSubview:self.loadingView];
    }
    return self;
}

#pragma mark -
#pragma mark Private Method
- (void)show
{
    self.alpha = 0.0f;
    [UIView animateWithDuration:.20f animations:^{
        self.alpha = 1.0f;
    }];
    [_loadingView startAnimation];
}
- (void)dissmiss
{
    [_loadingView stopAnimation];
}

#pragma mark -
#pragma mark setter & getter
- (LoadingView *)loadingView
{
    if (!_loadingView)
    {
        _loadingView = [[LoadingView alloc]initWithFrame:CGRectMake((self.bounds.size.width-100)/2,(self.bounds.size.height-100)/2, 100, 100)];
    }
    return _loadingView;
}
@end
