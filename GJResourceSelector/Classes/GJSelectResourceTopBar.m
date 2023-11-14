//
//  GJSelectResourceTopBar.m
//  GJResourceSelector
//
//  Created by zhanggaoju on 2023/11/13.
//

#import "GJSelectResourceTopBar.h"
#import "GJResourceSelectorConfig.h"
@interface GJSelectResourceTopBar ()
@property (nonatomic,strong) UIButton *titltBtn;
@property (nonatomic,strong) UIButton *leaveBtn;
@property (nonatomic,strong) UIButton *sureBtn;
@property (nonatomic,assign) BOOL isOpen;
@end
@implementation GJSelectResourceTopBar

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titltBtn];
        [self addSubview:self.leaveBtn];
        [self addSubview:self.sureBtn];
    }
    return self;
}

-(UIButton *)titltBtn{
    if (!_titltBtn){
        _titltBtn = [UIButton new];
        [_titltBtn setTitleColor:GJResourceSelectorConfig.config.filterTitleColor forState:UIControlStateNormal];
        _titltBtn.titleLabel.font = GJResourceSelectorConfig.config.filterTitleFont;
        [_titltBtn setImage:GJResourceSelectorConfig.config.filterImage forState:UIControlStateNormal];
        [_titltBtn addTarget:self action:@selector(seleBrowserSelector) forControlEvents:UIControlEventTouchUpInside];
    }
    return _titltBtn;
}
-(UIButton *)leaveBtn{
    if (!_leaveBtn){
        _leaveBtn = [UIButton new];
        [_leaveBtn setImage:GJResourceSelectorConfig.config.goBackImage forState:UIControlStateNormal];
        [_leaveBtn addTarget:self action:@selector(gobackSelector) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leaveBtn;
}
-(UIButton *)sureBtn{
    if (!_sureBtn){
        _sureBtn = [UIButton new];
        [_sureBtn setTitle:GJResourceSelectorConfig.config.sureButtonTitle forState:UIControlStateNormal];
        [_sureBtn setTitleColor:GJResourceSelectorConfig.config.sureButtonTitleColor forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = GJResourceSelectorConfig.config.sureButtonTitleFont;
        _sureBtn.layer.cornerRadius = 28/2;
        _sureBtn.layer.masksToBounds = YES;
        _sureBtn.backgroundColor = GJResourceSelectorConfig.config.sureButtonBgColor;
        _sureBtn.contentEdgeInsets =  UIEdgeInsetsMake(0, 15, 0, 15);
        [_sureBtn addTarget:self action:@selector(sureSelector) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.titltBtn .translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *titltBtn_centerX = [NSLayoutConstraint constraintWithItem:self.titltBtn attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *titltBtn_centerY = [NSLayoutConstraint constraintWithItem:self.titltBtn attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [self addConstraints:@[titltBtn_centerX,titltBtn_centerY]];
    
    self.sureBtn .translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *sureBtn_centerY = [NSLayoutConstraint constraintWithItem:self.sureBtn attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    NSLayoutConstraint *sureBtn_right = [NSLayoutConstraint constraintWithItem:self.sureBtn attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-20];
    NSLayoutConstraint *sureBtn_height= [NSLayoutConstraint constraintWithItem:self.sureBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:28];
    [self addConstraints:@[sureBtn_centerY,sureBtn_right]];
    [self.sureBtn addConstraints:@[sureBtn_height]];
    
    self.leaveBtn .translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *leaveBtn_centerY = [NSLayoutConstraint constraintWithItem:self.leaveBtn attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.titltBtn attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    NSLayoutConstraint *leaveBtn_left = [NSLayoutConstraint constraintWithItem:self.leaveBtn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:20];
    [self addConstraints:@[leaveBtn_centerY,leaveBtn_left]];
}
-(void)gobackSelector{
    if(self.gobackBlock){
        self.gobackBlock();
    }
}
-(void)seleBrowserSelector{
    self.isOpen = !self.isOpen;
    [self rotateArrow];
    if(self.selectedBlock){
        self.selectedBlock();
    }
}
-(void)sureSelector{
    if(self.sureBlock){
        self.sureBlock();
    }
}
-(void)setTitle:(NSString *)title{
    _title = title;
    [self.titltBtn setTitle:title forState:UIControlStateNormal];
}

- (void)rotateArrow{
    [UIView animateWithDuration:0.25 animations:^{
        if(self.isOpen){
            self.titltBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        }else{
            self.titltBtn.imageView.transform = CGAffineTransformIdentity;
        }
    }];
}
@end
