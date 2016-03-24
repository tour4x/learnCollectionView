//
//  RACollectionViewReorderableTripletLayout.h
//  learnColletionView
//
//  Created by user on 16/3/24.
//  Copyright © 2016年 JiuFang. All rights reserved.
//

#import "RACollectionViewTripleLayout.h"


@protocol RACollectionViewReorderableTripletLayoutDataSource <UICollectionViewDataSource>

@optional

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath willMoveToIndexPath:(NSIndexPath *)toIndexPath;
- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath didMoveToIndexPath:(NSIndexPath *)toIndexPath;

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath canMoveToIndexPath:(NSIndexPath *)toIndexPath;

@end

@protocol RACollectionViewDelegateReorderableTripletLayout <RACollectionViewDelegateTripletLayout>

@optional

- (UIEdgeInsets)autoScrollTrigerEdgeInsets:(UICollectionView *)collectionView;//Sorry ,has not supported horizontal scroll.
- (UIEdgeInsets)autoScrollTrigerPadding:(UICollectionView *)collectionView;

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout willBeginDraggingItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didBeginDraggingItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout willEndDraggingItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didEndDragginItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface RACollectionViewReorderableTripletLayout : RACollectionViewTripleLayout<UIGestureRecognizerDelegate>

@property (assign, nonatomic)id<RACollectionViewDelegateReorderableTripletLayout> delegate;
@property (assign, nonatomic)id<RACollectionViewReorderableTripletLayoutDataSource> datasource;
@property (strong, nonatomic, readonly)UILongPressGestureRecognizer *longPressGerture;
@property (strong, nonatomic, readonly)UIPanGestureRecognizer *panGesture;

@end
