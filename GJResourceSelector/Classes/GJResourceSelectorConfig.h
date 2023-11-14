//
//  GJResourceSelectorConfig.h
//  GJResourceSelectorConfig
//
//  Created by zhanggaoju on 2023/11/13.
//

#import <Foundation/Foundation.h>
#import "GJResourceSelectorConfig.h"
NS_ASSUME_NONNULL_BEGIN

@interface GJResourceSelectorConfig : NSObject

+ (instancetype)config;
//TopBar config
@property (nonatomic, strong)UIImage *goBackImage;
@property (nonatomic, strong)UIImage *filterImage;
@property (nonatomic, strong)UIColor *filterTitleColor;
@property (nonatomic, strong)UIFont *filterTitleFont;
@property (nonatomic, strong)NSString *sureButtonTitle;
@property (nonatomic, strong)UIColor *sureButtonBgColor;
@property (nonatomic, strong)UIColor *sureButtonTitleColor;
@property (nonatomic, strong)UIFont *sureButtonTitleFont;

@property (nonatomic, strong)UIImage *selectedImage;
@property (nonatomic, strong)UIImage *unSelectedImage;
@property (nonatomic, strong)UIImage *videoDurationImage;
@property (nonatomic, strong)UIColor *videoDurationTextColor;
@end

NS_ASSUME_NONNULL_END
