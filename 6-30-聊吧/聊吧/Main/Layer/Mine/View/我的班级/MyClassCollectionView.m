//
//  MyClassCollectionView.m
//  聊吧
//
//  Created by m on 16/6/20.
//  Copyright © 2016年 m. All rights reserved.
//

#import "MyClassCollectionView.h"
#import "ListCollectionCell.h"
#import "ClassmateListModel.h"

@implementation MyClassCollectionView {
    NSString *identifier;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        //设置代理
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        
        self.backgroundColor = [UIColor clearColor];
        
        //设定滑动速速
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        
        //注册单元格
        identifier = @"ListCollectionCell";
        [self registerClass:[ListCollectionCell class] forCellWithReuseIdentifier:identifier];
        
    }
    return self;
}

#pragma mark - 代理方法
//单元格数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataSouce.count;
}

//创建单元格
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ListCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    id model = _dataSouce[indexPath.row];
    if ([model isKindOfClass:[ClassmateListModel class]]) {
        
        cell.classmateListModel = model;
    }
    else {
        cell.teacherListModel = model;
        cell.imageView.layer.cornerRadius = (cell.contentView.bounds.size.width - 10) / 2.0;
        cell.imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        cell.imageView.layer.masksToBounds = YES;
        cell.imageView.layer.borderWidth = 1;

    }
    
    return cell;
}


//设置单元格起始位置
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 0, 10);
}

//设定单元格尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (kWidth - 10 * 2 - 3 * 10) / 4.0;
    
    return CGSizeMake(width, width + 20);
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}



//获取数据
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    id model = self.dataSouce[indexPath.row];
    if ([self.selectedDelegate respondsToSelector:@selector(collectionViewCellDidSelected:)]) {
        
        [self.selectedDelegate collectionViewCellDidSelected:model];
    }
}


@end
