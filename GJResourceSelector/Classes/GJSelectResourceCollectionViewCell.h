//
//  GJSelectResourceCollectionViewCell.h
//  GJResourceSelector
//
//  Created by zhanggaoju on 2023/11/13.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
NS_ASSUME_NONNULL_BEGIN

@interface GJSelectResourceCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic, strong) PHAsset *asset;
@end

NS_ASSUME_NONNULL_END
