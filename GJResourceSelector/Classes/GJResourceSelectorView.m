//
//  GJResourceSelectorView.m
//  GJResourceSelector
//
//  Created by zhanggaoju on 2023/11/13.
//

#import "GJResourceSelectorView.h"
#import "GJResourceManager.h"
#import "GJSelectResourceTableView.h"
#import "GJSelectResourceCollectionView.h"
#import "GJSelectResourceTopBar.h"
#import "GJSelectedAssetsManager.h"
#import <PhotosUI/PhotosUI.h>
//#import "KOIMKitFileLocationHelper.h"

@interface GJResourceSelectorView ()
@property (nonatomic,strong) UIVisualEffectView *effectView;
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) GJSelectResourceTopBar *topBar;
@property (nonatomic,strong) UIButton *titltBtn;
@property (nonatomic,strong) UIButton *selectBtn;
@property (nonatomic, strong) GJSelectResourceCollectionView *collectionView;
@property (nonatomic,strong) GJSelectResourceTableView *tableView;
@property (nonatomic, nullable) GJResourceSelectorCompletedBlock completedBlock;
@property (nonatomic, nullable) GJResourceSelectorCancelBlock  cancelBlock;
@property (nonatomic, nullable) GJResourceClickItemBlock clickItemBlock;
@property (nonatomic, strong) NSArray<PHAssetCollection *> *assetCollections;

@end
@implementation GJResourceSelectorView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.effectView];
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.collectionView];
        [self.contentView addSubview:self.tableView];
        [self.contentView addSubview:self.topBar];
        [self.topBar addSubview:self.titltBtn];
        [self.contentView addSubview:self.selectBtn];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadItemsNoti:) name:GJSelectionResourceNot object:nil];
    }
    return self;
}
-(void)reloadItemsNoti:(NSNotification *)noti{
    [self.collectionView reloadData];
}
-(void)setAssetCollections:(NSArray<PHAssetCollection *> *)assetCollections{
    _assetCollections = assetCollections;
    self.tableView.assetCollections = assetCollections;
    [self selectedAssetCollection:assetCollections.firstObject];
}

-(void)selectedAssetCollection:(PHAssetCollection *)assetCollection{
    self.topBar.title = assetCollection.localizedTitle;
    PHFetchResult *fetchResult = [GJResourceManager.manager assetsInAssetCollection:assetCollection];
    self.collectionView.fetchResult = fetchResult;
}
-(UIVisualEffectView *)effectView{
    if (!_effectView) {
        _effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        _effectView.frame = self.bounds;
    }
    return _effectView;
}
-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [UIView new];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = 15;
        _contentView.layer.masksToBounds = YES;
    }
    return _contentView;
}
-(UIButton *)selectBtn{
    if(!_selectBtn){
        _selectBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, GJResourceScreenHeight-GJResourceStatusHeight-GJResourceTabBarHeight*.8, GJResourceScreenWidth, GJResourceTabBarHeight*.8)];
        [_selectBtn setTitle:@"Go to the photo album and choose some pictures" forState:0];
        [_selectBtn setTitleColor:[UIColor blackColor] forState:0];
        _selectBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _selectBtn.hidden = YES;
        [_selectBtn addTarget:self action:@selector(seletSelector) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}
