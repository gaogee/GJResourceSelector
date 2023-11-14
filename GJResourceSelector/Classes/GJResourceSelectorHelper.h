//
//  GJResourceSelectorHelper.h
//  GJResourceSelector
//
//  Created by zhanggaoju on 2023/11/13.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
typedef NS_ENUM(NSUInteger, GJResourceAssetMediaType) {
    GJResourceAssetMediaTypeAll     = 0,
    GJResourceAssetMediaTypeImage   = 1,
    GJResourceAssetMediaTypeVideo   = 2,
};

#define GJSelectionResourceNot @"GJSelectionResourceNot"

#define GJResourceIsIphoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

#define GJResourceStatusHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define GJResourceScreenWidth [UIScreen mainScreen].bounds.size.width
#define GJResourceScreenHeight [UIScreen mainScreen].bounds.size.height
#define GJResourceTabBarHeight  (GJResourceIsIphoneX? 83 : 49)

NS_ASSUME_NONNULL_BEGIN

@interface GJResourceSelectorHelper : NSObject

+ (NSString *)getAppDocumentPath;

+ (NSString *)userDirectory;

+ (NSString *)genFilenameWithExt:(NSString *)ext;

+ (NSString *)filepathForVideo:(NSString *)filename;

+ (NSString *)filepathForImage:(NSString *)filename;

+ (AVMutableVideoComposition *)videoCompositionWithAsset:(AVAsset *)asset;

+(UIViewController *)currentViewController;
@end

NS_ASSUME_NONNULL_END
