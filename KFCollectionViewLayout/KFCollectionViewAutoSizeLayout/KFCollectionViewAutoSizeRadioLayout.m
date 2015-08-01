//
//  KFCollectionViewAutoRadioSize.m
//  KFCollectionViewLayout
//
//  Created by K6F on 15/13[4].
//

#import "KFCollectionViewAutoRadioSize.h"

static const float SEPARATE_WIDTH = 2.f;
static const float SEPARATE_HEIGHT = 2.f;

@implementation KFCollectionViewAutoSize4_3Layout{
    NSMutableArray * _itemsAttributes;
    CGSize contentSize;
}

#pragma mark - Public
-(float)columnWidth{
    float width = (self.collectionView.frame.size.width - (self.columnCount-1) * SEPARATE_WIDTH)/self.columnCount;
    width = ((int)(width * 100))/100;
    return width;
}
-(float)columnHeight{
    return ((int)([self columnWidth]/3*4* 100))/100;
}
#pragma mark UICollectionViewLayout

-(void)prepareLayout{
//    if (0 == self.columnCount) {
        self.columnCount = 3;
//    }
    NSUInteger itemsCount = [[self collectionView] numberOfItemsInSection:0];
    _itemsAttributes = [NSMutableArray arrayWithCapacity:itemsCount];
    CGFloat width = [self columnWidth];
    CGFloat height = [self columnHeight];
    for (int idx = 0; idx < itemsCount; idx++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
        int columnIdx = idx % self.columnCount;
        CGFloat pointX = (width + SEPARATE_WIDTH) * columnIdx;
        CGFloat pointY = (height + SEPARATE_HEIGHT) * floor(idx/self.columnCount);
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.frame = CGRectMake(pointX, pointY, width, height);
        [_itemsAttributes addObject:attributes];
    }
    // Set the content size
    float pageWidth = self.collectionView.frame.size.width;
    double row = ceil((float)itemsCount/self.columnCount);
    float pageHeight = (height + SEPARATE_HEIGHT) * row;
    contentSize = CGSizeMake(pageWidth, pageHeight);
}
-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSPredicate *filterPredicate = [NSPredicate predicateWithBlock:^BOOL(UICollectionViewLayoutAttributes * evaluatedObject, NSDictionary *bindings) {
        BOOL predicateRetVal = CGRectIntersectsRect(rect, [evaluatedObject frame]);
        return predicateRetVal;
    }];
    
    return  [_itemsAttributes filteredArrayUsingPredicate:filterPredicate];
}
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attributes = [_itemsAttributes objectAtIndex:indexPath.row];
    return attributes;
}


- (CGSize)collectionViewContentSize{
    return contentSize;
}
@end