-(GJSelectResourceTopBar *)topBar{
    if (!_topBar){
        _topBar = [[GJSelectResourceTopBar alloc]initWithFrame:CGRectMake(0, 0, GJResourceScreenWidth, 65)];
        __weak typeof(self) weakSelf = self;
        [_topBar setGobackBlock:^{
            __strong typeof(self) strongSelf = weakSelf;
            [UIView animateWithDuration:.2 animations:^{
                strongSelf.tableView.frame = CGRectMake(0, -(strongSelf.contentView.bounds.size.height-65), GJResourceScreenWidth, strongSelf.contentView.bounds.size.height-65);
                [strongSelf closeDown];
                if (strongSelf.cancelBlock) {
                    strongSelf.cancelBlock(strongSelf);
                    [GJSelectedAssetsManager.manager removeAllSelectedAssets];
                }
            }];
        }];
        [_topBar setSelectedBlock:^{
            __strong typeof(self) strongSelf = weakSelf;
            [strongSelf seleBrowser];
        }];
        [_topBar setSureBlock:^{
            __strong typeof(self) strongSelf = weakSelf;
            [UIView animateWithDuration:.2 animations:^{
                strongSelf.tableView.frame = CGRectMake(0, -(strongSelf.contentView.bounds.size.height-65), GJResourceScreenWidth, strongSelf.contentView.bounds.size.height-65);
                [strongSelf closeDown];
                [strongSelf selectedPhotos];
                [GJSelectedAssetsManager.manager removeAllSelectedAssets];
            }];
        }];
    }
    return _topBar;
}
-(void)selectedPhotos{
    __block NSMutableArray <UIImage *> *photos = [NSMutableArray array];
    __block NSString *videoPath;
    [GJSelectedAssetsManager.manager.allSelectedAssets enumerateObjectsUsingBlock:^(PHAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(GJSelectedAssetsManager.manager.curSeletedMediaType== PHAssetMediaTypeImage){
            CGSize size = CGSizeMake(obj.pixelWidth, obj.pixelHeight);
            PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
            options.resizeMode = PHImageRequestOptionsResizeModeNone;
            options.synchronous = YES;
            [[PHImageManager defaultManager] requestImageForAsset:obj targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                [photos addObject:result];
            }];
        }else if(GJSelectedAssetsManager.manager.curSeletedMediaType== PHAssetMediaTypeVideo){
            PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
            options.networkAccessAllowed = YES;
            [[PHImageManager defaultManager] requestAVAssetForVideo:obj options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
                AVURLAsset *urlAsset = (AVURLAsset *)asset;
                NSString *outputFileName = [GJResourceSelectorHelper genFilenameWithExt:@"mp4"];
                NSString *outputPath = [GJResourceSelectorHelper filepathForVideo:outputFileName];
                AVAssetExportSession *session = [[AVAssetExportSession alloc] initWithAsset:urlAsset presetName:AVAssetExportPresetMediumQuality];
                session.outputURL = [NSURL fileURLWithPath:outputPath];
                // 支持安卓某些机器的视频播放
                session.outputFileType = AVFileTypeMPEG4;
                session.shouldOptimizeForNetworkUse = YES;
                //修正某些播放器不识别视频Rotation的问题
                session.videoComposition = [GJResourceSelectorHelper videoCompositionWithAsset:urlAsset];
                [session exportAsynchronouslyWithCompletionHandler:^(void){
                    videoPath = outputPath;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (self.completedBlock&&videoPath) {
                            self.completedBlock(self ,photos ,videoPath);
                        }
                    });
                 }];
            }];
        }
        if (GJSelectedAssetsManager.manager.curSeletedMediaType== PHAssetMediaTypeImage) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.completedBlock&&(photos||videoPath)) {
                    self.completedBlock(self ,photos ,videoPath);
                }
            });
        }
    }];
}
-(GJSelectResourceCollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake((GJResourceScreenWidth-10*2-5*3)/4, (GJResourceScreenWidth-10*2-5*3)/4);
        flowLayout.minimumLineSpacing = 5;
        flowLayout.minimumInteritemSpacing = 5;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[GJSelectResourceCollectionView alloc] initWithFrame:CGRectMake(0, 65, GJResourceScreenWidth, GJResourceScreenHeight-GJResourceStatusHeight-65-GJResourceTabBarHeight*.8) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        __weak typeof(self) weakSelf = self;
        [_collectionView setClickItemBlock:^(NSInteger index, PHFetchResult * _Nullable fetchResult, GJSelectResourceCollectionView * _Nonnull collectionView) {
            __strong typeof(self) strongSelf = weakSelf;
            strongSelf.clickItemBlock(index, fetchResult, collectionView);
        }];
    }
    return _collectionView;
}
-(GJSelectResourceTableView *)tableView{
    if (!_tableView){
        _tableView = [[GJSelectResourceTableView alloc]initWithFrame:CGRectMake(0, 65, GJResourceScreenWidth, self.contentView.bounds.size.height-self.topBar.bounds.size.height) style:UITableViewStylePlain];
        __weak typeof(self) weakSelf = self;
        [_tableView setSelectedBlock:^(PHAssetCollection * _Nonnull assetCollection) {
            __strong typeof(self) strongSelf = weakSelf;
            [strongSelf selectedAssetCollection:assetCollection];
            [UIView animateWithDuration:.2 animations:^{
                strongSelf.tableView.frame = CGRectMake(0, -(strongSelf.contentView.bounds.size.height-65), GJResourceScreenWidth, strongSelf.contentView.bounds.size.height-65-GJResourceTabBarHeight*.8);
            }];
        }];
    }
    return _tableView;
}
-(void)seleBrowser{
    if (self.tableView.frame.origin.y == 65){
        [UIView animateWithDuration:.2 animations:^{
            self.tableView.frame = CGRectMake(0, -(self.contentView.bounds.size.height-65), GJResourceScreenWidth, self.contentView.bounds.size.height-65);
        }];
    }else{
        [UIView animateWithDuration:.2 animations:^{
            self.tableView.frame = CGRectMake(0, 65, GJResourceScreenWidth, self.contentView.bounds.size.height-65);
        }];
    }
}

