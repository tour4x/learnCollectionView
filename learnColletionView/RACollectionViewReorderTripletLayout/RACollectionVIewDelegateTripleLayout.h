//
//  RACollectionVIewDelegateTripleLayout.h
//  learnColletionView
//
//  Created by user on 16/3/23.
//  Copyright © 2016年 JiuFang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RACollectionVIewTripletLayoutStyleSquare CGSizeZero

@protocol RACollectionViewDelegateTripletLayout <UICollectionViewDelegateFlowLayout>

@optional

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForLargeItemsInSection:(NSInteger)section;//Default to automaticaly grow square !

@end

@interface RACollectionVIewDelegateTripleLayout : UICollectionViewLayout

@property (assign, nonatomic)id<RACollectionViewDelegateTripletLayout> delegate;
@property (assign, nonatomic, readonly)CGSize largeCellSize;
@property (assign, nonatomic, readonly)CGSize smallCellSize;

@end
