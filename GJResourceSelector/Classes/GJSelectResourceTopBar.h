//
//  GJSelectResourceTopBar.h
//  GJResourceSelector
//
//  Created by zhanggaoju on 2023/11/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^GJSelectResourceTopBarGobackBlock) (void);
typedef void(^GJSelectResourceTopBarSelectedBlock) (void);
typedef void(^GJSelectResourceTopBarSureBlock) (void);
@interface GJSelectResourceTopBar : UIView
@property (nonatomic, strong) NSString *title;
@property (nonatomic, copy) GJSelectResourceTopBarGobackBlock gobackBlock;
@property (nonatomic, copy) GJSelectResourceTopBarSelectedBlock selectedBlock;
@property (nonatomic, copy) GJSelectResourceTopBarSureBlock sureBlock;
@end

NS_ASSUME_NONNULL_END
