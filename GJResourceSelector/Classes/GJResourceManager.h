//
//  GJResourceManager.h
//  GJResourceSelector
//
//  Created by zhanggaoju on 2023/11/13.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
NS_ASSUME_NONNULL_BEGIN

@interface GJResourceManager : NSObject
+ (instancetype)manager;
/**
 *  得到所有的相册
 */
-(NSArray <PHAssetCollection *>*)assetCollections;
/**
 获取assets集合
 */
- (PHFetchResult *)assetsInAssetCollection:(PHAssetCollection *)assetCollection;
@end

NS_ASSUME_NONNULL_END
