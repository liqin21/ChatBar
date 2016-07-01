//
//  FCPhotoContainerView.m
//  聊吧
//
//  Created by m on 16/5/28.
//  Copyright © 2016年 m. All rights reserved.
//

#import "FCPhotoContainerView.h"
#import "SDPhotoBrowser.h"


@interface FCPhotoContainerView ()<SDPhotoBrowserDelegate>

@end

@implementation FCPhotoContainerView 

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //进行图片的布局
        [self setUp];
    }
    return self;
}

- (void)setUp {
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    //循环创建9张图片
    for (int i = 0; i < 9; i ++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.tag = i;
        
        //加一个图片的点击手势
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [imageView addGestureRecognizer:tap];
        //把创建的图片添加到数组中
        [temp addObject:imageView];
    }

    self.imageViewArray = [temp copy];
    
    
}

//设置图片的时候调用
- (void)setPicPathStringArray:(NSArray *)picPathStringArray {
    _picPathStringArray = picPathStringArray;
    
    //1.如果图片的张数小于9，则隐藏创建的多余的imageView
    for (long i = _picPathStringArray.count; i < self.imageViewArray.count; i ++) {
        UIImageView *imageView = [self.imageViewArray objectAtIndex:i];
        imageView.hidden = YES;
    }
    
    //2.当图片的数量为0的时候，高度设置为0
    if (_picPathStringArray.count == 0) {
        self.height = 0;
        self.fixedHeight = @(0);
        return;
    }
    
    //3.计算图片的宽度
    CGFloat itemW = [self itemWidthForPicPathArray:_picPathStringArray];
    CGFloat itemH = 0;
    
    //如果图片的数量为1时,设置图片宽和高等比例缩放
    UIImage *image = [UIImage imageNamed:_picPathStringArray.firstObject];
    if (_picPathStringArray.count == 1) {
        if (image.size.width) {
            itemH = image.size.width / image.size.height *itemW;
        }
    }
    else {
        //如果图片的数量大于1，则宽和高相等
        itemH = itemW;
    }
    
    //4.计算每一行的图片数量
    long eachLineItemCount = [self eachLineItemCountForPicpathArray:_picPathStringArray];
    CGFloat margin = 3;
    
    //遍历数组
    [_picPathStringArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //计算列的索引
        long columnIndex = idx % eachLineItemCount;
        //计算行的索引
        long rowIndex = idx / eachLineItemCount;
        
        //获取创建的视图
        UIImageView *imageView = [_imageViewArray objectAtIndex:idx];
        imageView.hidden = NO;
        imageView.image = [UIImage imageNamed:obj];
        
        //设置图片的frame
        imageView.frame = CGRectMake(columnIndex * (itemW + margin), rowIndex * (itemH + margin), itemW, itemH);
    }];
    
    //计算宽度
    CGFloat width = eachLineItemCount *itemW + (eachLineItemCount - 1) * margin;
    //获取行的数量
    int rowConut = ceilf(_picPathStringArray.count * 1.0 / eachLineItemCount);
    //计算高度
    CGFloat height = rowConut * itemH + (rowConut - 1) *margin;
    
    //设置宽度和高度
    self.width = width;
    self.height = height;
    
    //设置自适应高度
    self.fixedWidth = @(width);
    self.fixedHeight = @(height);

}

#pragma mark - 每一张图片的宽度
- (CGFloat)itemWidthForPicPathArray:(NSArray *)array {
    if (array.count == 1) {
        return 200;
    }
    else {
        CGFloat width = kWidth > 320 ? 95 : 85;
        return width;
    }
}


#pragma mark - 每一行是图片数量
- (NSInteger)eachLineItemCountForPicpathArray:(NSArray *)array {
    if (array.count <= 3) {
        return array.count;
    }
    if (array.count == 4) {
        return 2;
    }
    else {
        return 3;
    }
}


#pragma mark - 图片的点击事件
- (void)tapAction:(UITapGestureRecognizer *)tap {
    UIView *imageView = tap.view;
    //创建浏览器
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    //设置当前浏览的图片的索引
    browser.currentImageIndex = imageView.tag;
    //设置当前图片所在的视图
    browser.sourceImagesContainerView = self;
    //设置浏览图片的个数
    browser.imageCount = self.picPathStringArray.count;
    //设置代理
    browser.delegate = self;
    [browser show];
}

#pragma mark - 图片浏览器的代理方法

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index {
    
    UIImageView *imageView = self.subviews[index];
    return imageView.image;
    
}



- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index {
    
    NSString *imageName = self.picPathStringArray[index];
    NSURL *url = [[NSBundle mainBundle] URLForResource:imageName withExtension:nil];
    return url;
    
}



@end
