//
//  GJResourceManager.m
//  GJResourceSelector
//
//  Created by zhanggaoju on 2023/11/13.
//

#import "GJResourceManager.h"
#import "GJSelectedAssetsManager.h"

static GJResourceManager *_manager = nil;
@implementation GJResourceManager

+ (instancetype)manager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc]init];
    });
    return _manager;
}
/**
 *  得到所有的相册
 */
-(NSArray <PHAssetCollection *>*)assetCollections{
    NSMutableArray *allAssetCollections = [NSMutableArray array];
    PHAssetCollection *recentCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
    [allAssetCollections addObject:recentCollections];
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *assetCollection in assetCollections) {
        PHFetchResult *assets = [self assetsInAssetCollection:assetCollection];
        if (assets.count>0){
            [allAssetCollections addObject:assetCollection];
        }
    }
    return allAssetCollections;
}
/**
 获取assets集合
 */
- (PHFetchResult *)assetsInAssetCollection:(PHAssetCollection *)assetCollection{
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.predicate = [NSPredicate predicateWithFormat:@"mediaType in %@",  @[@(PHAssetMediaTypeImage), @(PHAssetMediaTypeVideo)]];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    return [PHAsset fetchAssetsInAssetCollection:assetCollection options:options];
}
- (BOOL)isCanUsePhotos {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted ||status == PHAuthorizationStatusDenied) {
        //无权限
        return NO;
    }
    return YES;
}
//授权照片
- (void)phontLibraryAction{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
    }];
}
@end

