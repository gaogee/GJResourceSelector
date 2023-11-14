//
//  GJSelectResourceTableView.h
//  GJResourceSelector
//
//  Created by zhanggaoju on 2023/11/13.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
NS_ASSUME_NONNULL_BEGIN
typedef void(^GJSelectResourceTableSelectedBlock) (PHAssetCollection *assetCollection);
@interface GJSelectResourceTableView : UITableView
@property (nonatomic, strong) NSArray<PHAssetCollection *> *assetCollections;
@property (nonatomic, copy) GJSelectResourceTableSelectedBlock selectedBlock;
@end

NS_ASSUME_NONNULL_END
