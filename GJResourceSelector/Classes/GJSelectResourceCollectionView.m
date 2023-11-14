//
//  GJSelectResourceCollectionView.m
//  GJResourceSelector
//
//  Created by zhanggaoju on 2023/11/13.
//

#import "GJSelectResourceCollectionView.h"
#import "GJSelectResourceCollectionViewCell.h"
#import "GJResourceSelectorHelper.h"
#import "GJSelectedAssetsManager.h"
#import "GJSelectedAssetsManager.h"
@interface GJSelectResourceCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end
@implementation GJSelectResourceCollectionView

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self){
        self.delegate = self;
        self.dataSource = self;
        self.allowsSelection = YES;
        [self registerClass:[GJSelectResourceCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass(GJSelectResourceCollectionViewCell.class)];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadItemsNoti:) name:GJSelectionResourceNot object:nil];
    }
    return self;
}
-(void)reloadItemsNoti:(NSNotification *)noti{
//    NSIndexPath *indexPath = [noti.userInfo valueForKey:@"indexPath"];
//    [self reloadItemsAtIndexPaths:@[indexPath]];
    [self reloadData];
}
#pragma mark --- UICollectionViewDelegate && UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.fetchResult.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GJSelectResourceCollectionViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(GJSelectResourceCollectionViewCell.class) forIndexPath:indexPath];
    cell.asset = self.fetchResult[indexPath.item];
    cell.indexPath = indexPath;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(self.clickItemBlock){
        self.clickItemBlock(indexPath.row, self.fetchResult, self);
    }
}
-(void)setFetchResult:(PHFetchResult *)fetchResult{
    _fetchResult = fetchResult;
    [self reloadData];
}
-(void)dealloc{
    NSLog(@"%s",__func__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
