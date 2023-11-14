//
//  GJSelectResourceTableViewCell.h
//  GJResourceSelector
//
//  Created by zhanggaoju on 2023/11/13.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
NS_ASSUME_NONNULL_BEGIN

@interface GJSelectResourceTableViewCell : UITableViewCell
@property (nonatomic, strong) PHAssetCollection *assetCollection;
@end

NS_ASSUME_NONNULL_END