+(void)loadWithLimitNumber:(NSInteger)selectLimitNumber mediaType:(GJResourceAssetMediaType)mediaType completedBlock:(nullable GJResourceSelectorCompletedBlock)completedBlock cancelBlock:(nullable GJResourceSelectorCancelBlock)cancelBlock clickItemBlock:(GJResourceClickItemBlock)clickItemBlock{
   
   if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusAuthorized){//用户之前已经授权
        
    }else if([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusDenied){//用户之前已经拒绝授权
        NSLog(@"No permission to access album");
        return;
    }else{
        //弹窗授权时监听
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized){//允许
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self loadWithLimitNumber:selectLimitNumber mediaType:mediaType completedBlock:completedBlock cancelBlock:cancelBlock clickItemBlock:clickItemBlock];
                });
                return;
            }else{//拒绝
                return;
            }
        }];
        return;
    }
   
    GJSelectedAssetsManager.manager.limitNumber = selectLimitNumber;
    GJSelectedAssetsManager.manager.mediaType = mediaType;
    NSArray <PHAssetCollection *>* assetCollections = [GJResourceManager.manager assetCollections];
    GJResourceSelectorView *view = [[GJResourceSelectorView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [[UIApplication sharedApplication].delegate.window addSubview:view];
    view.assetCollections = assetCollections;
    view.completedBlock = completedBlock;
    view.cancelBlock = cancelBlock;
    view.clickItemBlock = clickItemBlock;
    view.effectView.alpha = 0;
    view.contentView.frame = CGRectMake(0, GJResourceScreenHeight, GJResourceScreenWidth, GJResourceScreenHeight-GJResourceStatusHeight);
    [UIView animateWithDuration:.2 animations:^{
        view.effectView.alpha = 0.5;
        view.contentView.frame = CGRectMake(0, GJResourceStatusHeight, GJResourceScreenWidth, GJResourceScreenHeight-GJResourceStatusHeight);
    }];
    if (@available(iOS 14, *)) {
           PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatusForAccessLevel:PHAccessLevelReadWrite];
           if (status == PHAuthorizationStatusLimited) {
               dispatch_async(dispatch_get_main_queue(), ^{
                   view.selectBtn.hidden = NO;
               });
           }else{
               dispatch_async(dispatch_get_main_queue(), ^{
                   view.selectBtn.hidden = YES;
               });
           }
    }
}

-(void)closeDown{
    [[UIApplication sharedApplication].delegate.window.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[self class]]) {
            __block GJResourceSelectorView *view  = obj;
            [UIView animateWithDuration:.2 animations:^{
                view.effectView.alpha = 0;
                view.contentView.frame = CGRectMake(0, GJResourceScreenHeight, GJResourceScreenWidth, GJResourceScreenHeight-GJResourceStatusHeight);
            }completion:^(BOOL finished) {
                [view removeFromSuperview];
                view = nil;
            }];
            *stop = YES;
        }
    }];
}
-(void)seletSelector{
    if (@available(iOS 15, *)) {
        [[PHPhotoLibrary sharedPhotoLibrary] presentLimitedLibraryPickerFromViewController:[GJResourceSelectorHelper currentViewController] completionHandler:^(NSArray<NSString *> * _Nonnull list) {
            NSArray <PHAssetCollection *>* assetCollections = [GJResourceManager.manager assetCollections];
            self.assetCollections = assetCollections;
        }];
    } else {
        // Fallback on earlier versions
    }
}
-(void)dealloc{
    NSLog(@"%s",__func__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

