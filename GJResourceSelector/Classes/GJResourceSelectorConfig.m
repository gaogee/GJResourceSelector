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
-(UIImage *)goBackImage{
    if (!_goBackImage){
        _goBackImage = [UIImage imageWithContentsOfFile:[self imageFileWithImageName:@"gj_photo_selected_goback.png"]];
    }
    return _goBackImage;
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
-(UIImage *)filterImage{
    if (!_filterImage){
        _filterImage = [UIImage imageWithContentsOfFile:[self imageFileWithImageName:@"gj_photo_selected_open.png"]];
    }
    return _filterImage;
}

-(UIColor *)selectedButtonBgColor{
    if(!_selectedButtonBgColor){
        _selectedButtonBgColor = [UIColor blueColor];
    }
    return _selectedButtonBgColor;
}
-(UIColor *)selectedButtonTitleColor{
    if(!_selectedButtonTitleColor){
        _selectedButtonTitleColor = [UIColor whiteColor];
    }
    return _selectedButtonTitleColor;
}
-(UIColor *)unSelectedButtonBorderColor{
    if(!_unSelectedButtonBorderColor){
        _unSelectedButtonBorderColor = [UIColor whiteColor];
    }
    return _unSelectedButtonBorderColor;
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
-(UIImage *)videoDurationImage{
    if (!_videoDurationImage){
        _videoDurationImage = [UIImage imageWithContentsOfFile:[self imageFileWithImageName:@"gj_browser_video.png"]];
    }
    return _videoDurationImage;
}
-(NSString *)imageFileWithImageName:(NSString *)imageName{
    return [[NSBundle bundleForClass:self.class] pathForResource:imageName ofType:nil inDirectory:@"GJResourceSelector.bundle"];
}
@end
