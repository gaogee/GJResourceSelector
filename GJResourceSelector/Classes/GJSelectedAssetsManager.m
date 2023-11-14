//
//  GJSelectedAssetsManager.m
//  GJResourceSelector
//
//  Created by zhanggaoju on 2023/11/13.
//

#import "GJSelectedAssetsManager.h"

@interface GJSelectedAssetsManager ()
@property (nonatomic,strong)NSMutableArray *selectedAssetsArray;
@property (nonatomic,assign) PHAssetMediaType curSeletedMediaType;
@property (nonatomic,assign) BOOL selectable;
@end
static GJSelectedAssetsManager *_manager = nil;
@implementation GJSelectedAssetsManager
+ (instancetype)manager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc]init];
    });
    return _manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.selectable = YES;
        self.selectedAssetsArray = [NSMutableArray array];
    }
    return self;
}
-(void)setMediaType:(GJResourceAssetMediaType)mediaType{
    _mediaType = mediaType;
    switch (mediaType) {
        case GJResourceAssetMediaTypeAll:
            {
                if (self.allSelectedAssets.count>0){
                    self.curSeletedMediaType = self.allSelectedAssets.firstObject.mediaType;
                }
            }
            break;
        case GJResourceAssetMediaTypeImage:
            {
                self.curSeletedMediaType = PHAssetMediaTypeImage;
            }
            break;
        case GJResourceAssetMediaTypeVideo:
            {
                self.curSeletedMediaType = PHAssetMediaTypeVideo;
            }
            break;
        default:
            break;
    }
}

- (BOOL)addAssetWithAsset:(PHAsset *)asset{
    [self.selectedAssetsArray addObject:asset];
    return YES;
}


- (void)removeAssetWithAsset:(PHAsset *)asset{
    [self.selectedAssetsArray removeObject:asset];
}

- (NSArray *)allSelectedAssets{
    return self.selectedAssetsArray;
}


- (void)removeAllSelectedAssets{
    [self.selectedAssetsArray removeAllObjects];
}

-(PHAssetMediaType)curSeletedMediaType{
    switch (self.mediaType) {
        case GJResourceAssetMediaTypeAll:
            {
                if (self.allSelectedAssets.count>0){
                    return self.allSelectedAssets.firstObject.mediaType;
                }
            }
            break;
        case GJResourceAssetMediaTypeImage:
            {
                return PHAssetMediaTypeImage;
            }
            break;
        case GJResourceAssetMediaTypeVideo:
            {
                return PHAssetMediaTypeVideo;
            }
            break;
        default:
            break;
    }
    return PHAssetMediaTypeUnknown;
}
-(NSInteger)addedNumber{
    return self.allSelectedAssets.count;
}
-(BOOL)selectable{
    if (self.curSeletedMediaType == PHAssetMediaTypeVideo&&self.addedNumber>=1) {
        return NO;
    }
    if (self.addedNumber>=self.limitNumber) {
        return NO;
    }
    return YES;
}
@end
