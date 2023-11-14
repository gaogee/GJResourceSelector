//
//  GJSelectResourceCollectionViewCell.m
//  GJResourceSelector
//
//  Created by zhanggaoju on 2023/11/13.
//

#import "GJSelectResourceCollectionViewCell.h"
#import "GJSelectedAssetsManager.h"
#import "GJResourceSelectorConfig.h"
@interface GJSelectResourceCollectionViewCell ()
@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) UILabel *videoDurationLb;
@property (nonatomic, strong) UIView *maskView;
@end
@implementation GJSelectResourceCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.selectedBtn];
        [self.contentView addSubview:self.videoDurationLb];
        [self.contentView addSubview:self.maskView];
    }
    return self;
}
-(UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        _iconImageView.backgroundColor = [UIColor clearColor];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        _iconImageView.layer.cornerRadius = 10;
        _iconImageView.layer.masksToBounds = YES;
    }
    return _iconImageView;
}
-(UIButton *)selectedBtn{
    if (!_selectedBtn){
        _selectedBtn = [UIButton new];
        [_selectedBtn setBackgroundImage:GJResourceSelectorConfig.config.unSelectedImage forState:UIControlStateNormal];
        [_selectedBtn setBackgroundImage:GJResourceSelectorConfig.config.selectedImage forState:UIControlStateSelected];
        [_selectedBtn addTarget:self action:@selector(selectedPhotoSelector) forControlEvents:UIControlEventTouchUpInside];
        [_selectedBtn setTitleColor:GJResourceSelectorConfig.config.videoDurationTextColor forState:UIControlStateNormal];
        _selectedBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    }
    return _selectedBtn;
}
-(UILabel *)videoDurationLb{
    if (!_videoDurationLb) {
        _videoDurationLb = [UILabel new];
        _videoDurationLb.textColor = [UIColor whiteColor];
        _videoDurationLb.font = [UIFont systemFontOfSize:14];
    }
    return _videoDurationLb;
}
-(UIView *)maskView{
    if (!_maskView) {
        _maskView = [[UIView alloc]initWithFrame:self.bounds];
        _maskView.layer.cornerRadius = 10;
        _maskView.layer.masksToBounds = YES;
        _maskView.hidden = YES;
    }
    return _maskView;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.selectedBtn .translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *selectedBtn_top = [NSLayoutConstraint constraintWithItem:self.selectedBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:5];
    NSLayoutConstraint *selectedBtn_right = [NSLayoutConstraint constraintWithItem:self.selectedBtn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-20];
    [self addConstraints:@[selectedBtn_top,selectedBtn_right]];
    
    self.videoDurationLb .translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *videoDurationLb_bottom = [NSLayoutConstraint constraintWithItem:self.videoDurationLb attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:-5];
    NSLayoutConstraint *videoDurationLb_centerX = [NSLayoutConstraint constraintWithItem:self.videoDurationLb attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    [self addConstraints:@[videoDurationLb_bottom,videoDurationLb_centerX]];
}
-(void)selectedPhotoSelector{
    if(![GJSelectedAssetsManager.manager.allSelectedAssets containsObject:self.asset]){
        [GJSelectedAssetsManager.manager addAssetWithAsset:self.asset];
    }else{
        [GJSelectedAssetsManager.manager removeAssetWithAsset:self.asset];
    }
    NSDictionary *dic = @{@"indexPath":self.indexPath};
    [[NSNotificationCenter defaultCenter] postNotificationName:GJSelectionResourceNot object:nil userInfo:dic];
}
-(void)setAsset:(PHAsset *)asset{
    _asset = asset;
    CGSize size = CGSizeMake(asset.pixelWidth*.1, asset.pixelHeight*.1);
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.resizeMode = PHImageRequestOptionsResizeModeNone;
    options.synchronous = YES;
    __weak typeof(self) weakSelf = self;
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.iconImageView.image = result;
    }];
    if (asset.mediaType == PHAssetMediaTypeVideo) {
        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]init];
        NSMutableAttributedString *textStr = [[NSMutableAttributedString alloc] initWithString:[self formattedStringForDuration:asset.duration]];
        NSTextAttachment *attach = [[NSTextAttachment alloc] init];
        attach.image = GJResourceSelectorConfig.config.videoDurationImage;
        CGFloat paddingTop = ([UIFont systemFontOfSize:14].ascender+[UIFont systemFontOfSize:14].descender -attach.image.size.height)/2;
        attach.bounds = CGRectMake(0, paddingTop, attach.image.size.width, attach.image.size.height);
        NSAttributedString *imgStr = [NSAttributedString attributedStringWithAttachment:attach];
        NSMutableAttributedString *spcStr = [[NSMutableAttributedString alloc] initWithString:@" "];
        [attStr appendAttributedString:imgStr];
        [attStr appendAttributedString:spcStr];
        [attStr appendAttributedString:textStr];
        _videoDurationLb.attributedText = attStr;
    }else{
        _videoDurationLb.text = @"";
    }
        
    if ([GJSelectedAssetsManager.manager.allSelectedAssets containsObject:asset]){
        NSInteger index = [GJSelectedAssetsManager.manager.allSelectedAssets indexOfObject:asset];
        [self.selectedBtn setTitle:[NSString stringWithFormat:@"%ld",index+1] forState:UIControlStateNormal];
        self.selectedBtn.selected = YES;
    }else{
        [self.selectedBtn setTitle:@"" forState:UIControlStateNormal];
        self.selectedBtn.selected = NO;
    }
    
    if (!GJSelectedAssetsManager.manager.selectable) {
        if ([GJSelectedAssetsManager.manager.allSelectedAssets containsObject:asset]){
            self.userInteractionEnabled = YES;
            self.maskView.hidden = YES;
            self.maskView.backgroundColor = [UIColor clearColor];
        }else{
            self.userInteractionEnabled = NO;
            self.maskView.hidden = NO;
            self.maskView.backgroundColor = [UIColor colorWithWhite:1 alpha:.5];
        }
       
        return;
    }
    
    if(GJSelectedAssetsManager.manager.curSeletedMediaType == PHAssetMediaTypeVideo){
        if(asset.mediaType == PHAssetMediaTypeVideo){
            self.userInteractionEnabled = YES;
            self.maskView.hidden = YES;
            self.maskView.backgroundColor = [UIColor clearColor];
        }
        if(asset.mediaType == PHAssetMediaTypeImage){
            self.userInteractionEnabled = NO;
            self.maskView.hidden = NO;
            self.maskView.backgroundColor = [UIColor colorWithWhite:1 alpha:.5];
        }
    }else if(GJSelectedAssetsManager.manager.curSeletedMediaType == PHAssetMediaTypeImage){
        if(asset.mediaType == PHAssetMediaTypeImage){
            self.userInteractionEnabled = YES;
            self.maskView.hidden = YES;
            self.maskView.backgroundColor = [UIColor clearColor];
        }
        if(asset.mediaType == PHAssetMediaTypeVideo){
            self.userInteractionEnabled = NO;
            self.maskView.hidden = NO;
            self.maskView.backgroundColor = [UIColor colorWithWhite:1 alpha:.5];
            
        }
    }else{
        if (asset.mediaType == PHAssetMediaTypeVideo&&(asset.duration<3||asset.duration>20)) {
            self.userInteractionEnabled = NO;
            self.maskView.hidden = NO;
            self.maskView.backgroundColor = [UIColor colorWithWhite:1 alpha:.5];
        }else{
            self.userInteractionEnabled = YES;
            self.maskView.hidden = YES;
            self.maskView.backgroundColor = [UIColor clearColor];
        }
    }
    
}

- (NSString*)formattedStringForDuration:(NSTimeInterval)duration{
    NSInteger minutes = floor(duration/60);
    NSInteger seconds = round(duration - minutes * 60);
    return [NSString stringWithFormat:@"%02ld:%02ld", minutes,seconds];
}

@end
