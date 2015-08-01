//
//  KFCollectionViewAutoRadioSize.h
//  KFCollectionViewLayout
//
//  Created by K6F on 15/13[4].
//

#import <UIKit/UIKit.h>

@interface KFCollectionViewAutoSizeAspectRatioLayout : UICollectionViewLayout
/**
 *  @author Khiyuan.Fan, 2015-13[4]
 *
 *  Default is 1, set when using;
 */
@property (assign) NSInteger columnCount;
@property (nonatomic) CGFloat kfRowSpacing;
@property (nonatomic) CGFloat kfColumnSpacing;

- (instancetype)initWithColumnCount:(NSInteger)count
                        aspectRatio:(CGFloat)ratio
                         rowSpacing:(CGFloat)rowSpacing
                      columnSpacing:(CGFloat)columnSpacing;



@property (nonatomic, readonly) CGFloat kfCellWidth;
@property (nonatomic, readonly) CGFloat kfCellHeight;
@end
