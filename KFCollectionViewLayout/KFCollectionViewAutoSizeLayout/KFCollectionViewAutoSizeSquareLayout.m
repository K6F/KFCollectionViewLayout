//
//  KFCollectionViewAutoSizeSquareLayout.m
//  KFCollectionViewLayout
//
//  Created by K6F on 15/13[4].
//

#import "KFCollectionViewAutoSizeSquareLayout.h"

static const float SEPARATE_WIDTH = 2.f;

@implementation KFCollectionViewAutoSizeSquareLayout{
    NSMutableArray * _itemsAttributes;
}

#pragma mark - Public
-(float)columnWidth{
    float width = (self.collectionView.frame.size.width - (self.columnCount-1) * SEPARATE_WIDTH)/self.columnCount;
    width = ((int)(width * 100))/100;
    return width;
}

#pragma mark UICollectionViewLayout

-(void)prepareLayout{
    if (0 == self.columnCount) {
        self.columnCount = 1;
    }
    NSUInteger itemsCount = [[self collectionView] numberOfItemsInSection:0];
    _itemsAttributes = [NSMutableArray arrayWithCapacity:itemsCount];
    NSLog(@"count:%d",(int)itemsCount);
    for (int idx = 0; idx < itemsCount; idx++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
        CGFloat width = [self columnWidth];
        int columnIdx = idx % self.columnCount;
        CGFloat pointX = (width + SEPARATE_WIDTH) * columnIdx;
        CGFloat pointY = (width + SEPARATE_WIDTH) * floor(idx/self.columnCount);
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.frame = CGRectMake(pointX, pointY, width, width);
        NSLog(@"idx:%d,x:%f,y:%f,w:%f",idx,pointX,pointY,width);
        [_itemsAttributes addObject:attributes];
    }

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


- (CGSize)collectionViewContentSize
{
    // Ask the data source how many items there are (assume a single section)
    id<UICollectionViewDataSource> dataSource = self.collectionView.dataSource;
    int numberOfItems = (int)[dataSource collectionView:self.collectionView numberOfItemsInSection:0];
    CGSize frmSize = self.collectionView.bounds.size;
    CGFloat width = (frmSize.width - (self.columnCount-1) * SEPARATE_WIDTH)/self.columnCount;
    
    // Set the size
    float pageWidth = self.collectionView.frame.size.width;
    float pageHeight = (width + 2.f) * ceil(numberOfItems/self.columnCount);
    CGSize contentSize = CGSizeMake(pageWidth, pageHeight);
    
    return contentSize;
}
@end