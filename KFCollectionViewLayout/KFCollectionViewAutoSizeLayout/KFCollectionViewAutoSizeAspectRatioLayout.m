//
//  KFCollectionViewAutoRadioSize.m
//  KFCollectionViewLayout
//
//  Created by K6F on 15/13[4].
//

#import "KFCollectionViewAutoSizeAspectRatioLayout.h"

@interface KFCollectionViewAutoSizeAspectRatioLayout()
// public
@property (nonatomic, readwrite) CGFloat kfCellWidth;
@property (nonatomic, readwrite) CGFloat kfCellHeight;

// private
@property (nonatomic) CGSize pContentSize;
@end


@implementation KFCollectionViewAutoSizeAspectRatioLayout{
    NSMutableArray * _itemsAttributes;
    CGFloat pAspectRatio;
}
#pragma mark - Life Cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.columnCount = 3;
        pAspectRatio = 1.5;
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.columnCount = 3;
        pAspectRatio = 1.5;
    }
    return self;
}

- (instancetype)initWithColumnCount:(NSInteger)count
                        aspectRatio:(CGFloat)ratio
                         rowSpacing:(CGFloat)rowSpacing
                         columnSpacing:(CGFloat)columnSpacing{
    if (self = [self init]) {
        self.columnCount = count;
        pAspectRatio = ratio;
        self.kfRowSpacing = rowSpacing;
        self.kfColumnSpacing = columnSpacing;
    }
    return self;
}

#pragma mark UICollectionViewLayout

-(void)prepareLayout{
    NSUInteger itemsCount = [[self collectionView] numberOfItemsInSection:0];
    _itemsAttributes = [NSMutableArray arrayWithCapacity:itemsCount];
    CGFloat width = self.kfCellWidth;
    CGFloat height = self.kfCellHeight;
    for (int idx = 0; idx < itemsCount; idx++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
        int columnIdx = idx % self.columnCount;
        CGFloat pointX = (width + self.kfColumnSpacing) * columnIdx;
        CGFloat pointY = (height + self.kfRowSpacing) * floor(idx / self.columnCount);
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.frame = CGRectMake(pointX, pointY, width, height);
        [_itemsAttributes addObject:attributes];
    }
    // Set the content size
    CGFloat pageWidth = (self.columnCount-1) * self.kfColumnSpacing + self.kfCellWidth *self.columnCount;
    CGFloat row = ceil((CGFloat)itemsCount/self.columnCount);
    CGFloat pageHeight = (height + self.kfRowSpacing) * row;
    self.pContentSize = CGSizeMake(pageWidth, pageHeight);
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
    return self.pContentSize;
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    CGRect oldBounds = self.collectionView.bounds;
    return (CGRectGetWidth(newBounds) != CGRectGetWidth(oldBounds));
}

#pragma mark - Setter & Getter
-(CGFloat)kfCellWidth{
    float width = (self.collectionView.bounds.size.width - (self.columnCount-1) * self.kfColumnSpacing)/self.columnCount;
    width = ((int)(width * 100))/100;
    return width;
}
-(CGFloat)kfCellHeight{
    return ((int)([self kfCellWidth]*pAspectRatio*100))/100;
}
@end