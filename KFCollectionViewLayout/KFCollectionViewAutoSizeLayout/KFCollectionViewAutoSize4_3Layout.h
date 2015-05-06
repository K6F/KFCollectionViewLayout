//
//  KFCollectionViewAutoSize4_3Layout.h
//  KFCollectionViewLayout
//
//  Created by K6F on 15/13[4].
//

#import <UIKit/UIKit.h>

@interface KFCollectionViewAutoSize4_3Layout : UICollectionViewLayout
/**
 *  @author Khiyuan.Fan, 2015-13[4]
 *
 *  Default is 1, set when using;
 */
@property (assign) NSInteger columnCount;
@property (readonly) float columnWidth;
@property (readonly) float columnHeight;
@end
