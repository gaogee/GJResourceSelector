//
//  GJSelectResourceTableViewCell.m
//  GJResourceSelector
//
//  Created by zhanggaoju on 2023/11/13.
//

#import "GJSelectResourceTableViewCell.h"
#import "GJResourceManager.h"
@interface GJSelectResourceTableViewCell ()
@property (nonatomic, strong) UIImageView *pictureView;
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UILabel *numberLb;
@end
@implementation GJSelectResourceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.pictureView];
        [self addSubview:self.titleLb];
        [self addSubview:self.numberLb];
    }
    return self;
}
-(UIImageView *)pictureView{
    if(!_pictureView){
        _pictureView = [UIImageView new];
        _pictureView.contentMode = UIViewContentModeScaleAspectFill;
        _pictureView.layer.cornerRadius = 8;
        _pictureView.layer.masksToBounds = YES;
    }
    return _pictureView;
}
-(UILabel *)titleLb{
    if (!_titleLb){
        _titleLb = [UILabel new];
        _titleLb.textColor = [UIColor blackColor];
        _titleLb.font = [UIFont systemFontOfSize:14];
    }
    return _titleLb;
}
-(UILabel *)numberLb{
    if (!_numberLb){
        _numberLb = [UILabel new];
        _numberLb.textColor = [UIColor blackColor];
        _numberLb.font = [UIFont systemFontOfSize:10];
    }
    return _numberLb;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.pictureView .translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *pictureView_width = [NSLayoutConstraint constraintWithItem:self.pictureView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:81];
    NSLayoutConstraint *pictureView_height= [NSLayoutConstraint constraintWithItem:self.pictureView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:78];
    NSLayoutConstraint *pictureView_centerY = [NSLayoutConstraint constraintWithItem:self.pictureView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    NSLayoutConstraint *pictureView_left = [NSLayoutConstraint constraintWithItem:self.pictureView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:20];
    [self.pictureView addConstraints:@[pictureView_width,pictureView_height]];
    [self addConstraints:@[pictureView_centerY,pictureView_left]];
    
   
    self.titleLb .translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *titleLb_top = [NSLayoutConstraint constraintWithItem:self.titleLb attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.pictureView attribute:NSLayoutAttributeTop multiplier:1 constant:20];
    NSLayoutConstraint *titleLb_height= [NSLayoutConstraint constraintWithItem:self.titleLb attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:20];
    NSLayoutConstraint *titleLb_left = [NSLayoutConstraint constraintWithItem:self.titleLb attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.pictureView attribute:NSLayoutAttributeRight multiplier:1 constant:6];
    [self.titleLb addConstraints:@[titleLb_height]];
    [self addConstraints:@[titleLb_top,titleLb_left]];
    
    self.numberLb .translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *numberLb_bottom = [NSLayoutConstraint constraintWithItem:self.numberLb attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.pictureView attribute:NSLayoutAttributeBottom multiplier:1 constant:-19];
    NSLayoutConstraint *numberLb_height = [NSLayoutConstraint constraintWithItem:self.numberLb attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:14];
    NSLayoutConstraint *numberLb_left = [NSLayoutConstraint constraintWithItem:self.numberLb attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.pictureView attribute:NSLayoutAttributeRight multiplier:1 constant:6];
    [self.numberLb addConstraints:@[numberLb_height]];
    [self addConstraints:@[numberLb_bottom,numberLb_left]];
    
}
-(void)setAssetCollection:(PHAssetCollection *)assetCollection{
    _assetCollection = assetCollection;
    
    PHFetchResult *assets = [GJResourceManager.manager assetsInAssetCollection:assetCollection];
    PHAsset * asset = assets.firstObject;
    CGSize size = CGSizeMake(asset.pixelWidth*.1, asset.pixelHeight*.1);
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.resizeMode = PHImageRequestOptionsResizeModeNone;
    options.synchronous = YES;
    if (!asset){
        NSLog(@"No permission to access album");
        return;
    }
    __weak typeof(self) weakSelf = self;
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.pictureView.image = result;
    }];
    
    self.titleLb.text = assetCollection.localizedTitle;
    self.numberLb.text = [NSString stringWithFormat:@"%ld",assets.count];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
