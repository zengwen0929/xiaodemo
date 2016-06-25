//
//  ZLCollectionViewLayout.m
//  自定义layout
//
//  Created by zhoulei on 16/5/9.
//  Copyright © 2016年 周磊. All rights reserved.
//

#import "ZLCollectionViewLayout.h"


@interface ZLCollectionViewLayout ()

@property (nonatomic, strong) NSArray   *cellAttrsArray;
@property (nonatomic, strong) NSArray   *headerFrameArray;
@property (nonatomic, strong) NSArray   *footerFrameArray;
@property (nonatomic, assign) CGSize    contentSize;

@end


@implementation ZLCollectionViewLayout


- (void)prepareLayout{
    [super prepareLayout];
    
    [self generateMetroAttrsArrays];
}

#pragma mark 生成cell,header,footer属性数组
- (void)generateMetroAttrsArrays{
    
    NSMutableArray *cellAttrsArray   = [NSMutableArray array];
    NSMutableArray *headerFrameArray = [NSMutableArray array];
    NSMutableArray *footerFrameArray = [NSMutableArray array];

    
    CGSize contentSize = CGSizeZero;
    contentSize.height = self.collectionView.frame.size.height;
    
    CGPoint areaPos  = CGPointZero;
    CGRect headerFrame, footerFrame;
    
    headerFrame.size = self.headerReferenceSize;
    footerFrame.size = self.footerReferenceSize;

    for (NSUInteger section = 0; section < [self.collectionView numberOfSections]; section ++) {
        
        //计算每个区有多少列，ceilf向上取整
        int lineNumber = (int)ceilf((float)[self.collectionView numberOfItemsInSection:section]/2);
        //计算每个区的宽度,左右缩进加上间隔*列数-1 + item宽度*列数
        int sectionWidth = (self.sectionInset.left +(self.minimumInteritemSpacing*(lineNumber - 1))+(self.itemSize.width*lineNumber) + self.sectionInset.right);
        //区头的坐标
        headerFrame.origin = areaPos;
         //区头的高度
         headerFrame.size.height = self.headerReferenceSize.height;
        //区头的宽度
        headerFrame.size.width = sectionWidth;
        //添加都区数组
        [headerFrameArray addObject:[NSValue valueWithCGRect:headerFrame]];
        
        
        NSMutableArray *sectionAttrsArray = [NSMutableArray array];
        
        //便利每个区的单元格，给单元格坐标
        for (NSUInteger row = 0; row < [self.collectionView numberOfItemsInSection:section]; row ++) {
            
            CGRect cellFrame;

            cellFrame.origin.x  = areaPos.x + ((self.sectionInset.left+(self.minimumInteritemSpacing*(row%lineNumber)))+((row%lineNumber)*self.itemSize.width));

            cellFrame.origin.y     = self.headerReferenceSize.height + ((self.minimumLineSpacing*(row/lineNumber))+((row/lineNumber)*self.itemSize.height));
            
            cellFrame.size.width = self.itemSize.width;
            cellFrame.size.height = self.itemSize.height;
            
            [sectionAttrsArray addObject:[NSValue valueWithCGRect:cellFrame]];
        }
        [cellAttrsArray addObject:sectionAttrsArray];
        
        //每个区域的X坐标
        areaPos.x += sectionWidth;
        
        //滚动区域大小
        contentSize.width+=sectionWidth;
        contentSize.height = self.headerReferenceSize.height;
        
        //区尾坐标和大小
        footerFrame.origin.x = areaPos.x;
        footerFrame.origin.y = self.headerReferenceSize.height;
        footerFrame.size.height = self.collectionView.frame.size.height - self.sectionInset.bottom;
        areaPos.x += self.footerReferenceSize.width;
        contentSize.width+=self.footerReferenceSize.width;
        [footerFrameArray addObject:[NSValue valueWithCGRect:footerFrame]];
    }
    
    contentSize.width = contentSize.width - self.sectionInset.right;
    self.contentSize  = contentSize ;
    self.cellAttrsArray   = cellAttrsArray;
    self.headerFrameArray = headerFrameArray;
    self.footerFrameArray = footerFrameArray;

}

//返回所有cell的布局属性
- (NSArray *)indexPathsOfItemsInRect:(CGRect)rect{
    
    NSMutableArray *indexPaths = [NSMutableArray array];
    
    for (NSUInteger section = 0; section < self.cellAttrsArray.count; section ++) {
        
        NSArray *sectionAttrs = self.cellAttrsArray[section];
        
        for (NSUInteger row = 0; row < sectionAttrs.count; row ++) {
            
                NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:section];
                
                [indexPaths addObject:path];
        }
    }
    
    return indexPaths;
}

- (NSArray *)indexPathsOfHeadersInRect:(CGRect)rect{
    
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (NSUInteger section = 0; section < self.headerFrameArray.count; section ++) {
        CGRect headerFrame = [self.headerFrameArray[section] CGRectValue];
        if (headerFrame.size.width > 0 && headerFrame.size.height > 0 && CGRectIntersectsRect(rect, headerFrame)) {
            NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:section];
            [indexPaths addObject:path];
        }
    }
    
    return indexPaths;
}

- (NSArray *)indexPathsOfFootersInRect:(CGRect)rect{
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (NSUInteger section = 0; section < self.footerFrameArray.count; section ++) {
        CGRect footerFrame = [self.footerFrameArray[section] CGRectValue];
        if (footerFrame.size.width > 0 && footerFrame.size.height > 0 && CGRectIntersectsRect(rect, footerFrame)) {
            NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:section];
            [indexPaths addObject:path];
        }
    }
    
    return indexPaths;
}

#pragma mark 计算ContentSize
/**
 * 返回collectionView的内容大小
 */
- (CGSize)collectionViewContentSize{
    return self.contentSize;
}

#pragma mark 每个Item的attributes
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path{
    UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
    
    NSArray *sectionAttrs = self.cellAttrsArray[path.section];
    
    
    attributes.frame = [sectionAttrs[path.row] CGRectValue];
    
    return attributes;
}
#pragma mark 可视Rect的attributesArray
-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray* attributesArray = [NSMutableArray array];
    NSArray *visibleIndexPaths = [self indexPathsOfItemsInRect:rect];
    // cell attributes
    for (NSIndexPath *indexPath in visibleIndexPaths) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [attributesArray addObject:attributes];
    }
    
    // header attributes
    NSArray *headerIndexPaths = [self indexPathsOfHeadersInRect:rect];
    for (NSIndexPath *indexPath in headerIndexPaths) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
        [attributesArray addObject:attributes];
    }
    
    // footer attributes
    NSArray *footerIndexPaths = [self indexPathsOfFootersInRect:rect];
    for (NSIndexPath *indexPath in footerIndexPaths) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:indexPath];
        [attributesArray addObject:attributes];
    }
    

    
    return attributesArray;
}

#pragma mark header和footer的attributes
- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        attributes.frame = [self.headerFrameArray[indexPath.section] CGRectValue];
    }else if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]) {
        attributes.frame = [self.footerFrameArray[indexPath.section] CGRectValue];
    }

       return attributes;
}


@end


