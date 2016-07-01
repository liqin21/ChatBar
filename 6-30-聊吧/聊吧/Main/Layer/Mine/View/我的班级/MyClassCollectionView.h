//
//  MyClassCollectionView.h
//  聊吧
//
//  Created by m on 16/6/20.
//  Copyright © 2016年 m. All rights reserved.
//

#import <UIKit/UIKit.h>

//定义一个单元格点击协议
@protocol CollectionViewCellDidSelectedDelegate <NSObject>

- (void)collectionViewCellDidSelected:(id)model;

@end

@interface MyClassCollectionView : UICollectionView <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) NSArray *dataSouce;

@property (nonatomic,weak) id<CollectionViewCellDidSelectedDelegate> selectedDelegate;

@end
