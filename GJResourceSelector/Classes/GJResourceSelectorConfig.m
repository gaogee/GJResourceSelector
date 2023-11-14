//
//  GJResourceSelectorConfig.m
//  GJResourceSelectorConfig
//
//  Created by zhanggaoju on 2023/11/13.
//

#import "GJResourceSelectorConfig.h"
static GJResourceSelectorConfig *_config = nil;
@implementation GJResourceSelectorConfig

+ (instancetype)config{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _config = [[self alloc]init];
    });
    return _config;
}
-(NSString *)sureButtonTitle{
    if(!_sureButtonTitle){
        _sureButtonTitle = @"Confirm";
    }
    return _sureButtonTitle;
}
-(UIColor *)filterTitleColor{
    if(!_filterTitleColor){
        _filterTitleColor = [UIColor blackColor];
    }
    return _filterTitleColor;
}
-(UIFont *)filterTitleFont{
    if (!_filterTitleFont){
        _filterTitleFont = [UIFont systemFontOfSize:14];
    }
    return _filterTitleFont;
}
-(UIColor *)sureButtonBgColor{
    if(!_sureButtonBgColor){
        _sureButtonBgColor = [UIColor blueColor];
    }
    return _sureButtonBgColor;
}
-(UIColor *)sureButtonTitleColor{
    if (!_sureButtonTitleColor){
        _sureButtonTitleColor = [UIColor whiteColor];
    }
    return _sureButtonTitleColor;
}
-(UIFont *)sureButtonTitleFont{
    if (!_sureButtonTitleFont){
        _sureButtonTitleFont = [UIFont systemFontOfSize:14];
    }
    return _sureButtonTitleFont;
}

-(UIColor *)videoDurationTextColor{
    if (!_videoDurationTextColor){
        _videoDurationTextColor = [UIColor whiteColor];
    }
    return _videoDurationTextColor;
}
@end
