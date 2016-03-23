//
//  RACollectionVIewDelegateTripleLayout.m
//  learnColletionView
//
//  Created by user on 16/3/23.
//  Copyright © 2016年 JiuFang. All rights reserved.
//

#import "RACollectionVIewDelegateTripleLayout.h"

@interface RACollectionVIewDelegateTripleLayout()

@property (assign, nonatomic)NSInteger numbersOfCells;
@property (assign, nonatomic)NSInteger numbersOfLines;
@property (assign, nonatomic)CGFloat itemSpacing;
@property (assign, nonatomic)CGFloat lineSpacing;
@property (assign, nonatomic)CGSize collectionViewSize;
@property (assign, nonatomic)UIEdgeInsets insets;

@end

@implementation RACollectionVIewDelegateTripleLayout

#pragma mark - Over ride flow layout methods

-(void)prepareLayout {
    
    [super prepareLayout];
    
    //delegate
    self.delegate = (id<RACollectionViewDelegateTripletLayout>)self.collectionView.delegate;
    //collection view size
    _collectionViewSize = self.collectionView.bounds.size;
    //number of cells
    _numbersOfCells = [self.collectionView numberOfItemsInSection:0];
    //number of lines
    _numbersOfLines = ceil((CGFloat)_numbersOfCells / 3.f);

}

- (id<RACollectionViewDelegateTripletLayout>)delegate {
    
    return (id<RACollectionViewDelegateTripletLayout>)self.collectionView.delegate;
}

- (CGSize)collectionViewContentSize {
    
    CGSize contentSize = CGSizeMake(_collectionViewSize.width, (_numbersOfLines * (_largeCellSize.height + _lineSpacing)) - _lineSpacing + _insets.top + _insets.bottom);
    if ((_numbersOfCells - 1) % 3 == 0 && (_numbersOfCells - 1) % 6 != 0) {
        contentSize = CGSizeMake(_collectionViewSize.width, (_numbersOfLines * (_largeCellSize.height + _lineSpacing)) - 2 * _lineSpacing - _smallCellSize.height + _insets.top + _insets.bottom);
    }
    
    return contentSize;
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSMutableArray *attributesArray = [NSMutableArray array];
    for (NSInteger i = 0; i < _numbersOfCells; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [attributesArray addObject:attributes];
    }
    return attributesArray;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //spacing
    _itemSpacing = 0;
    _lineSpacing = 0;
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
        _itemSpacing = [self.delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:indexPath.section];
        
    }
    
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:minimumLineSpacingForSectionAtIndex:)]) {
        _lineSpacing = [self.delegate collectionView:self.collectionView layout:self minimumLineSpacingForSectionAtIndex:indexPath.section];
    }
    //cell size
    
    CGFloat largeCellSideLength = (2.f * (_collectionViewSize.width - _insets.left - _insets.right - _itemSpacing)) / 3.f;
    CGFloat smallCellSideLength = (largeCellSideLength - _itemSpacing) / 2.f;
    _largeCellSize = CGSizeMake(largeCellSideLength, largeCellSideLength);
    _smallCellSize = CGSizeMake(smallCellSideLength, smallCellSideLength);
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:sizeForLargeItemsInSection:)]) {
        if (!CGSizeEqualToSize([self.delegate collectionView:self.collectionView layout:self sizeForLargeItemsInSection:indexPath.section], RACollectionVIewTripletLayoutStyleSquare)) {
            _largeCellSize = [self.delegate collectionView:self.collectionView layout:self sizeForLargeItemsInSection:indexPath.section];
            _smallCellSize = CGSizeMake(_collectionViewSize.width - _largeCellSize.width - _itemSpacing - _insets.left - _insets.right, (_largeCellSize.height / 2.f) - (_itemSpacing / 2.f));
        }
    }
    //insets
    _insets = UIEdgeInsetsMake(0, 0, 0, 0);
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        _insets = [self.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:indexPath.section];
    }
    
    NSInteger line = indexPath.item / 3;
    CGFloat lineSpaceForIndexPath = _lineSpacing * line;
    CGFloat lineOriginY = _largeCellSize.height * line + lineSpaceForIndexPath + _insets.top;
    CGFloat rightSideLargeCellOriginX = _collectionViewSize.width - _largeCellSize.width - _insets.right;
    CGFloat rightSideSmallCellOriginX = _collectionViewSize.width - _smallCellSize.width - _insets.right;
    
    if (indexPath.item == 0) {
        attribute.frame = CGRectMake(_insets.left, _insets.top, _largeCellSize.width, _largeCellSize.height);
    } else if (indexPath.item % 6 == 0) {
        attribute.frame = CGRectMake(_insets.left, lineOriginY, _largeCellSize.width, _largeCellSize.height);
    } else if ((indexPath.item + 1) % 6 == 0) {
        attribute.frame = CGRectMake(rightSideLargeCellOriginX, lineOriginY, _largeCellSize.width, _largeCellSize.height);
    } else if (line % 2 == 0) {
        if (indexPath.item % 2 != 0) {
            attribute.frame = CGRectMake(rightSideSmallCellOriginX, lineOriginY, _smallCellSize.width, _smallCellSize.height);
        }else {
            attribute.frame = CGRectMake(rightSideSmallCellOriginX, lineOriginY + _smallCellSize.height + _itemSpacing, _smallCellSize.width, _smallCellSize.height);
        }
    } else {
        if (indexPath.item % 2 != 0) {
            attribute.frame = CGRectMake(_insets.left, lineOriginY, _smallCellSize.width, _smallCellSize.height);
        } else {
            attribute.frame = CGRectMake(_insets.left, lineOriginY + _smallCellSize.height + _itemSpacing, _smallCellSize.width, _smallCellSize.height);
        }
    }
    
    if (indexPath.item % 6 == 0) {
        attribute.frame = CGRectMake(_insets.left, _insets.top, _largeCellSize.width, _largeCellSize.height);
    } else if ((indexPath.item - 1) % 6 == 0) {
        attribute.frame = CGRectMake(rightSideSmallCellOriginX, lineOriginY, _smallCellSize.width, _smallCellSize.width);
    } else if ((indexPath.item - 2) % 6 == 0) {
        attribute.frame = CGRectMake(rightSideSmallCellOriginX, lineOriginY + _smallCellSize.height + _itemSpacing, _smallCellSize.width, _smallCellSize.height);
    } else if ((indexPath.item - 3) % 6 == 0) {
        attribute.frame = CGRectMake(_insets.left, lineOriginY, _smallCellSize.width, _smallCellSize.height);
    } else if ((indexPath.item - 4) % 6 == 0) {
        attribute.frame = CGRectMake(rightSideSmallCellOriginX, lineOriginY, _smallCellSize.width, _smallCellSize.width);
    } else {
        attribute.frame = CGRectMake(rightSideSmallCellOriginX, lineOriginY + _smallCellSize.height + _itemSpacing, _smallCellSize.width, _smallCellSize.height);
    }
    
    return attribute;
}

@end
