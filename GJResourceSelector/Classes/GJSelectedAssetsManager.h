//
//  GJSelectedAssetsManager.h
//  GJResourceSelector
//
//  Created by zhanggaoju on 2023/11/13.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import "GJResourceSelectorHelper.h"
NS_ASSUME_NONNULL_BEGIN

@interface GJSelectedAssetsManager : NSObject
+ (instancetype)manager;
@property (nonatomic,assign) NSInteger limitNumber;

@property (nonatomic,assign) GJResourceAssetMediaType mediaType;

@property (nonatomic,assign,readonly) PHAssetMediaType curSeletedMediaType;

@property (nonatomic,assign,readonly) NSInteger addedNumber;

@property (nonatomic,assign,readonly) BOOL selectable;
/**
 选中媒体

 @param asset 媒体
 */
- (BOOL)addAssetWithAsset:(PHAsset *)asset;


/**
 删除媒体

 @param asset 媒体
 */
- (void)removeAssetWithAsset:(PHAsset *)asset;


/**
 返回所有选中的媒体

 @return 媒体数组
 */
- (NSArray<PHAsset *> *)allSelectedAssets;


/**
 删除所有选中的数组
 */
- (void)removeAllSelectedAssets;
@end

NS_ASSUME_NONNULL_END
