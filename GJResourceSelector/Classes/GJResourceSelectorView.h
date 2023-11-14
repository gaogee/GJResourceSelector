//
//  GJResourceSelectorView.h
//  GJResourceSelector
//
//  Created by zhanggaoju on 2023/11/13.
//

#import <UIKit/UIKit.h>
#import "GJResourceSelectorHelper.h"
#import "GJResourceManager.h"
#import "GJSelectResourceCollectionView.h"
@class GJResourceSelectorView;
NS_ASSUME_NONNULL_BEGIN

@interface GJResourceSelectorView : UIView
typedef void (^ __nullable GJResourceSelectorCompletedBlock) (GJResourceSelectorView *alertView, NSMutableArray <UIImage *> * _Nullable photos, NSString * _Nullable videoPath);
typedef void (^ __nullable GJResourceSelectorCancelBlock) (GJResourceSelectorView *alertView);
typedef void (^ __nullable GJResourceClickItemBlock) (NSInteger index, PHFetchResult * _Nullable fetchResult, GJSelectResourceCollectionView * _Nonnull collectionView);
+(void)loadWithLimitNumber:(NSInteger)selectLimitNumber mediaType:(GJResourceAssetMediaType)mediaType completedBlock:(nullable GJResourceSelectorCompletedBlock)completedBlock cancelBlock:(nullable GJResourceSelectorCancelBlock)cancelBlock clickItemBlock:(GJResourceClickItemBlock)clickItemBlock;
-(void)closeDown;

@end

NS_ASSUME_NONNULL_END
