//
//  GJSelectResourceCollectionView.h
//  GJResourceSelector
//
//  Created by zhanggaoju on 2023/11/13.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "GJResourceSelectorHelper.h"
@class GJSelectResourceCollectionView;
NS_ASSUME_NONNULL_BEGIN
typedef void (^ __nullable GJSelectResourceClickItemBlock) (NSInteger index, PHFetchResult * _Nullable fetchResult, GJSelectResourceCollectionView * _Nonnull collectionView);
@interface GJSelectResourceCollectionView : UICollectionView
@property (nonatomic, strong) PHFetchResult *fetchResult;
@property (nonatomic, copy) GJSelectResourceClickItemBlock clickItemBlock;
@end

NS_ASSUME_NONNULL_END
